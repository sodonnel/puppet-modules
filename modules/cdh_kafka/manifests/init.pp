class cdh_kafka(
  $kafka_version = '3.0.0',
  $zookeeper_quorum = 'localhost:2181/kafka',
  $broker_instance  = 0,
  $data_directories = ['/kafka-data/1', '/kafka-data/2']
)
{

  class {'cdh_kafka::repo':
    kafka_version => $kafka_version,
  }                                     ->

  class {'cdh_kafka::install':}         ->

  class {'cdh_kafka::config':
    zookeeper_quorum => $zookeeper_quorum,
    broker_id        => $broker_instance,
    data_directories => $data_directories,
  }                                     ->

  class {'cdh_kafka::service':}

  contain cdh_kafka::repo
  contain cdh_kafka::install
  contain cdh_kafka::config
  contain cdh_kafka::service
}

