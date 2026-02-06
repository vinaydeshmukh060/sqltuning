set markup csv on
spool output_csv/PHASE_5_INDEXES.csv
select index_name,table_name,status,uniqueness
from dba_indexes
where table_name in (
 select object_name from gv$sql_plan
 where sql_id='&SQL_ID'
);
spool off