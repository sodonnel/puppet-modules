class cdh::hue::config(
  $namenodehostname        = namenode,
  $metastorehostname       = metastore,
  $resourcemanagerhostname = resourcemanager,
  $secure                  = false,
)
{
  $hueHost = $fqdn

  file { "/etc/hue/conf/hue.ini":
    ensure  => present,
    content => template("cdh/hue.ini.erb"),
    owner   => "root",
    group   => "root",
  }

}