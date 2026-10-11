#!/bin/sh
# APK de production : adresse de l'API et identifiant client Google (public) compris.
# Sans ces réglages, l'application affiche « Serveur injoignable ».
set -eu
cd "$(dirname "$0")/../app"
flutter build apk --release \
  --dart-define=API_URL=https://app.staff-flow.cloud \
  --dart-define=GOOGLE_WEB_CLIENT_ID=971132277831-1oco3slk71e7rnia5cfap7qc4gvk77mu.apps.googleusercontent.com
