# Copyright (c) IntechCore GmbH - All Rights Reserved
# SPDX-License-Identifier: APACHE-2.0

FROM postgres:16-bookworm

ENV POSTGRES_PASSWORD="polarion" \
    POSTGRES_USER="polarion" \
    POSTGRES_DB="polarion" \
    POSTGRES_INITDB_ARGS="-E utf8 --auth-host=md5"

COPY ./init-polarion-db.sh /docker-entrypoint-initdb.d/

