class localyumrepo {

  file { "/etc/yum.repos.d/local-yum.repo":
    ensure => present,
    source => "puppet:///modules/localyumrepo/local-yum.repo",
    owner => "root",
    group => "root",
  }

  exec {'localyum-repo-cleanall':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    command   => 'yum clean all',
    require   => File['/etc/yum.repos.d/local-yum.repo']
  }

}
