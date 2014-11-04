class cdh51metastore (
  $metastorehostname = 'metastore',
  $mysqluser         = 'hive',
  $mysqlpassword     = 'hive123'
)
{
  
  require cdh51java
  require cdh51hosts
  
  contain cdh51metastore::install
  contain cdh51metastore::mysqlserver
  contain cdh51metastore::config
  contain cdh51metastore::service

}
