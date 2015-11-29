require 'mechanize'

mechanize = Mechanize.new

puts "Loading cookies..."
mechanize.cookie_jar.load 'cookies'

while true
  id = []

  puts "Grabbing trades..."  
  begin
    page = mechanize.get("http://www.tf2outpost.com/trades")
    page.search(".trade_bump").each do |x|
      id.push(x["data-tradeid"])
    end

    if id.length > 0
      puts "Bumping #{id.length} trades!"
    else
      puts "No trades to bump trades are already bummped"
    end

    id.each do |i|
      mechanize.post('http://www.tf2outpost.com/api/core', {
        action: "trade.bump",
        hash: "ed5c6592b71ee18a8f499d2978b89915",
        tradeid: i.to_s
      })
    end
  rescue Exception => e  
    puts "Aw man an error occured: #{e}"
  end
  puts "Sleeping for 2 min..."
  sleep(120)
#   extra = rand(30)
#   puts "Sleeping!"
#   for i in 1..1900
#     if i % 20 == 0
#       puts "Time left: #{1900-i}"
#     end
#     sleep(1)
#   end
#   puts "Sleeping a random value: #{extra} seconds!"
#   sleep(extra)
end