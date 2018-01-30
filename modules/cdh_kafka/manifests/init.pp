class cdh_kafka(
  $kafka_version = '3.0.0',
  $enable_kerberos = false,
  $enable_sentry   = false,
  $zookeeper_quorum = 'standalone:2181/kafka',
  $broker_instance  = 0,
  $port             = 9092,
  $metrics_http_port=24042,
  $data_directories = ['/kafka-data/1', '/kafka-data/2'],
  $broker_count     = 3
)
{

  class {'cdh_kafka::repo':
    kafka_version => $kafka_version,
  }                                     ->

  class {'cdh_kafka::install':}         ->

  cdh_kafka::broker { 'broker':
    zookeeper_quorum => $zookeeper_quorum,
    enable_kerberos  => $enable_kerberos,
    enable_sentry    => $enable_sentry,
    broker_id        => $broker_instance,
    port             => $port,
    metrics_http_port=>$metrics_http_port,
    data_directories => $data_directories,
  }

  ->

  class {'cdh_kafka::kerberos':
    enable_kerberos  => $enable_kerberos
  }

  ->

  class {'cdh_kafka::service':}

  $extra_brokers = $broker_count - 1
  range("1", "$extra_brokers").each |$number| {
    cdh_kafka::broker { "broker${number}":
      zookeeper_quorum => $zookeeper_quorum,
      enable_kerberos  => $enable_kerberos,
      enable_sentry    => $enable_sentry,
      broker_id        => $number + 0, # Hack to get it to convert string to int
      port             => $port + $number,
      metrics_http_port=>$metrics_http_port + $number,
      data_directories => $data_directories,
    }
  }

  contain cdh_kafka::repo
  contain cdh_kafka::install
  contain cdh_kafka::kerberos
  contain cdh_kafka::service
}

