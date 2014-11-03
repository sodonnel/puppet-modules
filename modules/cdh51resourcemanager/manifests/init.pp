class cdh51resourcemanager(
  $resourcemanagerhostname = resourcemanager,
  $namenodehostname        = namenode
)
{

  require cdh51java
  require cdh51hosts

  contain cdh51resourcemanager::install
  contain cdh51resourcemanager::config
  contain cdh51resourcemanager::service
  
}
