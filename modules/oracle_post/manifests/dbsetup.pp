class oracle_post::dbsetup {

  file { '/u01/app/oracle/oradata':
    ensure => 'directory',
    owner  => 'oracle',
    group  => 'dba',
  }

  ->

  file { '/u01/app/oracle/oradata/ora11gr2':
    ensure => 'directory',
    owner  => 'oracle',
    group  => 'dba',
  }

  ->

  file { '/home/oracle/db_create.sql':
    source => 'puppet:///modules/oracle_post/db_create.sql',
    owner  => 'oracle',
  }

  ->

  file { '/u01/app/oracle/product/11.2.0.4/dbhome_1/dbs/initora11gr2.ora':
    source => 'puppet:///modules/oracle_post/initora11gr2.ora',
    owner  => 'oracle',
    group  => 'dba',
  }

  
}