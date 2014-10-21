class puppetmaster {

  require base
  require httpd
  require passenger

  $hostnames = 'puppet,puppet.example.com'

  include puppetmaster::install, puppetmaster::config
}
