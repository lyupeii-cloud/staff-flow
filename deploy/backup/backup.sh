#!/bin/sh
# Sauvegarde quotidienne chiffrée (AES-256), conservée BACKUP_KEEP_DAYS jours.
# Restaurer :
#   openssl enc -d -aes-256-cbc -pbkdf2 -pass env:BACKUP_PASSPHRASE -in FICHIER.sql.gz.enc \
#     | gunzip | psql "$DATABASE_URL"
set -eu
set -o pipefail
: "${BACKUP_PASSPHRASE:?BACKUP_PASSPHRASE manquant}"
KEEP="${BACKUP_KEEP_DAYS:-30}"
HOUR="${BACKUP_HOUR:-03}"

while true; do
  # Attendre la prochaine heure de sauvegarde (heure locale, TZ).
  h=$(date +%H); m=$(date +%M); s=$(date +%S)
  since=$(( ${h#0} * 3600 + ${m#0} * 60 + ${s#0} ))
  wait=$(( (${HOUR#0} * 3600 - since + 86400) % 86400 ))
  [ "$wait" -eq 0 ] && wait=86400
  sleep "$wait"

  file="/backups/staffflow-$(date +%Y%m%d-%H%M%S).sql.gz.enc"
  if pg_dump --no-owner "$DATABASE_URL" | gzip | \
      openssl enc -aes-256-cbc -pbkdf2 -salt -pass env:BACKUP_PASSPHRASE -out "$file.tmp"; then
    mv "$file.tmp" "$file"
    echo "Sauvegarde OK : $file"
  else
    rm -f "$file.tmp"
    echo "ÉCHEC de la sauvegarde" >&2
  fi
  find /backups -name 'staffflow-*.sql.gz.enc' -mtime +"$KEEP" -delete
done
