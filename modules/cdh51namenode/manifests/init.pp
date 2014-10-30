class cdh51namenode($hostname = namenode) {
  
  require cdh51java
  require cdh51repo
  
  contain cdh51namenode::install
  contain cdh51namenode::config
}
