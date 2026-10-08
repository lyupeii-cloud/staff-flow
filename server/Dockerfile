FROM dart:3.13.5 AS build
WORKDIR /src
COPY pubspec.yaml pubspec.lock ./
RUN dart pub get
COPY . .
RUN dart compile exe bin/server.dart -o /src/server

FROM debian:trixie-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates \
    && rm -rf /var/lib/apt/lists/* && useradd --system --no-create-home api
COPY --from=build /src/server /usr/local/bin/staff-flow-api
USER api
EXPOSE 8080
CMD ["staff-flow-api"]
