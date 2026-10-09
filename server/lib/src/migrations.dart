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
];
