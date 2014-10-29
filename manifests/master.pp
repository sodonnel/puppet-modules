node "puppet" {
  include base, httpd, passenger, puppetmaster, yumrepo
}
