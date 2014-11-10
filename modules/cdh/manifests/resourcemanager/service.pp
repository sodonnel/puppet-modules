class cdh::resourcemanager::service {

  service { "hadoop-mapreduce-historyserver":
    name        => 'hadoop-mapreduce-historyserver',
    ensure      => running,
    provider    => 'redhat',
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
    subscribe   => [
                    File['/etc/hadoop/conf/core-site.xml'],
                    File['/etc/hadoop/conf/yarn-site.xml'],
                    File['/etc/hadoop/conf/mapred-site.xml'],
                    ]
  }


  service { "hadoop-yarn-proxyserver":
    name        => 'hadoop-yarn-proxyserver',
    ensure      => stopped,
    provider    => 'redhat',
    hasrestart  => true,
    hasstatus   => true,
    enable      => false,
    subscribe   => [
                    File['/etc/hadoop/conf/core-site.xml'],
                    File['/etc/hadoop/conf/yarn-site.xml'],
                    File['/etc/hadoop/conf/mapred-site.xml'],
                    ]
  }

  service { "hadoop-yarn-resourcemanager":
    name        => 'hadoop-yarn-resourcemanager',
    ensure      => running,
    provider    => 'redhat',
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
    subscribe   => [
                    File['/etc/hadoop/conf/core-site.xml'],
                    File['/etc/hadoop/conf/yarn-site.xml'],
                    File['/etc/hadoop/conf/mapred-site.xml'],
                    ]  
  }
  
}
