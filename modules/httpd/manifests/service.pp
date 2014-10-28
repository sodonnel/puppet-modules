class httpd::service {

  service { "httpd":
    name        => 'httpd',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }

}
 
