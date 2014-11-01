class yumrepo::install {

  package { [createrepo]:
    ensure => present,
  }
 
}
