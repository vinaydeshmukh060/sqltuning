set markup csv on
spool output_csv/PHASE_11_ASH_BREAKDOWN.csv
select inst_id,nvl(wait_class,'CPU') wait_class,count(*) samples
from gv$active_session_history
where sql_id='&SQL_ID' and (&CON_ID=0 or con_id=&CON_ID)
group by inst_id,wait_class;
spool off