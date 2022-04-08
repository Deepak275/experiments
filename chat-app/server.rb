require 'socket'

class TcpServer
  def initialize
    @server = TCPServer.new 'localhost', 2000
  end

  def setup
    clients_details = {clients: {}}
    
    loop {
      Thread.start(@server.accept) do |client|
        client_name = client.gets.chomp.to_sym

        if clients_details[:clients][client_name] != nil
          puts "client already exist"
          # client.close
          Thread.kill self
        end

        clients_details[:clients][client_name] = client
        
        loop {
          message = client.gets.chomp

          clients_details[:clients].each do |client_name, conn|
            p client_name
            p conn
            conn.puts message
          end
        }
        
        # p clients_details[:clients][client_name].methods

        # p client.gets.chomp
        
      end
    }.join
  end


end

TcpServer.new.setup()