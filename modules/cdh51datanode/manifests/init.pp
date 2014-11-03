class cdh51datanode(
  $namenodehost = namenode
)
{
  
  require cdh51java
  require cdh51hosts
  
  contain cdh51datanode::install
  contain cdh51datanode::config
  contain cdh51datanode::service
  
}
