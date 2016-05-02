class cloudera_manager_repo(
  $cm_version = '5.5.2',
)
 {
  file { "/etc/yum.repos.d/cloudera-manager.repo":
    ensure => present,
    content => template("cloudera_manager_repo/cloudera-manager.repo"),
    owner => "root",
    group => "root",
  }

  exec {'cloudera-manager-repo-cleanall':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    command   => 'yum clean all',
    require   => File['/etc/yum.repos.d/cloudera-manager.repo']
  }
  
}
