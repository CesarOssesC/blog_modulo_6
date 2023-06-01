class ApplicationController < ActionController::Base
    # Podriamos utilizar los sanitizers directamente en el ApplicationController sin necesidad
    # de crear los controllers de devise, y se haría de la forma que aparece a continuacion.
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :age])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :age])
    end

    def after_sign_in_path_for(resource)
        posts_path
    end

    def authorized_request(kind = nil)
        unless kind.include?(current_user.role)
            redirect_to posts_path, notice: "No estas autorizado para realizar esta acción"
        end
    end
end
