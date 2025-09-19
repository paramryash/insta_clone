module Accounts
  class RegistrationsController < Devise::RegistrationsController
    # Agar destroy action customize karna hai
    def destroy
      resource.destroy
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      redirect_to root_path, notice: "Account deleted successfully."
    end
  end
end
