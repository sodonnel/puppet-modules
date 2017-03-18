class cloudera_director_repo(
  $director_version = '2.3.0',
)
 {
  file { "/etc/yum.repos.d/cloudera-director.repo":
    ensure => present,
    content => template("cloudera_director_repo/cloudera-director.repo"),
    owner => "root",
    group => "root",
  }

  exec {'director-repo-cleanall':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    command   => 'yum clean all',
    require   => File['/etc/yum.repos.d/cloudera-director.repo']
  }
  
}
