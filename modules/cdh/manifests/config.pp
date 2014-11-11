class cdh::config(
  $includehive             = false,
  $includeyarn             = false,
  $includeoozie            = false,
  $namenodehostname        = namenode,
  $resourcemanagerhostname = resourcemanager,
  $metastorehostname       = metastore,
  $mysqlusername           = dummy,
  $mysqlpassword           = dummy,
  $yarnavailablememory     = 3072,
  $yarnavailablecores      = 2,
)
{

  contain cdh::config::hdfs

  if $includeyarn {
    contain cdh::config::yarn
  }

  if $includehive {
    contain cdh::config::hive
  }
  contain cdh::config::hdfs

  if $includeoozie {
    contain cdh::config::oozie
  }

}
