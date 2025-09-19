class Accounts::RegistrationsController < Devise::RegistrationsController
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    redirect_to root_path, notice: "Account deleted successfully."
  end
end