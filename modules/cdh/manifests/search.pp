class cdh::search(
  $install                 = 'true',
  $namenodehostname        = namenode,
  $zookeeper_ensemble      = 'localhost:2181/solr',
  $enabled                 = true,
  $secure                  = false,
) 
{

  if ($install == 'true') {
    
    class{ 'cdh::search::install':  } ->
    class{ 'cdh::search::config':
      namenodehostname        => $namenodehostname,
      zookeeper_ensemble      => $zookeeper_ensemble,
      secure                  => $secure,
    }                                ->
    class{ 'cdh::search::service':
      enabled                 => $enabled,
    }
    
  }

}