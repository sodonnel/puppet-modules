class cdh::oozie(
  $secure = false,           # Setup for kerberos or not
  $dbhost    = 'localhost',  # Mysql DB hostname name (port is hardcoded in config file)
  $dbuser    = 'oozieuser',  # User to connect to mysql as
  $dbpass    = 'secret',     # Password to use to connect to mysql
  $enabled   = true,         # True to start the service and ensure it is running
  $namenodehostname = 'namenode',
){

  class { 'cdh::oozie::config':
    secure => $secure,
    dbhost => $dbhost,
    dbuser => $dbuser,
    dbpass => $dbpass,
    namenodehostname => $namenodehostname,
  }
  
  class {'cdh::oozie::service':
    enabled => $enabled
  }

  contain cdh::oozie::install
  contain cdh::oozie::config
  contain cdh::oozie::service
  
  Class['cdh::oozie::install']          ->
  Class['cdh::oozie::config']           ->
  Class['cdh::oozie::service'] 

}