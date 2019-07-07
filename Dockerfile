FROM python:3-slim

# https://github.com/dbcli/mssql-cli/blob/master/doc/installation/linux.md#debian-9
RUN set -ex; \
  savedAptMark="$(apt-mark showmanual)"; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    gnupg \
    wget \
    apt-transport-https; \
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add -; \
  echo "deb [arch=amd64] https://packages.microsoft.com/debian/9/prod stretch main" | tee /etc/apt/sources.list.d/mssql-cli.list; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    libssl1.0-dev \
    mssql-cli; \
  apt-mark auto '.*' > /dev/null; \
  apt-mark manual $savedAptMark \
    libssl1.0-dev \
    mssql-cli; \
  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
  rm -rf /var/lib/apt/lists/*;

CMD ["mssql-cli"]
