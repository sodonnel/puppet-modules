# To run this using hbase jruby command:
#
# hbase org.jruby.Main sample_put_get_scan.rb

require 'java'
java_import org.apache.hadoop.hbase.HBaseConfiguration;
java_import org.apache.hadoop.hbase.TableName;
java_import org.apache.hadoop.hbase.client.Connection;
java_import org.apache.hadoop.hbase.client.ConnectionFactory;
java_import org.apache.hadoop.hbase.client.Get;
java_import org.apache.hadoop.hbase.client.Table;
java_import org.apache.hadoop.hbase.client.Put;
java_import org.apache.hadoop.hbase.client.Result;
java_import org.apache.hadoop.hbase.client.ResultScanner;
java_import org.apache.hadoop.hbase.client.Scan;
java_import org.apache.hadoop.hbase.util.Bytes;

config = HBaseConfiguration.create();
connection = ConnectionFactory.createConnection(config);

# Simple single value put
table = connection.getTable(TableName.valueOf("repme"));
p = Put.new(Bytes.toBytes("a1"));
p.add(Bytes.toBytes("cf1"), Bytes.toBytes("c1"), Bytes.toBytes("Some Value"));
table.put(p)


# putting in batches
pl = Array.new
1.upto(1000000) do |i|
  p = Put.new(Bytes.toBytes("c#{i}"))
  p.add(Bytes.toBytes("cf1"), Bytes.toBytes("c1"), Bytes.toBytes("Some Value"))
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

# Scanning all rows in table
# Row key is a1, CF is cf1, col is c1:
g = Get.new(Bytes.toBytes("a1"))
r = table.get(g)
value = r.getValue(Bytes.toBytes("cf1"), Bytes.toBytes("c1"))
valueStr = Bytes.toString(value)
puts "GET: #{valueStr}"

s = Scan.new();
s.addColumn(Bytes.toBytes("cf1"), Bytes.toBytes("c1"));
s.addColumn(Bytes.toBytes("cf1"), Bytes.toBytes("hello"));
s.addColumn(Bytes.toBytes("cf1"), Bytes.toBytes("hello2"));
scanner = table.getScanner(s)
scanner.each do |rr|
  puts rr
end
scanner.close
