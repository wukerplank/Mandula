class UsersController < ApplicationController
  
  def auth
    auth = request.env['omniauth.auth']
    
    if @user = User.find_by_twitter_uid(auth[:uid])
      # ... gibt's, tuma was
    else
      @user = User.create(
        :nickname    => auth['info']['name'],
        :twitter_uid => auth[:uid],
        :provider_hash => auth.to_yaml
      )
    end
    
    redirect_to '/index.html'
  end
  
  def auth_failure
    # ... handle the error
  end
  
end
