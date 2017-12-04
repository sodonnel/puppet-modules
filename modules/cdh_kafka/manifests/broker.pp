define cdh_kafka::broker(
  $zookeeper_quorum = "localhost:2181/kafka",
  $broker_id        = "0",
  $port             = '9092',
  $metrics_http_port= '24042',
  $data_directories = ['/kafka-data/1', '/kafka-data/2'],
) {

  # This is a hack to allow many brokers to run on one host. If the broker
  # id is passed as zero, its considered the default broker installed as a service
  # If its not zero, then we need to create the addition server.properties files.
  if $broker_id != 0 {
    $broker_name = $broker_id
  } else {
    $broker_name = ""
  }

  $data_directories_with_broker = $data_directories.map |String $val | {
      "${val}/broker_${broker_id}"
  }

  file { "/etc/kafka/conf/server${broker_name}.properties":
    ensure => present,
    content => template("cdh_kafka/server.properties"),
    owner => "root",
    group => "root",
  }

  file { "/var/log/kafka${broker_name}":
    ensure =>  directory,
    owner => "kafka",
    group => "kafka",
  }


  $data_directories_with_broker.each  | Integer $index, String $dir| {
    exec { "Create ${dir}":
      creates => $dir,
      command => "mkdir -p ${dir}",
      path => $::path
    } ->

    file { $dir:
      ensure => directory,
      owner  => 'kafka',
      group  => 'kafka'
    }
  }

  if $broker_name != "" {
    file { "/etc/rc.d/init.d/kafka-server-${broker_name}":
      ensure => present,
      content => template("cdh_kafka/kafka-server-init-script"),
      owner => "root",
      group => "root",
      mode => "755",
    }
  }

}