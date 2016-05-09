module Admin

	class UsersController < AdminController

	  def index
		@admins = User.joins(:roles).where("roles.name = ?", 'admin')
	  end

      def verify
      	@admin = User.find(params[:user_id])
      	if @admin.update(verification: params[:verification])      	
            flash[:success] = "User successfully verified!!"
        else
            flash[:error] = "Error verifying User "
        end
        redirect_to admin_users_path
       end

      def new
      	@admin = User.new
      end

      def delete
      end

      def edit
      	@admin = User.find(params[:id])
      end

      def create
      	@admin = User.new(params[:id])
  	    if @admin.save
	  		flash[:notice] = 'Admin created'
	  		redirect_to admin_users_path
  	    else
  		    render 'new'
  	    end
  	  end

  	    def update
  	      @admin = User.find(params[:id])
          if @admin.update(user_params)
	  		flash[:notice] = 'Admin updated'
	  		redirect_to admin_users_path
  	      else
	  		  render 'edit'
	  	  end
        end

        private
        def user_params
           params.require(:user).permit(:email)
        end

        def find_user
          @user = User.find(params[:id])
        end
    end
end