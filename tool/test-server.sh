#!/bin/sh
# Lance les tests de l'API sur le serveur, contre un PostgreSQL jetable
# (conteneurs supprimés à la fin). Envoie l'état local du dossier server/.
# Usage : tool/test-server.sh [arguments de dart test]
set -eu
HOST="${STAFF_FLOW_SSH:-debian@ns537187.ip-139-99-130.net}"
cd "$(dirname "$0")/../server"
tar --exclude=.dart_tool -czf - . | ssh -o BatchMode=yes "$HOST" '
  set -eu
  D="sudo -n docker"; W=$(mktemp -d); trap "$D rm -f sf-test-db >/dev/null 2>&1; $D network rm sf-test >/dev/null 2>&1; sudo -n rm -rf $W" EXIT
  tar -xzf - -C "$W"
  $D network create sf-test >/dev/null
  $D run -d --rm --name sf-test-db --network sf-test -e POSTGRES_PASSWORD=test -e POSTGRES_DB=sftest postgres:17-alpine >/dev/null
  i=0; until $D exec sf-test-db pg_isready -U postgres -d sftest >/dev/null 2>&1; do i=$((i+1)); [ $i -gt 30 ] && exit 1; sleep 1; done
  $D run --rm --network sf-test -v "$W":/src -w /src \
    -e TEST_DATABASE_URL="postgresql://postgres:test@sf-test-db:5432/sftest?sslmode=disable" \
    dart:3.13.5 sh -c "dart pub get >/dev/null && dart test '"$*"'"
'
