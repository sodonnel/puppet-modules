class cdh::zookeeper(
  $secure = false,    # Setup for kerberos or not
  $quorm  = [],       # pass the hostnames as a list, eg ['host1', 'host2', 'host3']
  $instance_id = '1', # The server ID require for multi node ZK quorms
  $enabled = true     # True to start the service and ensure it is running
){

  class { 'cdh::zookeeper::config':
    secure => $secure,
    quorm  => $quorm,
    instance_id => $instance_id,
  }
  
  class {'cdh::zookeeper::service':
    enabled => $enabled
  }

  contain cdh::zookeeper::install
  contain cdh::zookeeper::config
  contain cdh::zookeeper::service
  
  Class['cdh::zookeeper::install']          ->
  Class['cdh::zookeeper::config']           ->
  Class['cdh::zookeeper::service'] 

}