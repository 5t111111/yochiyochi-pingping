require 'test_helper'

class WebAppTest < ActiveSupport::TestCase
  def setup
    @web_app = WebApp.new(url: 'test@example.com')
  end

  test 'should be valid' do
    @web_app.url = '     '
    assert_not @web_app.valid?
  end
end
