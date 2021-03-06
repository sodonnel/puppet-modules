class yumrepo::config {

  file { "/etc/httpd/conf.d/yumrepo.conf":
    ensure => present,
    content => template("yumrepo/yumrepo.conf.erb"),
    owner => "root",
    group => "root",
    notify  => Service["httpd"]
  }

  file { $::yumrepo::location:
    ensure => directory,
    owner  => root,
    group  => root,
  }
}
