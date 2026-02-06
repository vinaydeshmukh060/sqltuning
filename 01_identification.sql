set markup csv on
spool output_csv/PHASE_1_IDENTIFICATION.csv
select inst_id,sql_id,executions,round(elapsed_time/1e6,2) elapsed_sec
from gv$sql where sql_id='&SQL_ID' and (&CON_ID=0 or con_id=&CON_ID);
spool off