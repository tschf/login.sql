REM whilst setting up the environment, I will turn off termout. After everything
REM is set up as I like it, I will turn it back on so everything behaves as
REM expect
set termout off

define _editor=vim

REM I like to have serveroutput on by default. Set with a large size so I can
REM have lots of output.
set serveroutput on size 100000

REM Since I like mode code to be within the 80 character boundary, I will start
REM with SQL*Plus set to the same width.
set linesize 80

REM I do not need SQL*Plus to continually print the column headers, so I will
REM use a large pagesize
set pagesize 9999

REM The default length of object_name is too long. Reduce the default width
REM so the query is more readable on the screen. Add any other commonly queried
REM table columns.
column objecT_name format a30

define gname=idle
column global_name new_value gname
with instance_info as (
    select
        global_name
      , instr(global_name, '.') dot_index
    from 
        global_name
)
select
    lower(user) 
        || '@' 
        || substr(global_name, 1, decode(dot_index, 0, length(global_name), dot_index-1)) global_name
from instance_info;

set sqlprompt '&gname> '

REM We are all done now, so we can turn termout back on
set termout on