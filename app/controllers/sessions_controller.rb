class SessionsController < ApplicationController
    skip_before_action :login_required, only: [:new, :create]

    before_action :login_or_sigin_not_required, only: %i[ new create ]
    
    def new
        @user = User.new
    end
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            redirect_to tasks_path
        else
            flash.now[:danger] = 'Je n\'ai pas réussi à me connecter'
            render :new
        end
    end
    def destroy
      session.delete(:user_id)
      flash[:notice] = 'Vous avez été déconnecté.'
      redirect_to new_session_path
    end
end
