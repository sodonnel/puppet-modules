class cdh::resourcemanager::service {

  service { "hadoop-mapreduce-historyserver":
    name        => 'hadoop-mapreduce-historyserver',
    ensure      => running,
    provider    => 'redhat',
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }


  service { "hadoop-yarn-proxyserver":
    name        => 'hadoop-yarn-proxyserver',
    ensure      => stopped,
    provider    => 'redhat',
    hasrestart  => true,
    hasstatus   => true,
    enable      => false,
  }

  service { "hadoop-yarn-resourcemanager":
    name        => 'hadoop-yarn-resourcemanager',
    ensure      => running,
    provider    => 'redhat',
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }
  
}
