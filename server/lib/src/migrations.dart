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
];
