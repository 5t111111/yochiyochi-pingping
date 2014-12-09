require 'test_helper'

class WebsiteTest < ActiveSupport::TestCase
  def setup
    @user = users(:test_user_1)
    @website = @user.websites.build(url: 'http://test.example.com')
  end

  test 'url should not be blank' do
    @website.url = '     '
    assert_not @website.valid?
  end

  test 'url length should not exceed 255' do
    @website.url = 'http://' + 'a' * 245 + '.com'
    assert_not @website.valid?
  end

  test 'url should be valid for a valid http url' do
    @website.url = 'http://www.example.com'
    assert @website.valid?
  end

  test 'invalid format url should be treated as invalid' do
    invalid_urls = %w(http:/www.example.com <>hi www.example.com example.com)
    invalid_urls.each do |invalid_url|
      @website.url = invalid_url
      assert_not @website.valid?, "#{invalid_url.inspect} should be invalid"
      assert @website.errors.key?(:url), "#{invalid_url.inspect} should have :url key in errors"
      assert @website.errors[:url][0] == 'は不正なURLです', "#{@website.errors[:url][0]}"
    end
  end

  test 'only http/https protocol should be valid' do
    invalid_urls = %w(ftp://ftp.google.com ssh://google.com)
    invalid_urls.each do |invalid_url|
      @website.url = invalid_url
      assert_not @website.valid?, "#{invalid_url.inspect} should be invalid"
      assert @website.errors.key?(:url), "#{invalid_url.inspect} should have :url key in errors"
      assert @website.errors[:url][0] == 'は http / https で始まる必要があります', "#{@website.errors[:url][0]}"
    end
  end

  test "should be alphabetically ordered" do
    assert_equal Website.first, websites(:four)
    assert_equal Website.last, websites(:two)
  end
end
