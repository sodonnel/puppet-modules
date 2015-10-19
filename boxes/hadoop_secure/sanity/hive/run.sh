hadoop fs -mkdir -p hive/sanity_check
hadoop fs -put data.csv hive/sanity_check/

hive -e "create external table if not exists sanity_check
( id int,
  animal string
) 
row format DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
stored as textfile location '/user/vagrant/hive/sanity_check'"

hive -e "select animal, count(*) from sanity_check group by animal"
