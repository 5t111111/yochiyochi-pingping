require 'test_helper'

class WebsitesControllerTest < ActionController::TestCase
  setup do
    @website = websites(:one)
    @website_two = websites(:two)
  end

  test 'should get index and website should be assigned when logged in' do
    log_in_as(users(:test_user_1))
    get :index
    assert_response :success
    assert_not_nil assigns(:websites)
    assert_not_nil assigns(:website)
  end

  test 'should get index and websites should not be assigned when not logged in' do
    get :index
    assert_response :success
    assert_not_nil assigns(:websites)
    assert_nil assigns(:website)
  end

  test 'should create website when logged in' do
    log_in_as(users(:test_user_1))
    assert_difference('Website.count') do
      post :create, website: { url: 'http://example.com' }
    end

    assert_redirected_to root_path
    assert_not flash.empty?
    assert flash[:success] == 'Webサイトの情報は正常に登録されました', "actual => #{flash[:success]}"
  end

  test 'should not create website when not logged in' do
    assert_no_difference('Website.count') do
      post :create, website: { url: 'http://example.com' }
    end

    assert_redirected_to root_path
    assert_not flash.empty?
    assert flash[:danger] == 'ログインが必要です', "actual => #{flash[:danger]}"
  end

  test 'should get edit when logged in' do
    log_in_as(users(:test_user_1))
    get :edit, id: @website
    assert_response :success
  end

  test 'should not get edit when not logged in' do
    get :edit, id: @website
    assert_redirected_to root_path
    assert_not flash.empty?
    assert flash[:danger] == 'ログインが必要です', "actual => #{flash[:danger]}"
  end

  test 'should not get edit when logged in but not owner' do
    log_in_as(users(:test_user_1))
    get :edit, id: @website_two
    assert_redirected_to root_path
    assert_not flash.empty?
    assert flash[:danger] == 'このページへの操作は許可されていません', "actual => #{flash[:danger]}"
  end

  test 'should update website when logged in' do
    log_in_as(users(:test_user_1))
    patch :update, id: @website, website: { url: 'http://update.example.com' }
    assert_redirected_to root_path
    assert_not flash.empty?
    assert flash[:success] == 'Webサイトの情報は正常に更新されました', "actual => #{flash[:success]}"
  end

  test 'should not update website when not logged in' do
    patch :update, id: @website, website: { url: 'http://update.example.com' }
    assert_redirected_to root_path
    assert_not flash.empty?
    assert flash[:danger] == 'ログインが必要です', "actual => #{flash[:danger]}"
  end

  test 'should not update website when logged in but not owner' do
    log_in_as(users(:test_user_1))
    patch :update, id: @website_two, website: { url: 'http://update.example.com' }
    assert_redirected_to root_path
    assert_not flash.empty?
    assert flash[:danger] == 'このページへの操作は許可されていません', "actual => #{flash[:danger]}"
  end

  test 'should destroy website when logged in' do
    log_in_as(users(:test_user_1))
    assert_difference('Website.count', -1) do
      delete :destroy, id: @website
    end
    assert_redirected_to root_path
    assert_not flash.empty?
    assert flash[:success] == 'Webサイトの情報は正常に削除されました', "actual => #{flash[:success]}"
  end

  test 'should not destroy website when not logged in' do
    assert_no_difference('Website.count') do
      delete :destroy, id: @website
    end
    assert_redirected_to root_path
    assert_not flash.empty?
    assert flash[:danger] == 'ログインが必要です', "actual => #{flash[:danger]}"
  end

  test 'should not destroy website when logged in but not owner' do
    log_in_as(users(:test_user_1))
    assert_no_difference('Website.count') do
      delete :destroy, id: @website_two
    end
    assert_redirected_to root_path
    assert_not flash.empty?
    assert flash[:danger] == 'このページへの操作は許可されていません', "actual => #{flash[:danger]}"
  end
end
