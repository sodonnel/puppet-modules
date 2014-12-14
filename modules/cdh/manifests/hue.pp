class cdh::hue(
  $namenodehostname        = namenode,
  $metastorehostname       = metastore,
  $resourcemanagerhostname = resourcemanager,
  $hostentries             = {},
) 
{

  class { 'cdh::hosts':
    entries => $hostentries
  }

  class{ 'cdh::hue::config':
    namenodehostname        => $namenodehostname,
    resourcemanagerhostname => $resourcemanagerhostname,
    metastorehostname       => $metastorehostname,
  }

  contain cdh::hue::install
  contain cdh::hue::service

  Class['cdh::hosts']                    ->
  Class['cdh::hue::install']             ->
  Class['cdh::hue::config']              ->
  Class['cdh::hue::service']

}