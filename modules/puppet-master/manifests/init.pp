class puppet-master {
  # Missing the CERTS step
  include puppet-master::install, puppet-master::config
}
