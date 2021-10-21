require "rubygems"
require "bunny"

# STDOUT.sync = true

options = {
  :host => "in-rmq-misc-2.prod.aps.bookmyshow.org",
  :vhost => "iedb",
  :user => "rabbitmq",
  :password => "Bigtree@6827",
  :port => 5672,
  :durable => true
}

conn = Bunny.new(options)
# conn = Bunny.new("amqp://rabbitmq:Bigtree\@6827@in-rmq-misc-1.prod.aps.bookmyshow.org/iedb")
conn.start

ch = conn.create_channel
q  = ch.queue("int-bo-artists", :durable => true)
x  = ch.default_exchange


q.subscribe(block: true) do |delivery_info, metadata, payload|
  puts "Received #{payload}"
end

# x.publish("Hello!", :routing_key => q.name)

sleep 1.0
# ch.close
conn.close