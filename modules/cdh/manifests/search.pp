class cdh::search(
  $namenodehostname        = mycluster,
  $zookeeper_ensemble      = 'localhost:2181/solr',
  $enabled                 = true,
  $secure                  = false,
) 
{

  class{ 'cdh::search::config':
    namenodehostname        => $namenodehostname,
    zookeeper_ensemble      => $zookeeper_ensemble,
    secure                  => $secure,
  }

  class{ 'cdh::search::service':
    enabled                 => $enabled,
  }


  contain cdh::search::install
  contain cdh::search::service

  Class['cdh::search::install']             ->
  Class['cdh::search::config']              ->
  Class['cdh::search::service']

}