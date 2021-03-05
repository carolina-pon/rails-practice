class ApplicationController < ActionController::Base
  helper_method :current_user
  # flashメッセージがデフォルトだとnoticeとalertしか使えないので、以下4つを追加で使用できるように。
  add_flash_types :success, :info, :warning, :danger

  private

  # 　@current_user = @current_user || User.find_by(id: session[:user_id]) と同じ。
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
