class cdh::config::hive {
  
  $metastorehostname = $::cdh::config::metastorehostname
  $mysqlusername     = $::cdh::config::mysqlusername
  $mysqlpassword     = $::cdh::config::mysqlpassword
  $mysqlpasswordhash = $::cdh::config::mysqlpasswordhash


  file { "/usr/lib/hive/conf/hive-site.xml":
    ensure  => present,
    content => template("cdh/hive-site.xml.erb"),
    owner   => "root",
    group   => "root",
  }

}
