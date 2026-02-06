#!/bin/bash
# Oracle environment validation (READ-ONLY)

if [[ -z "$ORACLE_HOME" || -z "$ORACLE_SID" ]]; then
  echo "ERROR: ORACLE_HOME or ORACLE_SID not set"
  exit 1
fi

export PATH=$ORACLE_HOME/bin:$PATH

IS_CDB=$(sqlplus -s / as sysdba <<EOF
set pages 0 feed off
select cdb from v\$database;
EOF
)

DB_ROLE=$(sqlplus -s / as sysdba <<EOF
set pages 0 feed off
select database_role from v\$database;
EOF
)

export IS_CDB DB_ROLE
