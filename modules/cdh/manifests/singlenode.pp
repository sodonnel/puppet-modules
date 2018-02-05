class cdh::singlenode( 
  $hostname            = localhost,
  $yarnavailablememory = 4096,
  $yarnavailablecores  = 8,
  $secure              = false,
  $encryption          = false,
) {

  class {'cdh::config':
    includehive  => true,
    includeyarn  => true,
    namenodehostname        => $hostname,
    resourcemanagerhostname => $hostname,
    metastorehostname       => $hostname,
    mysqlusername           => hive,
    mysqlpassword           => hive123,
    yarnavailablememory     => $yarnavailablememory,
    yarnavailablecores      => $yarnavailablecores,
    secure                  => $secure,
    encryption              => $encryption,
  }

  contain cdh::namenode
  contain cdh::datanode
  contain cdh::initNamenode
  contain cdh::resourceManager
  contain cdh::nodeManager

  Class['cdh::namenode']     ->
  Class['cdh::datanode']     ->
  Class['cdh::initNamenode'] ->
  Class['cdh::resourceManager'] ->
  Class['cdh::nodeManager']     ->
  
  class{ 'cdh::zookeeper':
    secure => $secure,
  }                             ->
  class {'cdh::hbase':
    secure => $secure,
    zookeeper_ensemble => "${hostname}:2181"
  }

  
}
