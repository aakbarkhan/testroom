class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google
        @user = User.from_omniauth(request.env["omniauth.auth"])
        if @user.persisted?
            sign_in_and_redirect @user, event: :authentication
            set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
        else
            session["devise.google_oauth2_data"] = request.env["omniauth.auth"]
            redirect_to new_user_registration_url
        end
    end

    def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
        data = access_token.info
        user = User.where(:email => data["email"]).first
    
        # Uncomment the section below if you want users to be created if they don't exist
        # unless user
        #     user = User.create(name: data["name"],
        #        email: data["email"],
        #        password: Devise.friendly_token[0,20]
        #     )
        # end
        user
    end

    def failure
        redirect_to root_path
    end
end
