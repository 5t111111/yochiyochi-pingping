namespace :website do
  desc 'Task for waking up websites by getting its content'
  task :wakeup => :environment do
    require 'net/http'
    require 'thwait'
    threads = []
    puts "--- WAKEUP START: #{Time.now}"
    Website.find_each do |website|
      uri = URI.parse(website.url)
      threads << Thread.new do
        # puts "INFO: #{uri} is going to be pinged."
        Net::HTTP.get(uri)
        # puts "INFO: #{uri} is pinged."
      end
    end
    ThreadsWait.all_waits(*threads)
    puts "--- WAKEUP FINISH: #{Time.now}"
  end
end
