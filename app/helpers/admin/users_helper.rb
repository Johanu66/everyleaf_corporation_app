module Admin::UsersHelper
    def form_url(user)
        if action_name == 'new' || action_name == 'create'
            "/admin/users"
        elsif action_name == 'edit' || action_name == 'update'
            "/admin/users/#{user.id}"
        end
    end
end
