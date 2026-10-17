#!/bin/sh
# Sauvegardes chiffrées (AES-256), conservées BACKUP_KEEP_DAYS jours :
#   staffflow-<date>.sql.gz.enc        la base de données
#   staffflow-files-<date>.tar.gz.enc  le reste : configuration (.env, Caddy),
#                                      sites hébergés, dépôt Git complet (bundle)
# Chaque nuit à BACKUP_HOUR ; `backup.sh now <étiquette>` en fait une tout de
# suite (avant une migration : `backup.sh now avant-migration-42`).
# Restaurer la base :
#   openssl enc -d -aes-256-cbc -pbkdf2 -pass env:BACKUP_PASSPHRASE -in FICHIER.sql.gz.enc \
#     | gunzip | psql "$DATABASE_URL"
# Restaurer les fichiers :
#   openssl enc -d -aes-256-cbc -pbkdf2 -pass env:BACKUP_PASSPHRASE -in FICHIER.tar.gz.enc | tar -xzf -
#   (le dépôt : git clone staff-flow.bundle staff-flow)
set -eu
set -o pipefail
: "${BACKUP_PASSPHRASE:?BACKUP_PASSPHRASE manquant}"
KEEP="${BACKUP_KEEP_DAYS:-30}"
HOUR="${BACKUP_HOUR:-03}"

seal() { openssl enc -aes-256-cbc -pbkdf2 -salt -pass env:BACKUP_PASSPHRASE -out "$1.tmp" && mv "$1.tmp" "$1"; }

run() {
  label="${1:+$1-}$(date +%Y%m%d-%H%M%S)"
  ok=1
  if pg_dump --no-owner "$DATABASE_URL" | gzip | seal "/backups/staffflow-$label.sql.gz.enc"; then
    echo "Base sauvegardée : staffflow-$label.sql.gz.enc"
  else
    rm -f /backups/*.tmp; ok=0; echo "ÉCHEC de la sauvegarde de la base" >&2
  fi
  # Fichiers : seulement ce qui est monté (dépôt, hébergement).
  work=$(mktemp -d)
  if [ -d /repo/.git ]; then
    git -c safe.directory='*' -C /repo bundle create "$work/staff-flow.bundle" --all >/dev/null 2>&1 || true
    [ -f /repo/deploy/.env ] && cp /repo/deploy/.env "$work/env"
  fi
  [ -d /hosting ] && ln -s /hosting "$work/hosting"
  if [ -n "$(ls -A "$work")" ]; then
    if tar -C "$work" -czhf - . | seal "/backups/staffflow-files-$label.tar.gz.enc"; then
      echo "Fichiers sauvegardés : staffflow-files-$label.tar.gz.enc"
    else
      rm -f /backups/*.tmp; ok=0; echo "ÉCHEC de la sauvegarde des fichiers" >&2
    fi
  fi
  rm -rf "$work"
  find /backups -name 'staffflow-*.enc' -mtime +"$KEEP" -delete
  [ "$ok" = 1 ]
}

if [ "${1:-}" = now ]; then
  run "${2:-}"
  exit $?
fi

while true; do
  # Attendre la prochaine heure de sauvegarde (heure locale, TZ).
  h=$(date +%H); m=$(date +%M); s=$(date +%S)
  since=$(( ${h#0} * 3600 + ${m#0} * 60 + ${s#0} ))
  wait=$(( (${HOUR#0} * 3600 - since + 86400) % 86400 ))
  [ "$wait" -eq 0 ] && wait=86400
  sleep "$wait"
  run "" || true
done
