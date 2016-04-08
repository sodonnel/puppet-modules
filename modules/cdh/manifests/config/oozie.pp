class cdh::config::oozie {

  $mysqlusername     = $::cdh::config::mysqlusername
  $mysqlpassword     = $::cdh::config::mysqlpassword
  $secure            = $::cdh::config::secure
  $oozieHost         = $hostname

  file { "/etc/oozie/conf/oozie-site.xml":
    ensure  => present,
    content => template("cdh/oozie-site.xml.erb"),
    owner   => "root",
    group   => "root",
  }

}
