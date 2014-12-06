class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    #return if value.blank?
    if value.include?(' ')
      record.errors[attribute] << (options[:message] || "can't have any space(s)")
      return false
    end
    begin
      uri = URI.parse(value)
    rescue URI::InvalidURIError
      record.errors[attribute] << (options[:message] || 'is not a valid url')
      return false
    end
    unless uri.is_a?(URI::HTTP)
      record.errors[attribute] << (options[:message] || 'is not http/https')
      return false
    end
  end
end

class WebApp < ActiveRecord::Base
  validates :url,
            presence: true,
            length: { maximum: 255 },
            url: true
end
