class Website < ActiveRecord::Base
  validates :url,
            presence: true,
            length: { maximum: 255 },
            uri: true
end
