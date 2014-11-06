class cdh::config(
  $includehive             = false,
  $includeyarn             = false,
  $namenodehostname        = namenode,
  $resourcemanagerhostname = resourcemanager,
  $metastorehostname       = metastore,
  $mysqlusername           = dummy,
  $mysqlpassword           = dummy,
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

}
