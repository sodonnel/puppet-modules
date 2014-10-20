class base::config {

  file { "/etc/selinux/config":
      ensure => present,
      source => "puppet:///modules/base/selinux.config",
      owner => "root",
      group => "root",
  }

}