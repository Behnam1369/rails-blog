class UsersController < ApplicationController
  def index; end

  def show
    params
  end

  def update
    current_user['name'] = params[:user][:name]
    current_user.image = params[:user][:image]
    current_user['bio'] = params[:user][:bio]

    if current_user.save
      redirect_to '/users'
    else
      flash.now[:error] = ' '
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params['id'])
  end

  def user_params
    params.require(:user).permit(:name, :image, :bio)
  end
end
