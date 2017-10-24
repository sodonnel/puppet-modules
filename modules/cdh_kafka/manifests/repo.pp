class cdh_kafka::repo(
  $kafka_version = '3.0.0',
)
 {
  file { "/etc/yum.repos.d/cloudera-kafka.repo":
    ensure => present,
    content => template("cdh_kafka/cloudera-kafka.repo"),
    owner => "root",
    group => "root",
  }

  exec {'cdh-kafka-repo-cleanall':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    command   => 'yum clean all',
    require   => File['/etc/yum.repos.d/cloudera-kafka.repo']
  }
  
}
