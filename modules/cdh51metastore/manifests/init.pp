class cdh51metastore (
  $metastorehostname = 'metastore',
  $mysqluser         = 'hive',
  $mysqlpassword     = '*FB73BCDD6050E0F3F73E0262950F4D9E0092769C'
)
{
  
  require cdh51java
  require cdh51hosts
  
  contain cdh51metastore::install
  contain cdh51metastore::mysqlserver
  contain cdh51metastore::config
  contain cdh51metastore::service

}
