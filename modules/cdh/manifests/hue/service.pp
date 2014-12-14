class cdh::hue::service {

  service { "hue":
    name        => 'hue',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
    subscribe   => [
                    File['/etc/hue/conf/hue.ini'],
                   ]
 
  }

}