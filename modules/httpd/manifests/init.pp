class httpd {

  require base

  contain httpd::install
  include httpd::service
  
}
