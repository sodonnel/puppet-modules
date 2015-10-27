class oracle_prereqs::response {

  file { '/home/oracle/db_install.rsp':
    source => 'puppet:///modules/oracle_prereqs/db_install.rsp',
    owner  => 'oracle',
  }

}