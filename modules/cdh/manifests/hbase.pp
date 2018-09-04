class cdh::hbase(
  $zookeeper_ensemble      = 'localhost:2181',
  $masterenabled           = true,
  $regionenabled           = true,
  $thriftenabled           = true,
  $secure                  = false,
) 
{

  # TODO - split master and RS so they can be installed on different nodes

  class{ 'cdh::hbase::config':
    namenodehostname        => $cdh::config::namenodehostname,
    zookeeper_ensemble      => $zookeeper_ensemble,
    secure                  => $secure,
  }

  class{ 'cdh::hbase::service':
    masterenabled                 => $masterenabled,
    regionenabled                 => $regionenabled,
    thriftenabled                 => $thriftenabled,
  }


  contain cdh::hbase::install
  contain cdh::hbase::service

  Class['cdh::hbase::install']             ->
  Class['cdh::hbase::config']              ->
  Class['cdh::hbase::service']

}