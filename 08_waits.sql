set markup csv on
spool output_csv/PHASE_8_WAITS.csv
select inst_id,event,round(time_waited/1e2,2) time_waited_sec
from gv$system_event
where wait_class<>'Idle';
spool off