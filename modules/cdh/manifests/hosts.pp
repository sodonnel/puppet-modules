class cdh::hosts(
  $entries = {}
)
{

  file { "/etc/hosts":
    ensure  => present,
    content => template("cdh/hosts.erb"),
    owner   => "root",
    group   => "root",
  }
    
}
