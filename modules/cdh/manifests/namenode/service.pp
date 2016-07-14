class cdh::namenode::service {

  service { "hadoop-hdfs-namenode":
    name        => 'hadoop-hdfs-namenode',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
    subscribe   => [
                    File['/etc/hadoop/conf/hdfs-site.xml'],
                    File['/etc/hadoop/conf/core-site.xml']
                    ]

  }

  ->

  service { "hadoop-hdfs-secondarynamenode":
    name        => 'hadoop-hdfs-secondarynamenode',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
    subscribe   => [
                    File['/etc/hadoop/conf/hdfs-site.xml'],
                    File['/etc/hadoop/conf/core-site.xml']
                    ]

  }


}
