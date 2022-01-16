class WwyfBaseController < ActionController::Base
  before_action :authenticate_admin!
  before_action :track_action

  private

  def authenticate_admin!
    authenticate_user!
    current_user.is_admin? or raise "not authorized"
  end

  def track_action
    return unless current_user

    today = Time.now.to_date
    track_action_for_user(current_user, today)

    # also track org and biz profiles:
    if defined? current_organization_profile
      if current_organization_profile&.shadow_user
        track_action_for_user(current_organization_profile.shadow_user, today)
      end
    end
  end

  def track_action_for_user(something, date)
    # do some trackety-track action here
  end
end
