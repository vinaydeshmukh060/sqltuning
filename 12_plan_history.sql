set markup csv on
spool output_csv/PHASE_12_PLAN_HISTORY.csv
select sql_id,plan_hash_value,
 min(first_load_time) first_seen,
 max(last_active_time) last_seen
from gv$sql where sql_id='&SQL_ID'
group by sql_id,plan_hash_value;
spool off