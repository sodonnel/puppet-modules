class cdh::client(
  $namenodehostname        = namenode,
  $resourcemanagerhostname = resourcemanager,
  $metastorehostname       = metastore,
  $hostentries             = {},
)
{

  class { 'cdh::hosts':
    entries => $hostentries
  }

  class {'cdh::config':
    includehive             => true,
    includeyarn             => true,
    namenodehostname        => $namenodehostname,
    resourcemanagerhostname => $resourcemanagerhostname,
    metastorehostname       => $metastorehostname,
  }


  contain cdh::client::install

  Class['cdh::hosts']              ->
  Class['cdh::client::install']    ->
  Class['cdh::config']
  
}
