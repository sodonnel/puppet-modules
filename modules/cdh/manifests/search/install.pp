class cdh::search::install {
  
  package { [solr, solr-server, solr-doc, solr-mapreduce, search]:
    ensure => present,
  }
 
}
