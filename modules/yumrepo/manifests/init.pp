class yumrepo($location = '/var/www/yumrepo') {

  require httpd

  contain yumrepo::install
  contain yumrepo::config

}
