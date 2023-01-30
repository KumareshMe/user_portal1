class Admin::UserPortalsController < ApplicationController
  # before_action :pundit_authorize

  def index
    @user_portals = UserPortal.search(params)
    @total = @user_portals.count
  end

  def reports
    @user_portals = UserPortal.search(params)
    @user_portals = @user_portals.page(params[:page] || 1).per(params[:per] || 20)
  end

  def create
    @user_portal = UserPortal.new

    return unless request.post?

    @user_portal = UserPortal.new(user_portal_params)

    if @user_portal.save
      redirect_to @user_portal, notice: 'User successfully created.'
    end
  end

  def update
    @model = MobileBanner.find(params[:id])

    return unless request.patch?

    if @user_portal.update(user_portal_params)
      redirect_to @user_portal, notice: 'User successfully updated.'
    end
  end

  def destroy
    @user_portal.destroy
    redirect_to user_portals_url, notice: 'User successfully destroyed.'
  end

  private
  # Only allow permitted parameter and raise an error if unpermitted parameter is found
  def user_portal_params
    # params.require(:user_portal).permit(:first_name, :last_name, :role, :image)
  end

  # define the roles in the policy file app/policies/user_portal_policy.rb and allow only those roles to access the pages
  def pundit_authorize
    authorize :user_portals
  end
end
