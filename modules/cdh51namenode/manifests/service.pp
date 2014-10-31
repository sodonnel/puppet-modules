class cdh51namenode::service {

  service { "hadoop-hdfs-namenode":
    name        => 'hadoop-hdfs-namenode',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }

}
