#!/bin/sh
# Génère le site vitrine (pages, CGV, doc API) et le publie sur staff-flow.cloud.
set -eu
HOST="${STAFF_FLOW_SSH:-debian@ns537187.ip-139-99-130.net}"
cd "$(dirname "$0")/../site"
dart tool/build.dart
tar -czf - -C www . | ssh -o BatchMode=yes "$HOST" 'cd /home/debian/hosting/www/staff-flow.cloud && tar -xzf -'
echo "Site publié."
