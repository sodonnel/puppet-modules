class cdh51yarn::service {
  
  # On CENTOS 7, nodemanager doesn't start with systemctl command. It silently fails.
  # You need to run it with service start etc, hence the provider line.
  service { "hadoop-yarn-nodemanager":
    name        => 'hadoop-yarn-nodemanager',
    provider    => 'redhat',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }

}
