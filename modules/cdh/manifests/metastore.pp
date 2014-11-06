class cdh::metastore(
  $namenodehostname        = namenode,
  $metastorehostname       = metastore,
  $mysqlusername           = 'hive',
  $mysqlpassword           = 'hive123',
  $mysqlpasswordhash       = '*FB73BCDD6050E0F3F73E0262950F4D9E0092769C',
)
{
  
  require cdh::hosts
  
  class {'cdh::config':
    includehive             => true,
    namenodehostname        => $namenodehostname,
    metastorehostname       => $metastorehostname,
    mysqlusername           => $mysqlusername,
    mysqlpassword           => $mysqlpassword,
  }

  class {'cdh::metastore::mysql':
    mysqluser         => $mysqlusername,
    mysqlpasswordhash => $mysqlpasswordhash,
  }

  contain cdh::metastore::install
  contain cdh::metastore::mysql
  contain cdh::metastore::config
  contain cdh::metastore::service
  
  Class['cdh::metastore::install']  ->
  Class['cdh::metastore::mysql']    ->
  Class['cdh::config']              ->
  Class['cdh::metastore::config']   ->
  Class['cdh::metastore::service']
  
}
