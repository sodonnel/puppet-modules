class cdh::hue(
  $install                 = 'true',
  $namenodehostname        = namenode,
  $metastorehostname       = metastore,
  $resourcemanagerhostname = resourcemanager,
) 
{

  if ($install == 'true') {
    class{ 'cdh::hue::install': } ->
    class{ 'cdh::hue::config':
      namenodehostname        => $namenodehostname,
      resourcemanagerhostname => $resourcemanagerhostname,
      metastorehostname       => $metastorehostname,
    }                             ->
    class{ 'cdh::hue::service': }
  }

}