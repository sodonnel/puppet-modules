class passenger($passenger_version = '4.0.52') {

  require httpd

  contain passenger::install
  contain passenger::compile
  contain passenger::config
}
