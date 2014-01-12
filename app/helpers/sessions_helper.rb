module SessionsHelper
  def register(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_member = user
  end

  def registered?
    !current_member.nil?
  end

  def current_member=(user)
    @current_member = user
  end

  def current_member
    remember_token = User.encrypt(cookies[:remember_token])
    @current_member ||= User.find_by(remember_token: remember_token)
  end

  def current_member?(user)
    user == current_member
  end

  def forget_user
    self.current_member = nil
    cookies.delete(:remember_token)
  end

  def is_registered
    unless registered?
      redirect_to new_user_url
      flash[:warning] = "Please register from this page"
    end
  end
end