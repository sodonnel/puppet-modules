class cdh::search::service(
  $enabled = true
){

  if ($enabled) {
    $running_status = 'running'
  } else {
    $running_status = 'stopped'
  }

  service { "solr-server":
    name        => 'solr-server',
    ensure      => $running_status,
    provider    => 'redhat',
    hasrestart  => true,
    hasstatus   => true,
    enable      => $enabled,
    subscribe   => [
                    File['/etc/default/solr'],
                    ]  
  }

}