class cdh51repo {
  file { "/etc/yum.repos.d/cloudera-cdh5.repo":
    ensure => present,
    source => "puppet:///modules/cdh51repo/cloudera-cdh5.repo",
    owner => "root",
    group => "root",
  }
}
