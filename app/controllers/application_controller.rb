class ApplicationController < ActionController::Base
    include SessionsHelper
    before_action :login_required
    private
    def login_required
        redirect_to new_session_path unless current_user
    end
    def login_or_sigin_not_required
        if current_user
            redirect_to tasks_path
        end
    end
end
