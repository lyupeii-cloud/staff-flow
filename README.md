# Staff Flow

Plannings d'équipe en SaaS : site web et application Android (Flutter, un seul code), API Dart
et PostgreSQL sur un serveur OVH. Production : https://app.staff-flow.cloud — site : https://staff-flow.cloud

Branche de travail : `demandes` (le serveur la suit).

| Dossier   | Contenu |
| --------- | ------- |
| `app/`    | Application Flutter (web + Android). Textes : `lib/l10n/app_*.arb` (10 langues) |
| `server/` | API Dart (shelf) + PostgreSQL ; migrations appliquées au démarrage. Messages : `lib/src/messages/` |
| `site/`   | Site vitrine statique : `tool/build.dart` (pages), `tool/legal.dart` (CGV, confidentialité), `tool/api_docs.dart` (doc API) → `www/` ; `staff-flow.cloud.caddy` à copier dans `/home/debian/hosting/sites/` s'il change |
| `deploy/` | Docker Compose du serveur : PostgreSQL, API, Caddy (HTTPS), sauvegardes chiffrées, bot Telegram |
| `tool/`   | Scripts : tests, déploiement, site, APK, environnement de test |

Les achats (abonnement, options, « API Pro ») se font seulement sur le site web ; l'application
Android affiche l'abonnement en lecture seule (`app/lib/src/purchases.dart`).

## Commandes

Prérequis : Flutter 3.47.6 (Dart 3.13.5), accès SSH au serveur.

```bash
sh tool/test-server.sh -r compact      # tests de l'API, sur un PostgreSQL jetable du serveur
cd app && flutter analyze && flutter test
sh tool/staging.sh up                  # API de test (tunnel http://localhost:8099), puis « down »
sh tool/deploy.sh                      # sauvegarde, puis mise à jour de l'API et de l'application web
sh tool/publish-site.sh                # génère et publie staff-flow.cloud
sh tool/build-apk.sh                   # APK signé (arm64) dans dist/
```

Application web branchée sur l'API de test :

```bash
cd app && flutter run -d chrome --web-port 5050 --dart-define=API_URL=http://localhost:8099 --dart-define=DEV_LOGIN=true
```

L'APK de production exige `app/android/key.properties` et la clé de signature (jamais dans le dépôt).
Les fichiers produits (APK, tableurs…) vont dans `dist/`, ignoré par git.

## Langues

Ajouter une langue : un fichier `.arb`, un fichier de messages serveur et une ligne dans
`appLanguages` (`app/lib/src/i18n.dart`) ; les tests vérifient que rien ne manque.

## Serveur (Debian, Docker)

```bash
git clone https://github.com/lyupeii-cloud/staff-flow.git && cd staff-flow
cp deploy/.env.example deploy/.env   # puis le remplir
sudo docker compose -f deploy/docker-compose.yml --env-file deploy/.env up -d --build
```

Sauvegardes : `/home/debian/backups/staff-flow`, chiffrées ; restauration décrite en tête de
`deploy/backup/backup.sh`.
