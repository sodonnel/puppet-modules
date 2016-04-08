class cdh::metastore::siteconfig(
  $namenodehost        = namenode,
  $metastorehost       = metastore,
  $mysqluser           = 'hive',
  $mysqlpass           = 'hive123',
  $mysqlpasshash       = '*FB73BCDD6050E0F3F73E0262950F4D9E0092769C',
  $secured             = false
){
  
  $metastorehostname = $namenodehost
  $mysqlusername     = $mysqluser
  $mysqlpassword     = $mysqlpass
  $mysqlpasswordhash = $mysqlpasshash

  $secure            = $secured


  file { "/usr/lib/hive/conf/hive-site.xml":
    ensure  => present,
    content => template("cdh/hive-site.xml.erb"),
    owner   => "root",
    group   => "root",
  }

}
