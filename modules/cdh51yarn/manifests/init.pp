class cdh51yarn(
  $resourcemanagerhostname = resourcemanager,
  $namenodehostname        = namenode
)
{

  require cdh51java
  require cdh51repo
  require cdh51hosts
  require cdh51datanode

  contain cdh51yarn::install
  contain cdh51yarn::config
  contain cdh51yarn::service
  
}
