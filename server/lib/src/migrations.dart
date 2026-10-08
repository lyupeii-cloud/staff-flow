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
];
