class httpd::install {

  package { [httpd, httpd-devel, mod_ssl]:
    ensure => present,
  }

  ->

  service { "httpd":
    enable => true
  }
 
}