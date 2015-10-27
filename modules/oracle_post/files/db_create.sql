startup nomount

spool install.log

create database ora11gr2
  logfile   group 1 ('/u01/app/oracle/oradata/ora11gr2/redo1.log') size 50M,
            group 2 ('/u01/app/oracle/oradata/ora11gr2/redo2.log') size 50M,
            group 3 ('/u01/app/oracle/oradata/ora11gr2/redo3.log') size 50M
  character set          al32utf8
  national character set utf8
  datafile '/u01/app/oracle/oradata/ora11gr2/system.dbf' 
            size 50M
            autoextend on 
            next 10M
            extent management local
  sysaux datafile '/u01/app/oracle/oradata/ora11gr2/sysaux.dbf' 
            size 10M
            autoextend on 
            next 10M 
  undo tablespace undo
            datafile '/u01/app/oracle/oradata/ora11gr2/undo.dbf'
            size 10M
            autoextend on
  default temporary tablespace temp
            tempfile '/u01/app/oracle/oradata/ora11gr2/temp.dbf'
            size 10M
            autoextend on;

@$ORACLE_HOME/rdbms/admin/catalog.sql
@$ORACLE_HOME/rdbms/admin/catproc.sql

alter user system account unlock;
alter user system identified by system;

connect system/system

@$ORACLE_HOME/sqlplus/admin/pupbld.sql

connect / as sysdba

CREATE TABLESPACE users DATAFILE '/u01/app/oracle/oradata/ora11gr2/users_01.dbf' 
    SIZE 50M
    autoextend on 
    maxsize 5000M
    EXTENT MANAGEMENT LOCAL AUTOALLOCATE;


create user app identified by app
default tablespace users temporary tablespace temp;

grant connect, create session, dba to app;

spool off
