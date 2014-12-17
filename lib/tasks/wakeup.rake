namespace :website do
  desc 'Task for waking up websites by getting its content'
  task :wakeup => :environment do
    require 'net/http'
    require 'thwait'
    threads = []
    m = Mutex.new
    puts "====== WAKEUP START: #{Time.now} ======"
    Website.find_each do |website|
      uri = URI.parse(website.url)
      threads << Thread.new do
        m.synchronize do
          puts "  +++ #{uri} is going to be pinged."
        end
        Net::HTTP.get(uri)
        m.synchronize do
          puts "  --- #{uri} is pinged."
        end
      end
    end
    ThreadsWait.all_waits(*threads)
    puts "====== WAKEUP FINISH: #{Time.now} ======"
  end
end
