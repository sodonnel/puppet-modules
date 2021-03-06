class cdh::singlenode( 
  $hostname            = localhost,
  $yarnavailablememory = 4096,
  $yarnavailablecores  = 8,
  $secure              = false,
  $encryption          = false,
  $install_hue         = true,
  $install_oozie       = true,
  $install_search      = true
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
  }                             ->

  class{ 'cdh::namenode': }     ->
  class{ 'cdh::datanode': }     ->
  class{ 'cdh::initNamenode': } ->
  class{ 'cdh::resourceManager': } ->
  class{ 'cdh::nodeManager':     } ->
  
  class{ 'cdh::zookeeper':
    secure => $secure,
  }                             ->
  class {'cdh::hbase':
    secure => $secure,
    zookeeper_ensemble => "${hostname}:2181"
  }                             ->
  class {'cdh::hive':
    secure => $secure,
    metastorehostname => $hostname
  }                             ->
  # Sentry only gets installed if we are secure. There is no non secure option.
  class {'cdh::sentry':
    install => $secure
  }                             ->
  class {'cdh::sqoop1::install':} ->
  class {'cdh::oozie':
    install          => $install_oozie,
    secure           => $secure,
    namenodehostname => $hostname
  }                             ->
  class {'cdh::search':
    install             => $install_search,
    namenodehostname    => $hostname,
    zookeeper_ensemble  => "${hostname}:2181/solr",
    enabled             => true,
    secure              => $secure
  }                             ->
  class {'cdh::hue':
    install                 => $install_hue,
    namenodehostname        => $hostname,
    metastorehostname       => $hostname,
    resourcemanagerhostname => $hostname,
    secure                  => $secure
  } 
}