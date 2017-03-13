# Test Mode:
#
# hbase org.jruby.Main merge_empty_regions.rb namespace.tablename
#
# Non Test - ie actually do the merge:
#
# hbase org.jruby.Main merge_empty_regions.rb namespace.tablename merge
#
# Note: Please replace namespace.tablename with your namespace and table, eg NS1.MyTable. This value is case sensitive.

require 'digest'
require 'java'
java_import org.apache.hadoop.hbase.HBaseConfiguration
java_import org.apache.hadoop.hbase.client.HBaseAdmin
java_import org.apache.hadoop.hbase.TableName
java_import org.apache.hadoop.hbase.HRegionInfo;
java_import org.apache.hadoop.hbase.client.Connection
java_import org.apache.hadoop.hbase.client.ConnectionFactory
java_import org.apache.hadoop.hbase.client.Table
java_import org.apache.hadoop.hbase.util.Bytes

def list_non_empty_regions(admin, table)
  cluster_status = admin.getClusterStatus()
  master = cluster_status.getMaster()
  non_empty = []
  cluster_status.getServers.each do |s|
    cluster_status.getLoad(s).getRegionsLoad.each do |r|
      # getRegionsLoad returns an array of arrays, where each array
      # is 2 elements

      # Filter out any regions that don't match the requested
      # tablename
      next unless r[1].get_name_as_string =~ /#{table}/
      if r[1].getStorefileSizeMB() > 0
        puts r[1].get_name_as_string
        non_empty.push r[1].get_name_as_string
      end
    end
  end
  non_empty
end

# Handle command line parameters
table_name = ARGV[0]
do_merge = false
if ARGV[1] == 'merge'
  do_merge = true
end

config = HBaseConfiguration.create();
connection = ConnectionFactory.createConnection(config);
admin = HBaseAdmin.new(connection);

non_empty_regions = list_non_empty_regions(admin, table_name)
regions = admin.getTableRegions(Bytes.toBytes(table_name));

puts "Total Table Regions: #{regions.length}"
puts "Total non empty regions: #{non_empty_regions.length}"

filtered_regions = regions.reject do |r|
  non_empty_regions.include?(r.get_region_name_as_string)
end

puts "Total regions to consider for Merge: #{filtered_regions.length}"

if filtered_regions.length < 2
  puts "There are not enough regions to merge"
end

r1, r2 = nil
filtered_regions.each do |r|
  if r1.nil?
    r1 = r
    next
  end
  if r2.nil?
    r2 = r
  end
  # Skip any region that is a split region
  if r1.is_split()
    r1 = r2
    r2 = nil
    next
  end
  if r2.is_split()
    r2 = nil
    next
  end
  if HRegionInfo.are_adjacent(r1, r2)
    # only merge regions that are adjacent
    puts "#{r1.get_encoded_name} is adjacent to #{r2.get_encoded_name}"
    if do_merge
      admin.mergeRegions(r1.getEncodedNameAsBytes, r2.getEncodedNameAsBytes, false)
      puts "Successfully Merged #{r1.get_encoded_name} with #{r2.get_encoded_name}"
      sleep 2
    end
    r1, r2 = nil
  else
    # Regions are not adjacent, so drop the first one and iterate again
    r1 = r2
    r2 = nil
  end
end
admin.close
