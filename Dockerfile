FROM python:3-slim

# https://github.com/dbcli/mssql-cli/blob/master/doc/installation/linux.md#debian-9
# https://github.com/dbcli/mssql-cli/blob/master/doc/installation/macos.md#macos-installation
RUN set -ex; \
	pip install mssql-cli

CMD ["mssql-cli"]
