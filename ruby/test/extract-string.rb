# require 'fs'

`wget https://coderbyte.com/api/challenges/logs/web-logs-raw -O logfile.log`

file_content = File.read('logfile.log')

content = file_content.split('\n')

content.each do |line|
  if line.match('coderbyte heroku/router') 
    req_id = line.split(' ').match('request_id').split("=").last
    if line.match('fwd="MASKED"')
      print "#{req_id} [M]"
    else
      print req_id
    end
  end 
end