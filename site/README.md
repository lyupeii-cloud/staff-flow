# Site vitrine — staff-flow.cloud

Site statique (aucun script), séparé de l'application.

- `tool/build.dart` : textes FR / UK / EN et génération des pages (`dart tool/build.dart` depuis `site/`).
- `www/` : fichiers publiés (pages générées, style, captures, police Nunito).
- `staff-flow.cloud.caddy` : configuration Caddy (redirection de « / » selon la langue du navigateur).

## Publier

    tar -C www -czf /tmp/site.tgz . && scp /tmp/site.tgz staff-flow.cloud.caddy debian@ns537187.ip-139-99-130.net:/tmp/
    # sur le serveur :
    tar -C /home/debian/hosting/www/staff-flow.cloud -xzf /tmp/site.tgz
    cp /tmp/staff-flow.cloud.caddy /home/debian/hosting/sites/   # seulement si la configuration a changé
    sudo docker exec staff-flow-web-1 caddy validate --config /etc/caddy/Caddyfile --adapter caddyfile
    sudo docker exec staff-flow-web-1 caddy reload --config /etc/caddy/Caddyfile --adapter caddyfile

Les captures viennent de l'émulateur Android, avec des données de démonstration fictives.
