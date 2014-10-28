class yumrepo::install {

  package { [createrepo]:
    ensure => present,
  }

  file { $::yumrepo::location:
    ensure    => "directory",
  }
 
}
