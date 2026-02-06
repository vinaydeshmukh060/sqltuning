set markup csv on
spool output_csv/PHASE_13_ASH_TIMELINE.csv
select inst_id,to_char(sample_time,'YYYY-MM-DD HH24:MI') minute,
       nvl(wait_class,'CPU') wait_class,count(*) samples
from gv$active_session_history
where sql_id='&SQL_ID' and (&CON_ID=0 or con_id=&CON_ID)
group by inst_id,to_char(sample_time,'YYYY-MM-DD HH24:MI'),wait_class
order by minute;
spool off