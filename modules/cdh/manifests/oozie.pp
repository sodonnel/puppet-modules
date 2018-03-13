class cdh::oozie(
  $install   = 'true',
  $secure    = false,        # Setup for kerberos or not
  $dbhost    = 'localhost',  # Mysql DB hostname name (port is hardcoded in config file)
  $dbuser    = 'oozieuser',  # User to connect to mysql as
  $dbpass    = 'secret',     # Password to use to connect to mysql
  $enabled   = true,         # True to start the service and ensure it is running
  $namenodehostname = 'namenode',
){

  if ($install == 'true') {
    class {'cdh::oozie::install':}  ->
    class {'cdh::oozie::db':}       ->
    class {'cdh::oozie::config':}   ->
    class {'cdh::oozie::service':
      enabled => $enabled
    }
  }
  
}