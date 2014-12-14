class cdh::config::profile {

  file { [ '/etc/profile.d/hadoop.sh' ]:
    ensure => "present",
    content => template("cdh/hadoop_profile.sh.erb"),
    owner  => 'root',
    group  => 'root',
    mode   => '644',
  }

}