class UsersController < ApplicationController
  
  def show
    @user = User.find_by_nickname(params[:id])
    respond_to do |format|
      format.json{ render :json=>@user.to_json(:except=>[:id, :twitter_uid, :auth_token, :provider_hash]) }
    end
  end
  
  def auth
    auth = request.env['omniauth.auth']
    
    if @user = User.find_by_twitter_uid(auth[:uid])
      cookies['AUTH_TOKEN'] = @user.generate_new_auth_token!
      cookies['nickname']   = @user.nickname
    else
      @user = User.create(
        :nickname    => auth['info']['name'],
        :twitter_uid => auth[:uid],
        :provider_hash => auth.to_yaml
      )
      cookies['AUTH_TOKEN'] = @user.auth_token
      cookies['nickname']   = @user.nickname
    end
    
    redirect_to '/'
  end
  
  def auth_failure
    # ... handle the error
  end
  
  def logout
    cookies.delete('AUTH_TOKEN')
    cookies.delete('nickname')
    current_user.generate_new_auth_token!
    @current_user = nil
    redirect_to '/#/'
  end
  
end
