class cdh::oozie::service(
  $enabled = true
){

  service { "oozie-server":
    name        => 'oozie',
    ensure      => $enabled,
    hasrestart  => true,
    hasstatus   => true,
    enable      => $enabled,
    subscribe   => File['/etc/oozie/conf/oozie-site.xml']
  }

}
