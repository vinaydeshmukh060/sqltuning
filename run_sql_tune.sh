#!/bin/bash
# Oracle SQL Tuning Framework – FULL CHECKLIST MODE (READ-ONLY)
# Version : v7 | 19c+ | RAC | CDB/PDB aware
#
# Usage:
#   ./run_sql_tune.sh -s <SQL_ID> [-p <PDB_NAME>]
#
# Example:
#   ./run_sql_tune.sh -s 01uy9sb7w8a9g -p FINPDB
#
usage(){ grep '^#' "$0"|sed 's/^# //'; exit 1; }

while getopts "s:p:h" opt; do
  case $opt in
    s) SQL_ID=$OPTARG ;;
    p) PDB_NAME=$OPTARG ;;
    h) usage ;;
  esac
done

[[ -z "$SQL_ID" ]] && usage

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
mkdir -p "$SCRIPT_DIR/output_csv"

LOG="$SCRIPT_DIR/run_sql_tune_$(date +%Y%m%d_%H%M%S).log"
exec > >(tee -a "$LOG") 2>&1

echo "=== Oracle SQL Tuning Framework v7 ==="
echo "SQL_ID   : $SQL_ID"
echo "PDB_NAME : ${PDB_NAME:-N/A}"
echo "Log File : $LOG"

source "$SCRIPT_DIR/env/db_env.sh"

if [[ "$IS_CDB" == "YES" && -n "$PDB_NAME" ]]; then
  CON_ID=$(sqlplus -s / as sysdba <<EOF
set pages 0 feed off
select con_id from v\$pdbs where name=upper('$PDB_NAME');
EOF
)
else
  CON_ID=0
fi

export SQL_ID CON_ID

for f in "$SCRIPT_DIR"/sql/*.sql; do
  echo "Running $(basename $f)"
  sqlplus -s / as sysdba <<EOF
set echo off term off verify off
define SQL_ID='$SQL_ID'
define CON_ID='$CON_ID'
@$f
exit;
EOF
done

echo "=== Completed. CSV files in output_csv/ ==="
