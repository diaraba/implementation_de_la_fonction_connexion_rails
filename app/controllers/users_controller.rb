class UsersController < ApplicationController
    before_action :correct_user, only: [:show, :edit, :update]
    before_action :set_blog, only: [:show, :edit, :update, :destroy]
    skip_before_action :login_required, only: [:new, :create]

    def new
        @user=User.new
    end

    def create
        @user=User.new(user_params)
        if @user.save
            flash[:notice]='Compte créer avec succès'
            log_in(@user)
            redirect_to user_path(@user.id)
        else
            render :new
        end        
    end   

    def update
        if @user.update(user_params)
            flash[:notice]='Compte mise à jour avec succès'
            redirect_to user_path(@user.id)
        else
          render :edit
        end
    end
    
    def destroy
        @user.destroy
        flash[:notice]='Compte supprimer avec succès'
        redirect_to new_session_path
    end

    def edit
    end   
    
    def show
    end  

    private

    def set_blog
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end    

    def correct_user
        @user=User.find(params[:id])
        redirect_to current_user unless current_user?(@user)
    end   
end
