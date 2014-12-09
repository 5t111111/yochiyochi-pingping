class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    create!(
      name: auth['login'],
      provider: auth['provider'],
      uid: auth['id'].to_s,
      avatar_url: auth['avatar_url'])
  end
end
