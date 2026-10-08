# staff-flow

Organisation des plannings de travail des entreprises : application Android et site web
(Flutter, un seul code) reliés à une API Dart hébergée sur un serveur OVH.

| Dossier   | Contenu                                                                 |
| --------- | ----------------------------------------------------------------------- |
| `app/`    | Application Flutter (Android + web)                                      |
| `server/` | API Dart (shelf) + PostgreSQL, migrations appliquées au démarrage       |
| `deploy/` | Docker Compose pour le serveur : PostgreSQL, API, Caddy (HTTPS), sauvegardes |

## État : phases 1 et 2

**Phase 1 — fondations**

- Connexion uniquement avec un compte Google ; chaque utilisateur reçoit un identifiant unique (`SF-XXXXXXXX`).
- Entreprises, avec un rôle par entreprise : propriétaire, responsable, salarié, extra.
- Un onglet par entreprise dans l'application.
- Le propriétaire nomme ou retire les responsables ; un responsable gère les salariés et les extras.
- Transfert de propriété : le propriétaire désigne un responsable, qui doit accepter.
- Un membre retiré garde son historique ; un salarié peut quitter une entreprise.
- Journal des actions sensibles (`audit_log`).
- Serveur : HTTPS automatique (Let's Encrypt), sauvegardes quotidiennes chiffrées conservées 30 jours.

**Phase 2 — planning**

- Sites et postes ; services sur un ou plusieurs jours, de nuit compris.
- Répétition chaque jour ou certains jours de la semaine, jusqu'à une date ou N fois ; une occurrence se modifie seule sans casser la série.
- Brouillon puis publication : les salariés voient la dernière version publiée.
- Remplacement d'une personne par une autre sur une période.
- Vues semaine et mois ; filtre « mes services » ; total d'heures de la période.
- Ajout par code à 6 chiffres (2 minutes, usage unique, confirmé par le salarié, blocage 2 minutes après 3 erreurs).

## Développement local (Windows)

Prérequis : Flutter 3.47.6 (contient Dart 3.13.5).

```bash
# API avec connexion de test (sans Google)
cd server
DATABASE_URL=postgresql://… SESSION_SECRET=une-chaine-d-au-moins-32-caracteres-xx DEV_LOGIN=true ALLOWED_ORIGINS=http://localhost:5050 dart run bin/server.dart

# Application web, branchée sur cette API
cd app
flutter run -d chrome --web-port 5050 --dart-define=API_URL=http://localhost:8080 --dart-define=DEV_LOGIN=true
```

L'API exige PostgreSQL (`DATABASE_URL=postgresql://…`).

Tests :

```bash
# Tests de l'API sur un PostgreSQL jetable, sur le serveur (conteneurs supprimés ensuite)
tool/test-server.sh
# ou avec une base locale : TEST_DATABASE_URL=postgresql://… dart test
cd app && flutter test
```

## Connexion Google (à faire une fois)

Dans la [Google Cloud Console](https://console.cloud.google.com/apis/credentials) :

1. Créer un projet, puis configurer l'écran de consentement OAuth.
2. Créer un identifiant **OAuth « Application Web »**, avec comme origine JavaScript autorisée `https://<ton domaine>` (et `http://localhost:5050` pour le développement). Cet identifiant sert à la fois de `GOOGLE_WEB_CLIENT_ID` et de `GOOGLE_CLIENT_IDS`.
3. Créer un identifiant **OAuth « Android »** avec le nom de package `com.staffflow.staff_flow` et l'empreinte SHA-1 de la clé de signature. Il n'a pas besoin d'être renseigné dans l'application.

## Déploiement sur le serveur OVH (Debian 13)

```bash
# Docker
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
echo "deb [signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Code et configuration
git clone https://github.com/lyupeii-cloud/staff-flow.git && cd staff-flow
cp deploy/.env.example deploy/.env   # puis le remplir
docker compose -f deploy/docker-compose.yml --env-file deploy/.env up -d --build
```

Le nom de domaine doit pointer vers le serveur, et les ports 80 et 443 doivent être ouverts : Caddy obtient alors le certificat HTTPS tout seul.

Les sauvegardes sont enregistrées dans `BACKUP_DIR`, `/var/backups/staff-flow` par défaut. La commande de restauration est en tête de `deploy/backup/backup.sh`. Il faut aussi copier ces sauvegardes hors du serveur, par exemple avec l'espace de sauvegarde FTP fourni par OVH.
