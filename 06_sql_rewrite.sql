set markup csv on
spool output_csv/PHASE_6_SQL_REWRITE.csv
select sql_id,
 case when instr(sql_text,'TO_CHAR')>0 then 'FUNCTION_ON_COLUMN' end issue
from gv$sql where sql_id='&SQL_ID';
spool off