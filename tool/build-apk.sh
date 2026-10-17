#!/bin/sh
# APK de production signé (arm64) : adresse de l'API et identifiant client
# Google (public) compris. Exige app/android/key.properties et la clé.
# Résultat : dist/Staff-Flow-<version>-arm64.apk
set -eu
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/app"
flutter build apk --release --split-per-abi --target-platform android-arm64 \
  --dart-define=API_URL=https://app.staff-flow.cloud \
  --dart-define=GOOGLE_WEB_CLIENT_ID=971132277831-1oco3slk71e7rnia5cfap7qc4gvk77mu.apps.googleusercontent.com
VERSION=$(sed -n 's/^version: *\([^+]*\).*/\1/p' pubspec.yaml)
mkdir -p "$ROOT/dist"
cp build/app/outputs/flutter-apk/app-arm64-v8a-release.apk "$ROOT/dist/Staff-Flow-$VERSION-arm64.apk"
echo "APK : dist/Staff-Flow-$VERSION-arm64.apk"
