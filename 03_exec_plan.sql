set markup csv on
spool output_csv/PHASE_3_EXEC_PLAN.csv
select inst_id,plan_hash_value,
       sum(cardinality) e_rows,
       sum(last_output_rows) a_rows,
       round(sum(last_output_rows)/nullif(sum(cardinality),0),2) row_mismatch
from gv$sql_plan_statistics_all
where sql_id='&SQL_ID' and (&CON_ID=0 or con_id=&CON_ID)
group by inst_id,plan_hash_value;
spool off