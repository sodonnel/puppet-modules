class cdh::datanode(
  $namenodehostname        = namenode,
  $resourcemanagerhostname = resourcemanager,
  $metastorehostname       = metastore,
)
{

  require cdh::hosts

  class {'cdh::config':
    includehive             => true,
    includeyarn             => true,
    namenodehostname        => $namenodehostname,
    resourcemanagerhostname => $resourcemanagerhostname,
    metastorehostname       => $metastorehostname,
  }

  contain cdh::datanode::install
  contain cdh::datanode::config
  contain cdh::datanode::service

  Class['cdh::datanode::install']    ->
  Class['cdh::config']               ->
  Class['cdh::datanode::config']     ->
  Class['cdh::datanode::service']
    
}
