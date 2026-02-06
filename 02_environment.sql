set markup csv on
spool output_csv/PHASE_2_ENVIRONMENT.csv
select inst_id,metric_name,value
from gv$sysmetric
where metric_name in ('Host CPU Utilization (%)','Database CPU Time Ratio');
spool off