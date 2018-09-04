class cdh::hue(
  $install                 = 'true',
  $namenodehostname        = namenode,
  $metastorehostname       = metastore,
  $resourcemanagerhostname = resourcemanager,
  $secure                  = false,
) 
{

  if ($install == 'true') {
    class{ 'cdh::hue::install': } ->
    class{ 'cdh::hue::config':
      namenodehostname        => $namenodehostname,
      resourcemanagerhostname => $resourcemanagerhostname,
      metastorehostname       => $metastorehostname,
      secure                  => $secure,
    }                             ->
    class{ 'cdh::hue::service': }
  }

}