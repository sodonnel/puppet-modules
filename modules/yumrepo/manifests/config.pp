class yumrepo::config {

  file { "/etc/httpd/conf.d/yumrepo.conf":
    ensure => present,
    content => template("yumrepo/yumrepo.conf.erb"),
    owner => "root",
    group => "root",
    notify  => Service["httpd"]
  }

  file { "/etc/yum.repos.d/local-yum.repo":
    ensure => present,
    source => "puppet:///modules/yumrepo/local-yum.repo",
    owner => "root",
    group => "root",
  }
  
}
