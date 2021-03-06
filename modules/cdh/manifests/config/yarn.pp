class cdh::config::yarn {

  $namenodehostname        = $::cdh::config::namenodehostname
  $secure                  = $::cdh::config::secure
  $encryption              = $::cdh::config::encryption

  # History Server is assumed to be on resourcemanager
  $resourcemanagerhostname = $::cdh::config::resourcemanagerhostname

  $yarnavailablememory = $::cdh::config::yarnavailablememory
  $yarnavailablecores = $::cdh::config::yarnavailablecores

  file { "/etc/hadoop/conf/yarn-site.xml":
    ensure  => present,
    content => template("cdh/yarn-site.xml.erb"),
    owner   => "root",
    group   => "root",
  }

  file { "/etc/hadoop/conf/mapred-site.xml":
    ensure  => present,
    content => template("cdh/mapred-site.xml.erb"),
    owner   => "root",
    group   => "root",
  }

  file { "/etc/hadoop/conf/container-executor.cfg":
    ensure  => present,
    content => template("cdh/container-executor.cfg.erb"),
    owner   => "root",
    group   => "root",
  }

}
