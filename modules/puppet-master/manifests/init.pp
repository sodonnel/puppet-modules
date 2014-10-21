class puppet-master {

  $hostnames = 'puppet, puppet.example.com'

  # Missing the CERTS step
  include puppet-master::install, puppet-master::config
}
