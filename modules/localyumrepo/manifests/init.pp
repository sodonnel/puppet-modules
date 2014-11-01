class localyumrepo {

  file { "/etc/yum.repos.d/local-yum.repo":
    ensure => present,
    source => "puppet:///modules/localyumrepo/local-yum.repo",
    owner => "root",
    group => "root",
  }
  
}
