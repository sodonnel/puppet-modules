class cdh::datanode
{

  require cdh::config::hdfs

  contain cdh::datanode::install
  contain cdh::datanode::config
  contain cdh::datanode::service

#  Class['cdh::hosts']                ->
  Class['cdh::datanode::install']    ->
  Class['cdh::config']               ->
  Class['cdh::datanode::config']     ->
  Class['cdh::datanode::service']
    
}
