class cdh::namenode
{

  require cdh::config::hdfs

  if (cdh::config::secure) {
    require cdh::config::kerberos
  }

  contain cdh::namenode::install
  contain cdh::namenode::format
  contain cdh::namenode::service

  Class['cdh::namenode::install']    ->
  Class['cdh::namenode::format']     ->
  Class['cdh::namenode::service']

}
