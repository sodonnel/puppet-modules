class cdh::config(
  $includehive             = false,
  $includeyarn             = false,
  $namenodehostname        = namenode,
  $resourcemanagerhostname = resourcemanager,
  $metastorehostname       = metastore,
  $mysqlusername           = hive,
  $mysqlpassword           = hive123,
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
