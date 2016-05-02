class kerberos::client(
  $kdc_hostname = standalone
){

  package { [krb5-libs, krb5-workstation]:
    ensure => present,
  }

  ->

  file { "/etc/krb5.conf":
    ensure => present,
    content => template("kerberos/krb5.conf.erb"),
    owner => "root",
    group => "root",
    mode => "644",
  }

}