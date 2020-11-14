class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :display_name, :first_name, :last_name, :password, :password_confirmation) }
        end

        def after_sign_in_path_for(user)
            products_path
        end

        def after_sign_out_path_for(user)
            root_path
        end
end
