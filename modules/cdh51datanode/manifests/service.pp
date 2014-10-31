class cdh51datanode::service {

  service { "hadoop-hdfs-datanode":
    name        => 'hadoop-hdfs-datanode',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }
  
}
