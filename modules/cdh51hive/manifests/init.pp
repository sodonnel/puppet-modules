class cdh51hive(
  $metastorehostname = metastore
) 
{
  
  require cdh51java
  
  contain cdh51hive::install
  contain cdh51hive::config
  
}
