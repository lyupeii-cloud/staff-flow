/// Migrations SQL, appliquées dans l'ordre au démarrage du serveur.
/// Ne jamais modifier une migration déjà déployée : en ajouter une nouvelle.
const migrations = <String>[
  // 1 — comptes, entreprises, rôles, transferts, journal
  '''
CREATE TABLE users (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  public_id   text NOT NULL UNIQUE,
  google_sub  text NOT NULL UNIQUE,
  email       text NOT NULL,
  name        text NOT NULL,
  photo_url   text,
  created_at  timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE companies (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text NOT NULL,
  timezone    text NOT NULL,
  status      text NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'readOnly')),
  created_at  timestamptz NOT NULL DEFAULT now()
);

-- Un départ est daté (left_at) au lieu d'effacer la ligne : l'historique reste.
CREATE TABLE memberships (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id  uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  user_id     uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role        text NOT NULL CHECK (role IN ('owner', 'manager', 'employee', 'extra')),
  joined_at   timestamptz NOT NULL DEFAULT now(),
  left_at     timestamptz
);
CREATE UNIQUE INDEX memberships_active ON memberships (company_id, user_id) WHERE left_at IS NULL;
CREATE UNIQUE INDEX memberships_one_owner ON memberships (company_id) WHERE role = 'owner' AND left_at IS NULL;
CREATE INDEX memberships_user ON memberships (user_id) WHERE left_at IS NULL;

CREATE TABLE ownership_transfers (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id   uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  from_user_id uuid NOT NULL REFERENCES users(id),
  to_user_id   uuid NOT NULL REFERENCES users(id),
  status       text NOT NULL DEFAULT 'pending'
               CHECK (status IN ('pending', 'accepted', 'declined', 'cancelled')),
  created_at   timestamptz NOT NULL DEFAULT now(),
  resolved_at  timestamptz
);
CREATE UNIQUE INDEX transfers_one_pending ON ownership_transfers (company_id) WHERE status = 'pending';

CREATE TABLE audit_log (
  id          bigserial PRIMARY KEY,
  company_id  uuid REFERENCES companies(id) ON DELETE SET NULL,
  actor_id    uuid REFERENCES users(id) ON DELETE SET NULL,
  action      text NOT NULL,
  details     jsonb NOT NULL DEFAULT '{}',
  at          timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX audit_log_company ON audit_log (company_id, at);
''',

  // 2 — planning : sites, postes, services, séries ; ajout par code à 6 chiffres
  '''
CREATE TABLE sites (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id  uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  name        text NOT NULL,
  archived_at timestamptz,
  created_at  timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX sites_company ON sites (company_id);

CREATE TABLE positions (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id  uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  name        text NOT NULL,
  archived_at timestamptz,
  created_at  timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX positions_company ON positions (company_id);

CREATE TABLE shift_series (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id  uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  rule        jsonb NOT NULL,
  created_by  uuid REFERENCES users(id) ON DELETE SET NULL,
  created_at  timestamptz NOT NULL DEFAULT now()
);

-- Heures locales de l'entreprise : jour + minutes depuis minuit.
-- end_min peut dépasser 1440 pour un service de nuit (fin le lendemain).
-- « published » garde la version vue par les salariés jusqu'à la publication suivante.
CREATE TABLE shifts (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id  uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  series_id   uuid REFERENCES shift_series(id) ON DELETE SET NULL,
  day         date NOT NULL,
  start_min   int NOT NULL CHECK (start_min BETWEEN 0 AND 1439),
  end_min     int NOT NULL CHECK (end_min > start_min AND end_min <= start_min + 1440),
  user_id     uuid REFERENCES users(id) ON DELETE SET NULL,
  site_id     uuid REFERENCES sites(id),
  position_id uuid REFERENCES positions(id),
  note        text,
  detached    boolean NOT NULL DEFAULT false,
  deleted     boolean NOT NULL DEFAULT false,
  dirty       boolean NOT NULL DEFAULT true,
  published   jsonb,
  updated_by  uuid REFERENCES users(id) ON DELETE SET NULL,
  updated_at  timestamptz NOT NULL DEFAULT now(),
  created_at  timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX shifts_company_day ON shifts (company_id, day);
CREATE INDEX shifts_user_day ON shifts (user_id, day);
CREATE INDEX shifts_series ON shifts (series_id);
CREATE INDEX shifts_dirty ON shifts (company_id) WHERE dirty;

CREATE TABLE join_codes (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code        text NOT NULL,
  user_id     uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  expires_at  timestamptz NOT NULL,
  used_at     timestamptz
);
CREATE UNIQUE INDEX join_codes_active ON join_codes (code) WHERE used_at IS NULL;

CREATE TABLE join_requests (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id  uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  user_id     uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role        text NOT NULL CHECK (role IN ('employee', 'extra')),
  invited_by  uuid REFERENCES users(id) ON DELETE SET NULL,
  status      text NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'declined')),
  created_at  timestamptz NOT NULL DEFAULT now(),
  resolved_at timestamptz
);
CREATE UNIQUE INDEX join_requests_one_pending ON join_requests (company_id, user_id) WHERE status = 'pending';

CREATE TABLE join_attempts (
  id          bigserial PRIMARY KEY,
  manager_id  uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  company_id  uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  ip          text NOT NULL,
  success     boolean NOT NULL,
  at          timestamptz NOT NULL
);
CREATE INDEX join_attempts_recent ON join_attempts (at) WHERE NOT success;
''',

  // 3 — langue du compte Google (« fr », « uk », « en-GB »…), si Google la fournit
  'ALTER TABLE users ADD COLUMN locale text;',

  // 4 — hors connexion : versions, historique, avis, requêtes rejouées
  '''
-- Augmente à chaque modification ; le client renvoie la version qu'il a vue
-- pour qu'on sache s'il écrase le travail d'un autre responsable.
ALTER TABLE shifts ADD COLUMN version int NOT NULL DEFAULT 1;

-- Qui a changé quoi et quand, service par service ; « before » et « after »
-- sont l'état complet du service (null : il n'existait pas / plus).
CREATE TABLE shift_history (
  id          bigserial PRIMARY KEY,
  company_id  uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  shift_id    uuid NOT NULL,
  actor_id    uuid REFERENCES users(id) ON DELETE SET NULL,
  action      text NOT NULL CHECK (action IN ('create', 'update', 'delete', 'undo')),
  before      jsonb,
  after       jsonb,
  at          timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX shift_history_company ON shift_history (company_id, at DESC);
CREATE INDEX shift_history_shift ON shift_history (shift_id, at DESC);

-- Avis affichés dans l'application (et envoyés en notification en phase 4).
CREATE TABLE notices (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  company_id  uuid REFERENCES companies(id) ON DELETE CASCADE,
  kind        text NOT NULL,
  data        jsonb NOT NULL DEFAULT '{}',
  created_at  timestamptz NOT NULL DEFAULT now(),
  read_at     timestamptz
);
CREATE INDEX notices_user ON notices (user_id, created_at DESC);

-- Une modification rejouée après une coupure (même clé) n'est appliquée qu'une fois.
CREATE TABLE idempotency_keys (
  user_id     uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  key         text NOT NULL,
  status      int NOT NULL,
  body        text NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, key)
);
''',
  // 5 — noms personnalisés : par la personne (partout) et par un responsable
  // (dans son entreprise). Le nom Google reste dans users.name.
  '''
ALTER TABLE users ADD COLUMN custom_name text;
ALTER TABLE memberships ADD COLUMN display_name text;
''',
  // 6 — notifications : appareils (jeton Firebase) et familles coupées par chacun
  '''
CREATE TABLE push_devices (
  token       text PRIMARY KEY,
  user_id     uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  platform    text NOT NULL CHECK (platform IN ('android', 'web')),
  language    text,
  created_at  timestamptz NOT NULL DEFAULT now(),
  seen_at     timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX push_devices_user ON push_devices (user_id);
ALTER TABLE users ADD COLUMN notification_prefs jsonb NOT NULL DEFAULT '{}';
''',
  // 7 — messagerie : un groupe par entreprise, des conversations privées
  // (une par paire de personnes), les messages et ce que chacun a lu.
  '''
CREATE TABLE conversations (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id  uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  kind        text NOT NULL CHECK (kind IN ('group', 'private')),
  -- Conversation privée : les deux personnes, dans l'ordre (user_a < user_b).
  user_a      uuid REFERENCES users(id) ON DELETE CASCADE,
  user_b      uuid REFERENCES users(id) ON DELETE CASCADE,
  created_at  timestamptz NOT NULL DEFAULT now(),
  CHECK ((kind = 'group') = (user_a IS NULL AND user_b IS NULL))
);
CREATE UNIQUE INDEX conversations_group ON conversations (company_id) WHERE kind = 'group';
CREATE UNIQUE INDEX conversations_pair ON conversations (company_id, user_a, user_b) WHERE kind = 'private';

CREATE TABLE messages (
  id               bigserial PRIMARY KEY,
  conversation_id  uuid NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
  author_id        uuid REFERENCES users(id) ON DELETE SET NULL,
  body             text NOT NULL,
  created_at       timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX messages_conversation ON messages (conversation_id, id DESC);

CREATE TABLE conversation_reads (
  conversation_id  uuid NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
  user_id          uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  last_read_id     bigint NOT NULL DEFAULT 0,
  PRIMARY KEY (conversation_id, user_id)
);
''',
  // 8 — groupes de discussion créés par un responsable, avec les personnes choisies
  '''
ALTER TABLE conversations DROP CONSTRAINT conversations_kind_check;
ALTER TABLE conversations ADD CONSTRAINT conversations_kind_check CHECK (kind IN ('group', 'private', 'team'));
-- Seule une conversation privée désigne ses deux personnes directement.
ALTER TABLE conversations DROP CONSTRAINT conversations_check;
ALTER TABLE conversations ADD CONSTRAINT conversations_pair_check
  CHECK ((kind = 'private') = (user_a IS NOT NULL AND user_b IS NOT NULL));
ALTER TABLE conversations ADD COLUMN name text;
ALTER TABLE conversations ADD COLUMN created_by uuid REFERENCES users(id) ON DELETE SET NULL;

CREATE TABLE conversation_members (
  conversation_id  uuid NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
  user_id          uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  added_at         timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (conversation_id, user_id)
);
CREATE INDEX conversation_members_user ON conversation_members (user_id);
''',
  // 9 — messages : réponse à un message, personnes citées avec « # »,
  // traductions gardées pour ne pas retraduire.
  '''
ALTER TABLE messages ADD COLUMN reply_to bigint REFERENCES messages(id) ON DELETE SET NULL;
ALTER TABLE messages ADD COLUMN mentions jsonb NOT NULL DEFAULT '[]';
CREATE INDEX messages_author ON messages (conversation_id, author_id, id DESC);

CREATE TABLE message_translations (
  message_id  bigint NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
  lang        text NOT NULL,
  body        text NOT NULL,
  PRIMARY KEY (message_id, lang)
);
''',
  // 10 — avis lus supprimés automatiquement après un jour, une semaine ou un mois
  '''
ALTER TABLE users ADD COLUMN notice_retention text NOT NULL DEFAULT 'week'
  CHECK (notice_retention IN ('day', 'week', 'month'));
''',
  // 11 — sites de chacun : un responsable sur toute l'entreprise (NULL) ou
  // sur certains sites ; un salarié ou un extra rattaché à des sites (son
  // équipe). Une invitation peut déjà préciser les sites.
  '''
ALTER TABLE memberships ADD COLUMN sites uuid[];
ALTER TABLE join_requests ADD COLUMN sites uuid[];
''',
  // 12 — demandes : échange de service (proposé à un collègue ou à tous ceux
  // du même poste, accepté par lui, validé par un responsable), congé et
  // indisponibilité (validés par un responsable).
  '''
CREATE TABLE requests (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id    uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  kind          text NOT NULL CHECK (kind IN ('swap', 'leave', 'unavailability')),
  status        text NOT NULL CHECK (status IN ('pending_peer', 'pending_manager', 'approved', 'refused', 'cancelled')),
  requester_id  uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  -- Échange : le collègue qui reprend le service (choisi, ou le premier qui
  -- accepte une offre ouverte à tous ceux du même poste).
  peer_id       uuid REFERENCES users(id) ON DELETE SET NULL,
  open_offer    boolean NOT NULL DEFAULT false,
  shift_id      uuid REFERENCES shifts(id) ON DELETE SET NULL,
  shift_version int,
  -- Congé et indisponibilité : période, et jours de la semaine (1 = lundi)
  -- pour une indisponibilité qui revient chaque semaine.
  start_day     date,
  end_day       date,
  weekdays      int[],
  note          text,
  decided_by    uuid REFERENCES users(id) ON DELETE SET NULL,
  created_at    timestamptz NOT NULL DEFAULT now(),
  updated_at    timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX requests_company ON requests (company_id, status);
''',
  // 13 — demande devenue sans objet (service changé, période passée) ;
  // sites dont un responsable veut recevoir les notifications (null : tous).
  '''
ALTER TABLE requests DROP CONSTRAINT requests_status_check;
ALTER TABLE requests ADD CONSTRAINT requests_status_check
  CHECK (status IN ('pending_peer', 'pending_manager', 'approved', 'refused', 'cancelled', 'expired'));
CREATE INDEX requests_list ON requests (company_id, created_at DESC);
ALTER TABLE memberships ADD COLUMN notify_sites uuid[];
ALTER TABLE shift_history DROP CONSTRAINT shift_history_action_check;
ALTER TABLE shift_history ADD CONSTRAINT shift_history_action_check
  CHECK (action IN ('create', 'update', 'delete', 'undo', 'revert'));
''',
  // 14 — chevauchements entre entreprises déjà signalés (une seule
  // notification par paire de services).
  '''
CREATE TABLE overlap_alerts (
  shift_a uuid NOT NULL REFERENCES shifts(id) ON DELETE CASCADE,
  shift_b uuid NOT NULL REFERENCES shifts(id) ON DELETE CASCADE,
  created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (shift_a, shift_b)
);
''',
  // 15 — demandes affichées dans les conversations, avec leurs boutons.
  '''
ALTER TABLE messages ADD COLUMN request_id uuid REFERENCES requests(id) ON DELETE SET NULL;
''',
  // 16 — outils du responsable : alertes légales choisies, droit
  // d'impression des salariés ; lien d'agenda personnel.
  '''
ALTER TABLE companies ADD COLUMN legal_rules jsonb;
ALTER TABLE companies ADD COLUMN print_scope text NOT NULL DEFAULT 'team' CHECK (print_scope IN ('own', 'team'));
ALTER TABLE users ADD COLUMN calendar_token text UNIQUE;
''',
  // 17 — sous-responsable : responsable de site nommé par un autre
  // responsable (qui peut le retirer).
  '''
ALTER TABLE memberships ADD COLUMN appointed_by uuid REFERENCES users(id) ON DELETE SET NULL;
''',
  // 18 — notifications coupées pour une entreprise (l'avis reste dans la cloche).
  '''
ALTER TABLE memberships ADD COLUMN notifications_off boolean NOT NULL DEFAULT false;
''',
  // 19 — préréglages d'horaires, groupe de l'entreprise activable par le
  // patron, image de l'entreprise, groupes de messagerie en sourdine.
  '''
ALTER TABLE companies ADD COLUMN shift_presets jsonb;
ALTER TABLE companies ADD COLUMN group_enabled boolean NOT NULL DEFAULT true;
ALTER TABLE companies ADD COLUMN logo bytea;
ALTER TABLE companies ADD COLUMN logo_version int NOT NULL DEFAULT 0;
CREATE TABLE conversation_mutes (
  conversation_id uuid NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
  user_id         uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  PRIMARY KEY (conversation_id, user_id)
);
''',
  // 20 — salarié d'un autre site placé par un responsable de site : le
  // service attend la validation de son supérieur ou du patron.
  '''
ALTER TABLE shifts ADD COLUMN approval_by uuid REFERENCES users(id) ON DELETE SET NULL;
''',
  // 21 — sites en cascade (3 niveaux au plus) : un responsable d'un site
  // gère aussi tous ceux qui sont en dessous.
  '''
ALTER TABLE sites ADD COLUMN parent_id uuid REFERENCES sites(id) ON DELETE CASCADE;
CREATE INDEX sites_parent ON sites (parent_id);
''',
  // 22 — messagerie activée par le patron : désactivée pour les nouvelles
  // entreprises, gardée pour celles qui existent déjà.
  '''
ALTER TABLE companies ADD COLUMN messaging_enabled boolean NOT NULL DEFAULT true;
ALTER TABLE companies ALTER COLUMN messaging_enabled SET DEFAULT false;
''',
  // 23 — réglages de la plateforme modifiés par l'administration (tarifs,
  // durées) ; les autres gardent la valeur du fichier de configuration.
  '''
CREATE TABLE platform_settings (
  key        text PRIMARY KEY,
  value      bigint NOT NULL,
  updated_by uuid REFERENCES users(id) ON DELETE SET NULL,
  updated_at timestamptz NOT NULL DEFAULT now()
);
''',
  // 24 — abonnement de chaque entreprise : essai (une fois par compte Google),
  // payée, lecture seule puis suppression, ou offerte ; factures. Les
  // entreprises existantes commencent un essai de 2 jours.
  '''
ALTER TABLE users ADD COLUMN trial_started_at timestamptz;
ALTER TABLE companies
  ADD COLUMN billing_status text NOT NULL DEFAULT 'trial'
    CHECK (billing_status IN ('trial', 'active', 'grace', 'comped')),
  ADD COLUMN trial_ends_at timestamptz,
  ADD COLUMN paid_until timestamptz,
  ADD COLUMN grace_ends_at timestamptz,
  ADD COLUMN billing_period text CHECK (billing_period IN ('month', 'year')),
  ADD COLUMN cascade_option boolean NOT NULL DEFAULT false,
  ADD COLUMN invoice_by_email boolean NOT NULL DEFAULT true,
  ADD COLUMN billing_reminders text[] NOT NULL DEFAULT '{}';
UPDATE companies SET trial_ends_at = now() + interval '2 days';
UPDATE users SET trial_started_at = now()
  WHERE id IN (SELECT user_id FROM memberships WHERE role = 'owner');
CREATE SEQUENCE invoice_number_seq;
CREATE TABLE invoices (
  id            bigserial PRIMARY KEY,
  number        text NOT NULL UNIQUE,
  company_id    uuid REFERENCES companies(id) ON DELETE SET NULL,
  company_name  text NOT NULL,
  owner_id      uuid REFERENCES users(id) ON DELETE SET NULL,
  owner_name    text,
  owner_email   text,
  issued_at     timestamptz NOT NULL,
  period        text NOT NULL CHECK (period IN ('month', 'year')),
  period_start  timestamptz NOT NULL,
  period_end    timestamptz NOT NULL,
  staff         int NOT NULL,
  lines         jsonb NOT NULL,
  amount_cents  int NOT NULL,
  provider      text NOT NULL,
  provider_ref  text,
  paid_at       timestamptz NOT NULL,
  emailed_at    timestamptz
);
CREATE INDEX invoices_company ON invoices (company_id, id);
''',
  // 25 — identifiant public de chaque entreprise (sur ses factures :
  // SF-<identifiant>-<année>-<n°>) ; plus d'envoi des factures par e-mail.
  '''
ALTER TABLE companies ADD COLUMN public_id text;
UPDATE companies SET public_id = (
  SELECT string_agg(substr('ABCDEFGHJKLMNPQRSTUVWXYZ23456789', 1 + floor(random() * 32)::int, 1), '')
  FROM generate_series(1, 6) WHERE companies.id IS NOT NULL);
ALTER TABLE companies ALTER COLUMN public_id SET NOT NULL;
ALTER TABLE companies ADD CONSTRAINT companies_public_id UNIQUE (public_id);
ALTER TABLE companies DROP COLUMN invoice_by_email;
ALTER TABLE invoices ADD COLUMN company_code text;
UPDATE invoices i SET company_code = c.public_id FROM companies c WHERE c.id = i.company_id;
UPDATE invoices SET company_code = '' WHERE company_code IS NULL;
ALTER TABLE invoices ALTER COLUMN company_code SET NOT NULL;
ALTER TABLE invoices DROP COLUMN owner_email, DROP COLUMN emailed_at;
DROP SEQUENCE invoice_number_seq;
''',
  // 26 — comptes : suppression (fantôme qu'on peut réactiver, ou effacement
  // définitif), Telegram vérifié (affiché par entreprise, sert à reprendre
  // son compte avec un autre compte Google) ; vendeur figé sur chaque
  // facture ; factures d'une entreprise fermée gardées pour son dernier patron.
  '''
ALTER TABLE users
  ADD COLUMN deleted_at timestamptz,
  ADD COLUMN erased boolean NOT NULL DEFAULT false,
  ADD COLUMN telegram_chat_id bigint UNIQUE,
  ADD COLUMN telegram_username text,
  ADD COLUMN telegram_linked_at timestamptz;
ALTER TABLE memberships ADD COLUMN show_telegram boolean NOT NULL DEFAULT false;
CREATE TABLE telegram_links (
  token       text PRIMARY KEY,
  user_id     uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  expires_at  timestamptz NOT NULL
);
CREATE TABLE account_recoveries (
  new_user_id  uuid PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  old_user_id  uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  code_hash    text NOT NULL,
  attempts     int NOT NULL DEFAULT 0,
  sent_at      timestamptz NOT NULL,
  expires_at   timestamptz NOT NULL
);
CREATE TABLE platform_texts (
  key        text PRIMARY KEY,
  value      text NOT NULL,
  updated_by uuid REFERENCES users(id) ON DELETE SET NULL,
  updated_at timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE invoices
  ADD COLUMN seller jsonb,
  ADD COLUMN holder_id uuid REFERENCES users(id) ON DELETE SET NULL;
UPDATE invoices SET holder_id = owner_id WHERE company_id IS NULL;
CREATE INDEX invoices_holder ON invoices (holder_id) WHERE company_id IS NULL;
CREATE INDEX invoices_code ON invoices (company_code);
''',
  // 27 — avatars choisis par chacun ; photos Google masquées par le patron
  // dans son entreprise ; option « accès API » et clés API.
  '''
ALTER TABLE users ADD COLUMN avatar jsonb;
ALTER TABLE companies
  ADD COLUMN hide_photos boolean NOT NULL DEFAULT false,
  ADD COLUMN api_option boolean NOT NULL DEFAULT false;
CREATE TABLE api_keys (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id   uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  name         text NOT NULL,
  prefix       text NOT NULL UNIQUE,
  key_hash     text NOT NULL,
  created_by   uuid REFERENCES users(id) ON DELETE SET NULL,
  created_at   timestamptz NOT NULL DEFAULT now(),
  last_used_at timestamptz,
  revoked_at   timestamptz
);
CREATE INDEX api_keys_company ON api_keys (company_id);
''',
  // 28 — changement de compte Google : par le bot (adresse confirmée, 10
  // minutes pour se connecter) ou par un lien du patron ; version des
  // sessions (l'augmenter déconnecte tous les appareils).
  '''
ALTER TABLE users ADD COLUMN session_version int NOT NULL DEFAULT 0;
CREATE TABLE google_switches (
  user_id     uuid PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  email       text NOT NULL,
  expires_at  timestamptz NOT NULL
);
CREATE TABLE google_switch_links (
  token_hash  text PRIMARY KEY,
  user_id     uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  company_id  uuid REFERENCES companies(id) ON DELETE CASCADE,
  created_by  uuid REFERENCES users(id) ON DELETE SET NULL,
  expires_at  timestamptz NOT NULL,
  used_at     timestamptz
);
''',
  // 29 — liens de connexion envoyés par le bot (/connexion) : une fois, 5 minutes.
  '''
CREATE TABLE telegram_logins (
  token_hash  text PRIMARY KEY,
  user_id     uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  created_at  timestamptz NOT NULL,
  expires_at  timestamptz NOT NULL,
  used_at     timestamptz
);
CREATE INDEX telegram_logins_user ON telegram_logins (user_id, created_at);
''',
  // 30 — matricule donné par l'employeur (en plus de l'identifiant SF) et
  // poste habituel du salarié (regroupements, filtres, importation).
  '''
ALTER TABLE memberships ADD COLUMN employee_number text;
ALTER TABLE memberships ADD COLUMN position_id uuid REFERENCES positions(id) ON DELETE SET NULL;
CREATE UNIQUE INDEX memberships_employee_number ON memberships (company_id, lower(employee_number))
  WHERE left_at IS NULL AND employee_number IS NOT NULL;
''',
  // 31 — importation : invitations personnelles (code + QR code, ou e-mail Google).
  '''
CREATE TABLE member_invites (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id      uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  code            text NOT NULL UNIQUE,
  name            text NOT NULL,
  email           text,
  employee_number text,
  position_id     uuid REFERENCES positions(id) ON DELETE SET NULL,
  sites           uuid[],
  created_by      uuid REFERENCES users(id) ON DELETE SET NULL,
  created_at      timestamptz NOT NULL DEFAULT now(),
  expires_at      timestamptz NOT NULL,
  used_by         uuid REFERENCES users(id) ON DELETE SET NULL,
  used_at         timestamptz
);
CREATE INDEX member_invites_company ON member_invites (company_id) WHERE used_at IS NULL;
CREATE INDEX member_invites_email ON member_invites (lower(email)) WHERE used_at IS NULL;
ALTER TABLE join_requests ADD COLUMN invite_id uuid REFERENCES member_invites(id) ON DELETE SET NULL;
''',
  // 32 — fil d'actualités (remplace la messagerie ; companies.messaging_enabled
  // devient l'interrupteur du fil, actif par défaut).
  '''
CREATE TABLE announcements (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id  uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  author_id   uuid REFERENCES users(id) ON DELETE SET NULL,
  title       text,
  body        text NOT NULL,
  audience    jsonb NOT NULL DEFAULT '{}',
  everyone    boolean NOT NULL DEFAULT false,
  created_at  timestamptz NOT NULL DEFAULT now(),
  edited_at   timestamptz
);
CREATE INDEX announcements_company ON announcements (company_id, created_at DESC);
CREATE TABLE announcement_recipients (
  announcement_id uuid NOT NULL REFERENCES announcements(id) ON DELETE CASCADE,
  user_id         uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  PRIMARY KEY (announcement_id, user_id)
);
CREATE INDEX announcement_recipients_user ON announcement_recipients (user_id);
CREATE TABLE announcement_reads (
  announcement_id uuid NOT NULL REFERENCES announcements(id) ON DELETE CASCADE,
  user_id         uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  read_at         timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (announcement_id, user_id)
);
CREATE TABLE announcement_translations (
  announcement_id uuid NOT NULL REFERENCES announcements(id) ON DELETE CASCADE,
  lang            text NOT NULL,
  title           text,
  body            text NOT NULL,
  PRIMARY KEY (announcement_id, lang)
);
ALTER TABLE companies ALTER COLUMN messaging_enabled SET DEFAULT true;
UPDATE companies SET messaging_enabled = true;
''',
  // 33 — la messagerie est retirée : tous ses messages sont effacés (décision du 12/10/2026).
  '''
DROP TABLE IF EXISTS message_translations, conversation_mutes, conversation_reads, conversation_members, messages, conversations CASCADE;
ALTER TABLE companies DROP COLUMN IF EXISTS group_enabled;
''',
  // 34 — gestion de l'abonnement confiée par le patron (comptable…), et
  // factures d'une option ajoutée en cours d'abonnement.
  '''
ALTER TABLE memberships ADD COLUMN billing_access boolean NOT NULL DEFAULT false;
ALTER TABLE invoices DROP CONSTRAINT IF EXISTS invoices_period_check;
ALTER TABLE invoices ADD CONSTRAINT invoices_period_check CHECK (period IN ('month', 'year', 'addon'));
''',
  // 35 — option « non renouvelée » : active jusqu'à cette date, puis retirée.
  '''
ALTER TABLE companies ADD COLUMN api_until timestamptz, ADD COLUMN cascade_until timestamptz;
''',
  // 36 — congé validé dont la personne demande l'annulation (en attente d'un
  // responsable) ; indisponibilité terminée plus tôt.
  '''
ALTER TABLE requests ADD COLUMN cancel_requested_at timestamptz, ADD COLUMN ended_early boolean NOT NULL DEFAULT false;
''',
  // 37 — places (salariés et responsables) achetées : 10 à la création,
  // par tranches de 10 jusqu'à 5000 ; le prix se calcule sur les places.
  '''
ALTER TABLE companies ADD COLUMN slots int NOT NULL DEFAULT 10;
UPDATE companies c SET slots = greatest(10, ceil((SELECT count(*) FROM memberships m
  WHERE m.company_id = c.id AND m.left_at IS NULL AND m.role IN ('manager', 'employee')) / 10.0)::int * 10);
''',
  // 38 — comptes sans Google : application 2FA (secret chiffré), codes de
  // secours, nouveau code d'activation, essais de connexion.
  '''
ALTER TABLE users ADD COLUMN totp_secret text, ADD COLUMN totp_last_step bigint, ADD COLUMN backup_codes text[];
ALTER TABLE member_invites ADD COLUMN user_id uuid REFERENCES users(id) ON DELETE CASCADE;
CREATE TABLE auth_failures (key text NOT NULL, at timestamptz NOT NULL);
CREATE INDEX auth_failures_key ON auth_failures (key, at);
''',
  // 39 — option « API Pro » (écriture) et droits de chaque clé API.
  '''
ALTER TABLE companies ADD COLUMN api_pro_option boolean NOT NULL DEFAULT false, ADD COLUMN api_pro_until timestamptz;
ALTER TABLE api_keys ADD COLUMN scopes text[] NOT NULL DEFAULT '{read}';
''',
  // 40 — webhooks (option « API Pro ») : adresses abonnées et envois signés.
  '''
CREATE TABLE webhooks (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id  uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  url         text NOT NULL,
  events      text[] NOT NULL,
  secret      text NOT NULL,
  created_by  uuid REFERENCES users(id) ON DELETE SET NULL,
  created_at  timestamptz NOT NULL DEFAULT now(),
  disabled_at timestamptz,
  failures    int NOT NULL DEFAULT 0
);
CREATE INDEX webhooks_company ON webhooks (company_id);
CREATE TABLE webhook_deliveries (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  webhook_id   uuid NOT NULL REFERENCES webhooks(id) ON DELETE CASCADE,
  event        text NOT NULL,
  payload      jsonb NOT NULL,
  status       text NOT NULL DEFAULT 'pending',
  attempts     int NOT NULL DEFAULT 0,
  next_at      timestamptz NOT NULL,
  last_status  int,
  last_error   text,
  delivered_at timestamptz,
  created_at   timestamptz NOT NULL
);
CREATE INDEX webhook_deliveries_due ON webhook_deliveries (next_at) WHERE status = 'pending';
CREATE INDEX webhook_deliveries_hook ON webhook_deliveries (webhook_id, created_at);
''',
  // 41 — journaux des clés API : chaque appel et chaque webhook ; mois
  // anciens archivés compressés ; adresses IP vues par clé ; alertes.
  '''
CREATE TABLE api_logs (
  id          bigserial PRIMARY KEY,
  company_id  uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  at          timestamptz NOT NULL,
  key_id      uuid REFERENCES api_keys(id) ON DELETE SET NULL,
  key_name    text,
  key_prefix  text,
  source      text NOT NULL,
  kind        text NOT NULL,
  method      text,
  path        text,
  action      text NOT NULL,
  details     jsonb NOT NULL DEFAULT '{}',
  status      int NOT NULL,
  ok          boolean NOT NULL,
  error       jsonb,
  duration_ms int NOT NULL,
  ip          text,
  search      text NOT NULL
);
CREATE INDEX api_logs_company ON api_logs (company_id, id DESC);
CREATE INDEX api_logs_key ON api_logs (key_id, at);
CREATE TABLE api_log_archives (
  company_id uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  month      date NOT NULL,
  count      int NOT NULL,
  data       bytea NOT NULL,
  PRIMARY KEY (company_id, month)
);
CREATE TABLE api_key_ips (
  key_id   uuid NOT NULL REFERENCES api_keys(id) ON DELETE CASCADE,
  ip       text NOT NULL,
  first_at timestamptz NOT NULL,
  PRIMARY KEY (key_id, ip)
);
ALTER TABLE api_keys ADD COLUMN failing_alert_at timestamptz, ADD COLUMN new_ip_alert_at timestamptz;
''',
  // 42 — petits états internes du serveur (profil du bot Telegram déjà envoyé…).
  '''
CREATE TABLE server_state (
  key   text PRIMARY KEY,
  value text NOT NULL
);
''',
  // 43 — formules API : « API Pro » pour 1 ou 5 clés (et celle du prochain
  // renouvellement), clés désactivées au-delà de la formule, accès API
  // coupé depuis (suppression des clés après 30 jours, prévenue avant).
  '''
ALTER TABLE companies ADD COLUMN api_pro_keys int NOT NULL DEFAULT 1, ADD COLUMN api_pro_next_keys int,
  ADD COLUMN api_off_since timestamptz, ADD COLUMN api_off_warned boolean NOT NULL DEFAULT false;
ALTER TABLE api_keys ADD COLUMN disabled_at timestamptz;
''',
  // 44 — « API Pro » : la grande formule passe de 5 à 10 clés.
  '''
UPDATE companies SET api_pro_keys = 10 WHERE api_pro_keys = 5;
UPDATE companies SET api_pro_next_keys = 10 WHERE api_pro_next_keys = 5;
''',
];
