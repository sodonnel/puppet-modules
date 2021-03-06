class cdh::local(
  $hostname            = localhost,
  $yarnavailablememory = 4096,
  $yarnavailablecores  = 8,
  $secure              = false,
  $encryption          = false,
)
{

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

  class {'cdh::metastore::mysql':
    mysqluser         => hive,
    mysqlpasswordhash => '*FB73BCDD6050E0F3F73E0262950F4D9E0092769C',
  }

  class {'cdh::metastore::config':
    secure   => $secure,
  }

  class {'cdh::zookeeper':
    secure   => $secure,
  }

  class {'cdh::oozie':
    secure   => $secure,
    namenodehostname => $hostname,
  }

  contain cdh::zookeeper
  contain cdh::oozie

  contain cdh::namenode::install
  contain cdh::namenode::format
  contain cdh::namenode::tmpdir
  contain cdh::namenode::vagrantdir
  contain cdh::namenode::service


  contain cdh::datanode::install
  contain cdh::datanode::config
  contain cdh::datanode::service


  contain cdh::resourcemanager::install
  contain cdh::resourcemanager::config
  contain cdh::resourcemanager::service

  contain cdh::metastore::install
  contain cdh::metastore::mysql
  contain cdh::metastore::config
  contain cdh::metastore::service

  contain cdh::hue::install
  class {'cdh::hue::config':
    namenodehostname        => $hostname,
    resourcemanagerhostname => $hostname,
    metastorehostname       => $hostname,
    secure                  => $secure,
  }
  contain cdh::hue::service
  contain cdh::sqoop1::install

  class {'cdh::search':
    secure => $secure,
    namenodehostname => $hostname,
    zookeeper_ensemble => "${hostname}:2181/solr"
  }

  class {'cdh::hbase':
    secure => $secure,
    namenodehostname => $hostname,
    zookeeper_ensemble => "${hostname}:2181"
  }

#  # Only install Sentry is we are Secure. Its always secure
#  # so just use the secure = true to switch the install flag
#  class {'cdh::sentry':
#    install => $secure
#  }

  Class['cdh::namenode::install']           ->
  Class['cdh::datanode::install']           ->
  Class['cdh::resourcemanager::install']    ->
  Class['cdh::metastore::install']          ->
  Class['cdh::hue::install']                ->
  Class['cdh::search::install']             ->
  Class['cdh::hbase::install']              ->
  Class['cdh::metastore::mysql']            ->
  Class['cdh::config']                      ->
  Class['cdh::zookeeper']                   ->
  Class['cdh::namenode::format']            ->
  Class['cdh::namenode::service']           ->
  Class['cdh::namenode::vagrantdir']        ->
  Class['cdh::resourcemanager::service']    ->
  Class['cdh::datanode::config']            ->
  Class['cdh::datanode::service']           ->
  # This needs to be moved down from after the namenode service
  # as it tries to load libs etc which requires a datanode to be up.
  Class['cdh::namenode::tmpdir']            ->
  Class['cdh::resourcemanager::config']     ->
  Class['cdh::metastore::config']           ->
  Class['cdh::metastore::service']          ->
#  Class['cdh::sentry']                      ->
  Class['cdh::oozie']                       ->
  Class['cdh::search::config']              ->
  Class['cdh::search::service']             ->
  Class['cdh::hbase::config']               ->
  Class['cdh::hbase::service']              ->
  Class['cdh::hue::config']                 ->
  Class['cdh::hue::service']                ->
  Class['cdh::sqoop1::install']

}
