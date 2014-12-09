class Website < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(:url) }
  validates :url,
            presence: true,
            length: { maximum: 255 },
            uri: true
end
