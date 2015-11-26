class cdh::hbase::install {
  
  package { [hbase, hue-hbase, hbase-thrift, hbase-master, hbase-regionserver, hbase-rest, hive-hbase]:
    ensure => present,
  }
 
}



