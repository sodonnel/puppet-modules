class cdh51metastore::config {

  $metastorehostname = $::cdh51metastore::metastorehostname
  $mysqluser         = $::cdh51metastore::mysqluser
  $mysqlpassword     = $::cdh51metastore::mysqlpassword

  file { "/usr/lib/hive/conf/hive-site.xml":
    ensure => present,
    content => template("cdh51metastore/hive-site.xml"),
    owner => "root",
    group => "root",
  }

}
