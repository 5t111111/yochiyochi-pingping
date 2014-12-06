require 'addressable/uri'

class UriValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    uri = parse_uri(value)
    if !uri
      record.errors.add(attribute, :bad_uri, options)
    elsif !allowed_protocols.include?(uri.scheme)
      record.errors.add(attribute, :bad_protocol, protocols: allowed_protocols_humanized)
    end
  end

  private

  def allowed_protocols_humanized
    allowed_protocols.to_sentence(:two_words_connector => ' / ')
  end

  def allowed_protocols
    @allowed_protocols ||= [(options[:allowed_protocols] || ['http', 'https'])].flatten
  end

  def parse_uri(value)
    uri = Addressable::URI.parse(value)
    uri.scheme && uri.host && uri
  rescue URI::InvalidURIError, Addressable::URI::InvalidURIError, TypeError
  end
end
