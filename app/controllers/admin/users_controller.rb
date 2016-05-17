module Admin

  class UsersController < AdminController
    before_action :find_user, only: [:edit, :update, :destroy]

    def index
      @users = User.joins(:roles).where("roles.name = ? OR roles.name = ?", 'hm', 'consultant')
    end

    def verify
      @user = User.find(params[:user_id])
      if @user.update(verification: params[:verification])
        flash[:success] = "User successfully verified!!"
      else
        flash[:error] = "Error verifying User."
      end
      redirect_to admin_users_path
    end

    def new
      @user = User.new
    end

    def destroy
    end

    def edit
    end

    def create
      @user = User.new(params[:id])
      if @user.save(validate: false)
        flash[:notice] = "User created."
        redirect_to admin_users_path
      else
        render 'new'
      end
    end

    def update
      if @user.update(user_params)
        flash[:notice] = 'User updated'
        redirect_to admin_users_path
      else
        render 'edit'
      end
    end

    private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end

    def find_user
      @user = User.find(params[:id])
    end
  end
end