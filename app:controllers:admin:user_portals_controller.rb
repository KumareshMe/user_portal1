class Admin::UserPortalsController < ApplicationController
  # before_action :pundit_authorize

  def index
    @user_portals = UserPortal.search(params)
    @total = @user_portals.count
  end

  def create
    @user_portal = UserPortal.new

    return unless request.post?

    @user_portal = UserPortal.new(user_portal_params)

    if @user_portal.save
      flash[:notice] = 'User successfully created'
      redirect_to admin_user_portals_index_url
    end
  end

  def update
    @user_portal = UserPortal.find_by(id: params[:id])

    return unless request.patch?

    if @user_portal.update(user_portal_params)
      flash[:notice] = 'User successfully updated'
      redirect_to admin_user_portals_index_url
    end
  end

  def destroy
    @user_portal = UserPortal.find_by(id: params[:id])

    return unless request.delete?

    if @user_portal.destroy
      flash[:notice] = 'User successfully deleted'
      redirect_to admin_user_portals_index_url
    end
  end

  private

  # Only allow permitted parameter and raise an error if unpermitted parameter is found
  def user_portal_params
    params.require(:user_portal).permit(:first_name, :last_name, :role, :image)
  end

  # we can define the roles in the policy file app/policies/user_portal_policy.rb and allow only those roles to access the pages
  def pundit_authorize
    authorize :user_portals
  end
end
