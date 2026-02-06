set markup csv on
spool output_csv/PHASE_10_VALIDATION.csv
select sql_id,executions,round(elapsed_time/1e6,2) elapsed_sec,buffer_gets
from gv$sql where sql_id='&SQL_ID';
spool off