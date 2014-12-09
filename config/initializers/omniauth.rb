Rails.application.config.middleware.use OmniAuth::Builder do  
  #provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']
  provider :github, '6da55cfed1aade79781c', '00125a5308574f8c325083b606a0acf3872629a2'
end
