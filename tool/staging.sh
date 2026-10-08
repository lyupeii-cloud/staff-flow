#!/bin/sh
# API de test jetable sur le serveur (base vide, connexion de test activée),
# joignable seulement depuis le serveur sur 127.0.0.1:18099. La production n'est pas touchée.
#   tool/staging.sh up     envoie server/ et démarre l'API de test
#   tool/staging.sh down   supprime les conteneurs et la base de test
# Depuis ce PC : ssh -N -L 8099:127.0.0.1:18099 "$STAFF_FLOW_SSH"
# puis l'application avec --dart-define=API_URL=http://localhost:8099 --dart-define=DEV_LOGIN=true
set -eu
HOST="${STAFF_FLOW_SSH:-debian@ns537187.ip-139-99-130.net}"
case "${1:-}" in
up)
  cd "$(dirname "$0")/../server"
  tar --exclude=.dart_tool -czf - . | ssh -o BatchMode=yes "$HOST" '
    set -e
    D="sudo -n docker"; W=/tmp/sf-staging
    $D rm -f sf-stg-api sf-stg-db >/dev/null 2>&1 || true
    $D network rm sf-stg >/dev/null 2>&1 || true
    sudo -n rm -rf $W; mkdir -p $W; tar -xzf - -C $W
    $D network create sf-stg >/dev/null
    $D run -d --name sf-stg-db --network sf-stg -e POSTGRES_PASSWORD=stg -e POSTGRES_DB=stg postgres:17-alpine >/dev/null
    until $D exec sf-stg-db pg_isready -U postgres -d stg >/dev/null 2>&1; do sleep 1; done
    $D run -d --name sf-stg-api --network sf-stg -p 127.0.0.1:18099:8080 -v $W:/src -w /src \
      -e DATABASE_URL="postgresql://postgres:stg@sf-stg-db:5432/stg?sslmode=disable" \
      -e SESSION_SECRET=staging-only-secret-0123456789abcdef -e DEV_LOGIN=true \
      -e ALLOWED_ORIGINS=http://localhost:5050 \
      dart:3.13.5 sh -c "dart pub get >/dev/null && dart run bin/server.dart" >/dev/null
    for i in $(seq 1 60); do curl -s 127.0.0.1:18099/health && exit 0; sleep 2; done; exit 1'
  echo " API de test prête." ;;
down)
  ssh -o BatchMode=yes "$HOST" 'sudo -n docker rm -f sf-stg-api sf-stg-db >/dev/null 2>&1; sudo -n docker network rm sf-stg >/dev/null 2>&1; sudo -n rm -rf /tmp/sf-staging; echo "API de test supprimée."' ;;
*) echo "usage : $0 up|down" >&2; exit 2 ;;
esac
