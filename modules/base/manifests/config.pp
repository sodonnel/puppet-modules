class base::config {

  file { "/etc/selinux/config":
      ensure => present,
      source => "puppet:///modules/base/selinux.config",
      owner => "root",
      group => "root",
  }

  file { "/etc/yum.repos.d/local-yum.repo":
      ensure => present,
      source => "puppet:///modules/base/local-yum.repo",
      owner => "root",
      group => "root",
  }

}
