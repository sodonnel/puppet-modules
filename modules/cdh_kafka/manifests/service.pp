class cdh_kafka::service {

  service { "kafka-server":
    name        => 'kafka-server',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }

}