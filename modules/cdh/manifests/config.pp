class cdh::config(
  $includehive             = false,
  $includeyarn             = false,
  $namenodehostname        = namenode,
  $resourcemanagerhostname = resourcemanager,
  $metastorehostname       = metastore,
  $mysqlusername           = dummy,
  $mysqlpassword           = dummy,
  $yarnavailablememory     = 3072,
  $yarnavailablecores      = 2,
  $secure                  = false,
)
{

  contain cdh::config::hdfs
  contain cdh::config::profile

  if $includeyarn {
    contain cdh::config::yarn
  }

  if $includehive {
    contain cdh::config::hive
  }
  contain cdh::config::hdfs

  if $secure {
    contain cdh::config::kerberos
  }

}
