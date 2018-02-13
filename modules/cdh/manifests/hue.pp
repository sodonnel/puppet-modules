class cdh::hue(
  $namenodehostname        = namenode,
  $metastorehostname       = metastore,
  $resourcemanagerhostname = resourcemanager,
) 
{

  class{ 'cdh::hue::config':
    namenodehostname        => $namenodehostname,
    resourcemanagerhostname => $resourcemanagerhostname,
    metastorehostname       => $metastorehostname,
  }

  contain cdh::hue::install
  contain cdh::hue::service

  Class['cdh::hue::install']             ->
  Class['cdh::hue::config']              ->
  Class['cdh::hue::service']

}