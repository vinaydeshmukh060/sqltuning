set markup csv on
spool output_csv/PHASE_7_BINDS.csv
select sql_id,executions,parse_calls,child_number,is_bind_sensitive,is_bind_aware
from gv$sql where sql_id='&SQL_ID';
spool off