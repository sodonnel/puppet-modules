 class cdh_kafka::config(
    $zookeeper_quorum = "localhost:2181/kafka",
    $broker_id  = "0",
    $data_directories = ['/kafka-data/1', '/kafka-data/2'],
)
{

  file { "/etc/kafka/conf/server.properties":
    ensure => present,
    content => template("cdh_kafka/server.properties"),
    owner => "root",
    group => "root",
  }

  # TODO - create the directories and add them into the server.properties template.
  #        This is much easier in newer puppet versions which allows iterators.

 # $data_directories.each |d| {
 #   exec { "Create ${d}":
 #   creates => $d,
 #   command => "mkdir -p ${d}",
 #   path => $::path
 # } -> file { $d : }


}
