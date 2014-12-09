require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:test_user_1)
  end

  test 'associated microposts should be destroyed' do
    @user.save
    @user.websites.create!(url: 'http://test.example.com')
    assert_difference 'Website.count', -1 do
      @user.destroy
    end
  end
end
