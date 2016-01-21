class cdh::zookeeper::service(
  $enabled = true
){

  service { "zookeeper-server":
    name        => 'zookeeper-server',
    ensure      => $enabled,
    hasrestart  => true,
    hasstatus   => true,
    enable      => $enabled,
  }

}
