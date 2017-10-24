class cdh_kafka::install {

  package { [kafka, kafka-server, kafka-mirror-maker]:
    ensure => present,
  }

}