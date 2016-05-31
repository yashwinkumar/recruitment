module Admin

  class UsersController < AdminController
    before_action :find_user, only: [:edit, :update, :destroy]
    
    layout 'dashboard'

    def index
      @users = User.joins(:roles).where("roles.name = ? OR roles.name = ? OR roles.name = ?", 'candidate', 'hm', 'consultant')
      authorize :"admin/user"
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
      ActiveRecord::Base.transaction do
        @user = User.new(user_params)
        @user.password = user_params[:password]
        @user.password_confirmation = user_params[:password]
        # @user.skip_confirmation!
        @user.add_role params[:role].to_sym
        if @user.save(validate: false)
          profile = @user.profile
          profile.first_name = user_params[:first_name]
          profile.last_name = user_params[:last_name]
          profile.save(validate: false)
          flash[:notice] = "User created."
          redirect_to admin_users_path
        else
          render 'new'
        end
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
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

    def find_user
      @user = User.where(params[:id]).first
    end
  end
end