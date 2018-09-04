class cdh::resourcemanager
{

  require cdh::config::yarn

  contain cdh::resourcemanager::install
  contain cdh::resourcemanager::config
  contain cdh::resourcemanager::service

  Class['cdh::resourcemanager::install'] ->
  Class['cdh::resourcemanager::config']  ->
  Class['cdh::resourcemanager::service']
  
}
