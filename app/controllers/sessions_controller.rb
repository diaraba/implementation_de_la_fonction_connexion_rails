class SessionsController < ApplicationController
    skip_before_action :login_required, only: [:new, :create]

    def new
    end
    def create
        user=User.find_by(email: params[:session][:email].downcase)
        if user&.authenticate(params[:session][:password])
            log_in(user)
            flash[:notice]='Vous êtes connecté'
            redirect_to tasks_path
        else
            flash.now[:notice]='L\'adresse e-mail ou le mot de passe est incorrect'
            render :new
        end    
    end    

    def destroy
        session.delete(:user_id)
        flash[:notice]='Vous êtes déconnecté'
        redirect_to new_session_path
    end 
end
