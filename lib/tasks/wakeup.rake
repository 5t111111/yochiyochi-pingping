def fetch(uri_str, limit = 10)
  return nil if limit == 0 # HTTP redirect too deep
  url = URI.parse(uri_str)
  response = Net::HTTP.get_response(url)
  case response
  when Net::HTTPSuccess     then response
  when Net::HTTPRedirection then fetch(response['location'], limit - 1)
  else
    response.error!
  end
end

namespace :website do
  desc 'Task for waking up websites by getting its content'
  task :wakeup => :environment do
    require 'net/http'
    require 'thwait'
    Thread.abort_on_exception = true
    threads = []
    m = Mutex.new
    puts "====== WAKEUP START: #{Time.now} ======"
    Website.find_each do |website|
      uri = website.url
      threads << Thread.new do
        m.synchronize do
          puts "+++ #{uri} is going to be pinged."
        end
        res = fetch(uri, 3)
        m.synchronize do
          if res.is_a?(Net::HTTPSuccess)
            puts "--- #{uri} is pinged."
            # puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
            # puts res.body.slice(0, 1000) if res.body
            # puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
          else
            puts "xxx #{uri} is failed to be pinged."
          end
        end
      end
    end
    ThreadsWait.all_waits(*threads)
    puts "====== WAKEUP FINISH: #{Time.now} ======"
  end
end
