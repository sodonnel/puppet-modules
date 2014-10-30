class cdh51namenode($hostname = namenode) {
  
  require cdh51java
  require cdh51repo
  
  contain cdh51namenode::install
  contain cdh51namenode::config
  contain cdh51namenode::format
  contain cdh51namenode::service
  contain cdh51namenode::tmpdir
  
}
