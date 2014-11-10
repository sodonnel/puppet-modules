class cdh::client(
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


  contain cdh::client::install

  Class['cdh::client::install']    ->
  Class['cdh::config']
  
}
