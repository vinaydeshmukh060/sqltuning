set markup csv on
spool output_csv/PHASE_4_STATS.csv
select table_name,last_analyzed,stale_stats
from dba_tab_statistics
where table_name in (
 select object_name from gv$sql_plan
 where sql_id='&SQL_ID'
);
spool off