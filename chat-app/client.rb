require 'socket'

class Client
  def initialize
    @socket = TCPSocket.new 'localhost', 2000
    @response = nil
    @request = nil
  end

  def run
    send_message
    receive_message
    @response.join
    @request.join
  end
end

def send_message
  @request = Thread.new do
    loop {
      message = $stdin.gets.chomp
      @socket.puts message
    }
  end
end

def receive_message
  # p 'in client res'
  @response = Thread.new do
    p 'in client res'
    loop {
      p message = @socket.gets.chomp
    }
  end
end

Client.new.run

