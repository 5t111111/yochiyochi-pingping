class WebApp < ActiveRecord::Base
  validates :url, presence: true
end
