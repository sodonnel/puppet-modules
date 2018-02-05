class cdh::datanode
{

  require cdh::config::hdfs

  if (cdh::config::secure) {
    require cdh::config::kerberos
  }

  contain cdh::datanode::install
  contain cdh::datanode::config
  contain cdh::datanode::service

  Class['cdh::datanode::install']    ->
  Class['cdh::datanode::config']     ->
  Class['cdh::datanode::service']
    
}
