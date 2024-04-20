class UsersController < ApplicationController

    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)

        # @user.status = :active
        
        # store all emails in lowercase to avoid duplicates and case-sensitive login errors:
        @user.email.downcase!
        
        if @user.save
            # If user saves in the db successfully:
            flash[:notice] = "Account created successfully!"
            redirect_to login_path
        else
            # If user fails model validation - probably a bad password or duplicate email:
            flash.now.alert = "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
            render :new
        end
    end
        

    # ##############################
    before_action :authorize, except: [:new, :create]

    def index
        @users = User.all
    end
    
    # def block
    #   users = User.where(id: params[:user_ids])
    #   users.update_all(status: :blocked)
    #   redirect_to users_path, notice: 'Users blocked successfully!'
    # end

    def block
      users = User.where(id: params[:user_ids])
      
      # Check if current user is among the blocked users
      if users.pluck(:id).include?(current_user.id)
        users.each { |user| user.update(status: :blocked) }
        session.delete(:user_id)
        redirect_to login_path, notice: "You have blocked your account."
        return
      end
    
      users.each { |user| user.update(status: :blocked) }
      redirect_to users_path, notice: 'Users blocked successfully!'
    end
    
  
    def unblock
      users = User.where(id: params[:user_ids])
      users.update_all(status: :active)
      redirect_to users_path, notice: 'Users unblocked successfully!'
    end
  
    def destroy
      users = User.where(id: params[:user_ids])
   
      users.destroy_all
      # Log out the current user
      session.delete(:user_id)
  
    
      redirect_to login_path, notice: "Your account has been deleted."
      return
    
      # If the current user is not being deleted, simply delete the selected users
      users.destroy_all
      redirect_to users_path, notice: 'Users deleted successfully!'
    end
    
    
      

    ###############################

    
    private
    
    def user_params
    # strong parameters - whitelist of allowed fields #=> permit(:name, :email, ...)
    # that can be submitted by a form to the user model #=> require(:user)
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :status)
    end
end
