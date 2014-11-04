node "namenode" {
  include base, cdh51namenode
}

node "resourcemanager" {
  include base, cdh51resourcemanager
}

node /^datanode.*/ {
  include base, cdh51datanode, cdh51yarn
}


node "metastore" {
  require localyumrepo
  require cdh51repo
  require cdh51metastore
  Class['localyumrepo'] -> Class[cdh51repo] -> Class[cdh51metastore]
}
