class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    create!(
      name: auth['info']['nickname'],
      provider: auth['provider'],
      uid: auth['uid'].to_s,
      avatar_url: auth['info']['image'])
  end
end
