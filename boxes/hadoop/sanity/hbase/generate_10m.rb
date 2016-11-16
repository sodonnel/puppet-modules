require 'digest'
require 'java'
java_import org.apache.hadoop.hbase.HBaseConfiguration
java_import org.apache.hadoop.hbase.HColumnDescriptor
java_import org.apache.hadoop.hbase.HTableDescriptor
java_import org.apache.hadoop.hbase.client.HBaseAdmin
java_import org.apache.hadoop.hbase.TableName
java_import org.apache.hadoop.hbase.client.Connection
java_import org.apache.hadoop.hbase.client.ConnectionFactory
java_import org.apache.hadoop.hbase.client.Get
java_import org.apache.hadoop.hbase.client.Table
java_import org.apache.hadoop.hbase.client.Put
java_import org.apache.hadoop.hbase.client.Result
java_import org.apache.hadoop.hbase.client.ResultScanner
java_import org.apache.hadoop.hbase.client.Scan
java_import org.apache.hadoop.hbase.util.Bytes

config = HBaseConfiguration.create();
connection = ConnectionFactory.createConnection(config);

admin = HBaseAdmin.new(connection);
unless admin.tableExists("gentab")
  tableDescriptor = HTableDescriptor.new(TableName.valueOf("gentab"))
  tableDescriptor.addFamily(HColumnDescriptor.new(Bytes.toBytes("cf1")));
  tableDescriptor.addFamily(HColumnDescriptor.new(Bytes.toBytes("cf2")));
  admin.createTable(tableDescriptor)
end
admin.close

# Now fill the table with 10M values
table = connection.getTable(TableName.valueOf("gentab"));
pl = Array.new
1.upto(10000000) do |i|
  p = Put.new(Bytes.toBytes(Digest::MD5.hexdigest(1.to_s.rjust(8, '0'))))
  p.add(Bytes.toBytes("cf1"), Bytes.toBytes("c1"), Bytes.toBytes("Some Value"))
  p.add(Bytes.toBytes("cf1"), Bytes.toBytes("c2"), Bytes.toBytes("Other value"))
  p.add(Bytes.toBytes("cf2"), Bytes.toBytes("c1"), Bytes.toBytes("CF2 Some Value"))
  p.add(Bytes.toBytes("cf2"), Bytes.toBytes("c2"), Bytes.toBytes("CF2 Other value"))
  pl.push p
  if pl.length >= 100
    table.put(pl)
    pl.clear
  end
end
if pl.length > 0
  table.put(pl)
  pl.clear
end
