require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:test_user_1)
  end

  test 'associated websites should be destroyed' do
    @user.save
    assert_difference 'Website.count', -1 do
      @user.destroy
    end
  end
end
