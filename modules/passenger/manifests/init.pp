class passenger {

  require httpd

  include passenger::install, passenger::compile, passenger::config
}
