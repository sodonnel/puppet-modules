class cdh::hbase::service(
  $masterenabled = true,
  $regionenabled = true,
  $thriftenabled = true,
){

  if ($masterenabled) {
    $master_running_status = 'running'
  } else {
    $master_running_status = 'stopped'
  }

  if ($regionenabled) {
    $region_running_status = 'running'
  } else {
    $region_running_status = 'stopped'
  }

  if ($thriftenabled) {
    $thrift_running_status = 'running'
  } else {
    $thrift_running_status = 'stopped'
  }


  service { "hbase-master":
    name        => 'hbase-master',
    ensure      => $master_running_status,
    provider    => 'redhat',
    hasrestart  => true,
    hasstatus   => true,
    enable      => $masterenabled,
    subscribe   => [
                    File['/etc/hbase/conf/hbase-site.xml'],
                    ]  
  }

  ->

  service { "hbase-regionserver":
    name        => 'hbase-regionserver',
    ensure      => $region_running_status,
    provider    => 'redhat',
    hasrestart  => true,
    hasstatus   => true,
    enable      => $regionenabled,
    subscribe   => [
                    File['/etc/hbase/conf/hbase-site.xml'],
                    ]  
  }

  ->

  service { "hbase-thrift":
    name        => 'hbase-thrift',
    ensure      => $master_running_status,
    provider    => 'redhat',
    hasrestart  => true,
    hasstatus   => true,
    enable      => $thriftenabled,
    subscribe   => [
                    File['/etc/hbase/conf/hbase-site.xml'],
                    ]  
  }

  # TODO - rest server


}