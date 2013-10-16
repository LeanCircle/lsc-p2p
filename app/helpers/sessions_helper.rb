module SessionsHelper

  def register(peer)
    remember_token = Peer.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    peer.update_attribute(:remember_token, Peer.encrypt(remember_token))
    self.current_peer = peer
  end

  def registered?
    !current_peer.nil?
  end

  def current_peer=(peer)
    @current_peer = peer
  end

  def current_peer
    remember_token = Peer.encrypt(cookies[:remember_token])
    @current_peer ||= Peer.find_by(remember_token: remember_token)
  end

  def current_peer?(peer)
    peer == current_peer
  end

  def registered_peer
    unless registered?
      store_location
      redirect_to register_url, notice: "Please register."
    end
  end

  def forget_peer
    self.current_peer = nil
    cookies.delete(:remember_token)
  end
  
end