node "puppetnode" {
  include base, httpd, passenger, puppetmaster, yumrepo
}
