class cdh::nodemanager
{

  # TODO - nodemanager needs config to created its data directories.
  #        This is currently in the datanode setup.

  require cdh::config::yarn

  contain cdh::nodemanager::install
  contain cdh::nodemanager::service

  Class['cdh::nodemanager::install'] ->
  Class['cdh::nodemanager::service']
  
}
