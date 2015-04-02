class cdh::local(
  $hostname            = localhost,
  $yarnavailablememory = 3840,
  $yarnavailablecores  = 8,
)
{

  class {'cdh::config':
    includehive  => true,
    includeyarn  => true,
    includeoozie => true,
    namenodehostname        => $hostname,
    resourcemanagerhostname => $hostname,
    metastorehostname       => $hostname,
    mysqlusername           => hive,
    mysqlpassword           => hive123,
    yarnavailablememory     => $yarnavailablememory,
    yarnavailablecores      => $yarnavailablecores,
  }

  class {'cdh::metastore::mysql':
    mysqluser         => hive,
    mysqlpasswordhash => '*FB73BCDD6050E0F3F73E0262950F4D9E0092769C',
  }

  contain cdh::namenode::install
  contain cdh::namenode::format
  contain cdh::namenode::tmpdir
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
  }
  contain cdh::hue::service

  Class['cdh::namenode::install']           ->
  Class['cdh::datanode::install']           ->
  Class['cdh::resourcemanager::install']    ->
  Class['cdh::metastore::install']          ->
  Class['cdh::metastore::mysql']            ->
  Class['cdh::config']                      ->
  Class['cdh::namenode::format']            ->
  Class['cdh::namenode::service']           ->
  Class['cdh::namenode::tmpdir']            ->
  Class['cdh::resourcemanager::config']     ->
  Class['cdh::resourcemanager::service']    ->
  Class['cdh::datanode::config']            ->
  Class['cdh::datanode::service']           ->
  Class['cdh::metastore::config']           ->
  Class['cdh::metastore::service']          ->
  Class['cdh::hue::install']                ->
  Class['cdh::hue::config']                 ->
  Class['cdh::hue::service']

}
