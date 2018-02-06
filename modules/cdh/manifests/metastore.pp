class cdh::metastore(
  $namenodehostname        = namenode,
  $metastorehostname       = metastore,
  $mysqlusername           = 'hive',
  $mysqlpassword           = 'hive123',
  $mysqlpasswordhash       = '*FB73BCDD6050E0F3F73E0262950F4D9E0092769C',
  $secured                 = false,
  $hostentries             = {},
)
{

  require cdh::mysql

#  class {'cdh::metastore::mysql':
#    mysqluser         => $mysqlusername,
#    mysqlpasswordhash => $mysqlpasswordhash,
#  }
#
#  class {'cdh::metastore::siteconfig':
#    namenodehost        => $namenodehostname,
#    metastorehost       => $metastorehostname,
#    mysqluser           => $mysqlusername,
#    mysqlpass           => $mysqlpassword,
#    mysqlpasshash       => $mysqlpasswordhash,
#    secured             => $secured,
#  }
#
#  contain cdh::metastore::install
#  contain cdh::metastore::mysql
#  contain cdh::metastore::config
#  contain cdh::metastore::siteconfig
#  contain cdh::metastore::service
#
#  Class['cdh::metastore::install']    ->
#  Class['cdh::metastore::mysql']      ->
#  Class['cdh::metastore::config']     ->
#  Class['cdh::metastore::siteconfig'] ->
#  Class['cdh::metastore::service']
  
}
