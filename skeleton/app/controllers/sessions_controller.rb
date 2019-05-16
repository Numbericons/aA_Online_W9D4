class SessionsController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user_name], params[:password])

    if user
      session[:session_token] = user.session_token
      flash[:success] = "Successfully logged in!"
      redirect_to cats_url
    else
      flash[:error] = "Wrong info honkey!"
      render :new, status: 401
    end
  end

  def destroy
  end
end