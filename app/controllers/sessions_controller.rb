class SessionsController < ApplicationController
    skip_before_action :login_required, only: [:new, :create]

    def new
    end
    def create
        user=User.find_by(email: params[:session][:email].downcase)
        if user&.authenticate(params[:session][:password])
            log_in(user)
            flash[:notice]='Connecté avec succès'
            redirect_to user_path(user.id)
        else
            flash.now[:notice]='La connexion à échouer'
            render :new
        end    
    end    

    def destroy
        session.delete(:user_id)
        flash[:notice]='Déconnecté avec succès'
        redirect_to new_session_path
    end 
end
