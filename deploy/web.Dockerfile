# Compile le site Flutter puis le sert avec Caddy (HTTPS automatique).
FROM debian:trixie-slim AS build
RUN apt-get update && apt-get install -y --no-install-recommends \
      git curl unzip xz-utils ca-certificates \
    && rm -rf /var/lib/apt/lists/*
ARG FLUTTER_VERSION=3.47.6
RUN git clone --depth 1 -b ${FLUTTER_VERSION} https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"
RUN flutter config --no-analytics && flutter precache --web
WORKDIR /app
COPY app/pubspec.yaml app/pubspec.lock ./
RUN flutter pub get
COPY app/ ./
ARG GOOGLE_WEB_CLIENT_ID
RUN flutter build web --release --dart-define=GOOGLE_WEB_CLIENT_ID=${GOOGLE_WEB_CLIENT_ID}

FROM caddy:2.10-alpine
COPY deploy/Caddyfile /etc/caddy/Caddyfile
COPY --from=build /app/build/web /srv
