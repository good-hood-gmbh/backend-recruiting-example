class ThankyousController < ApplicationController
  before_action :logged_in_user

  def create
    @business_profile = BusinessProfile.find(params[:business_profile_id])
    @current_user.thank(@business_profile)
    head :created
  end

  def destroy
    @business_profile = BusinessProfile.find(params[:business_profile_id])
    @current_user.unthank(@business_profile)
    head :deleted
  end
end
