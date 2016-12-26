i#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE ROLE nailgun WITH LOGIN PASSWORD 'nailgun;
    CREATE USER nailgun;
    CREATE DATABASE nailgun;
    GRANT ALL PRIVILEGES ON DATABASE nailgun TO nailgun;
EOSQL
