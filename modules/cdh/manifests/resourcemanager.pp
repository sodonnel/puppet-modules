class cdh::resourcemanager(
  $namenodehostname         = namenode,
  $resourcemanagerhostname  = resourcemanager,
  $hostentries              = {},
)
{

  class { 'cdh::hosts':
    entries => $hostentries
  }

  class {'cdh::config':
    namenodehostname         => $namenodehostname,
    resourcemanagerhostname  => $resourcemanagerhostname
  }
  
  contain cdh::resourcemanager::install
  contain cdh::resourcemanager::config
  contain cdh::resourcemanager::service

  Class['cdh::hosts']                    ->
  Class['cdh::resourcemanager::install'] ->
  Class['cdh::config']                   ->
  Class['cdh::resourcemanager::config']  ->
  Class['cdh::resourcemanager::service']
  
}
