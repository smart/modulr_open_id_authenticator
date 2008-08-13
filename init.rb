# Include hook code here

begin
  require 'open_id_authentication'
rescue Exception => e
  puts "*********************************************************"
  puts "Open ID Authentication plugin required to use this module"
  puts "*********************************************************"
  raise e
end