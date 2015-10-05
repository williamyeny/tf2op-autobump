require 'mechanize'

mechanize = Mechanize.new

puts "Loading cookies..."
mechanize.cookie_jar.load 'cookies'

while true
  id = []

  puts "Grabbing trades..."  
  page = mechanize.get("http://www.tf2outpost.com/trades")
  page.search(".trade_bump").each do |x|
    id.push(x["data-tradeid"])
  end
  
  puts "Bumping #{id.length} trades!"
  id.each do |i|
    mechanize.post('http://www.tf2outpost.com/api/core', {
      action: "trade.bump",
      hash: "your-cookie-hash-here",
      tradeid: i.to_s
    })
  end
  
  extra = rand(30)
  puts "Sleeping!"
  for i in 1..1900
    if i % 20 == 0
      puts "Time left: #{1900-i}"
    end
    sleep(1)
  end
  puts "Sleeping a random value: #{extra} seconds!"
  sleep(extra)
end