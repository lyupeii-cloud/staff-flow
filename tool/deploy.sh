#!/bin/sh
# Met le serveur à jour depuis la branche demandes : sauvegarde d'abord, puis
# reconstruction de l'API et de l'application web (migrations au démarrage).
# Usage : tool/deploy.sh [nom de la sauvegarde]
set -eu
HOST="${STAFF_FLOW_SSH:-debian@ns537187.ip-139-99-130.net}"
LABEL="${1:-avant-deploiement}"
git push -q origin demandes
ssh -o BatchMode=yes "$HOST" "set -eu; cd staff-flow
  C='sudo -n docker compose -f deploy/docker-compose.yml --env-file deploy/.env'
  \$C exec -T backup backup.sh now $LABEL
  git pull -q --rebase origin demandes
  \$C up -d --build api web"
curl -fsS https://app.staff-flow.cloud/api/v1/health && echo
