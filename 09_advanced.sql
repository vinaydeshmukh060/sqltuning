set markup csv on
spool output_csv/PHASE_9_ADVANCED.csv
select sql_id,count(*) child_cursors
from gv$sql where sql_id='&SQL_ID'
group by sql_id;
spool off