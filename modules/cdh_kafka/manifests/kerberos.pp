class cdh_kafka::kerberos(
  $enable_kerberos = false
)
{

  if $enable_kerberos == true {
    file { "/root/create_kafka_principals.sh":
      ensure  => present,
      content => template("cdh_kafka/create_kafka_principals.sh.erb"),
      owner   => "root",
      group   => "root",
      mode    => "700",
    }

    ->

    exec {'generate-kafka-principals':
      path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
      user      => 'root',
      command   => '/root/create_kafka_principals.sh',
      logoutput => on_failure,
      creates   => "/root/kafka_keytabs_generated",
      timeout   => 0,
    }

    ->

    file { "/etc/kafka/conf/jaas.conf":
      ensure  => present,
      content => template("cdh_kafka/jaas.conf.erb"),
      owner   => "root",
      group   => "root",
      mode    => "755",
    }

    ->

    # Starting Kafka with Kerberos requires passing Java options at startup.
    # Unlike most of the Hadoop components, Kafka does not have a kafka.env
    # script that is run on startup to set environment variables. Therefore
    # This hack patches the startup script provided by the RPM to set the
    # required JVM options for startup

    file { "/usr/lib/kafka/bin/kafka-server-start.sh":
      ensure  => present,
      content => template("cdh_kafka/kafka-server-start.sh"),
      owner   => "kafka",
      group   => "kafka",
      mode    => "755",
    }

  }
}