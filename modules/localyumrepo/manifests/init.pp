class localyumrepo(
  $repourl = 'http://puppet/yumrepo'
)
{

  file { "/etc/yum.repos.d/local-yum.repo":
    ensure => present,
    content => template("localyumrepo/local-yum.repo.erb"),
    owner => "root",
    group => "root",
  }

  exec {'localyum-repo-cleanall':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    command   => 'yum clean all',
    require   => File['/etc/yum.repos.d/local-yum.repo']
  }

}
