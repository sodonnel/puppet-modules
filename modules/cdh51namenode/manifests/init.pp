class cdh51namenode($hostname = namenode) {
  
  require cdh51java
  require cdh51hosts
  
  contain cdh51namenode::install
  contain cdh51namenode::config
  contain cdh51namenode::format
  contain cdh51namenode::service
  contain cdh51namenode::tmpdir

  # On first install, the changes to the config files cause the service
  # to be started before the format setup is called. This forces
  # format to be called before the service can be started.
  Exec['format-namenode'] -> Service['hadoop-hdfs-namenode'] -> Class['cdh51namenode::tmpdir']
  
}
