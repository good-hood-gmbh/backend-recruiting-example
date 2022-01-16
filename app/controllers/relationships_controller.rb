class RelationshipsController < WwyfBaseController
  skip_before_action :authenticate_admin!
  before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    render body: Oj.dump(current_user), content_type: 'application/json', status: :ok
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.json
    end
  end
end
