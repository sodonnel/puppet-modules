class puppetmaster {

  require base
  require httpd
  require passenger

  $hostnames = 'puppet,puppet.example.com'

  contain puppetmaster::install
  contain puppetmaster::config
}
