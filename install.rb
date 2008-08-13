# Install hook code here
puts "######################################"
puts "Checking for dependencies"
puts "######################################"
begin 
  puts "Youser Authentication plugin....[PASS]"
  require 'youser_authentication'
  
rescue 
  puts "Youser Authentication plugin....[FAIL]"
  puts "Ensure you have Youser Authentication before using, visit (http://github.com/smartocci/youser_authentication/tree/master)"
end

begin 
  puts "Open ID Authentication plugin....[PASS]"
  require 'open_id_authentication'
  
rescue 
  puts "Open ID Authentication plugin....[FAIL]"
  puts "Ensure you have Youser Authentication before using, visit (http://github.com/smartocci/youser_authentication/tree/master)"
end