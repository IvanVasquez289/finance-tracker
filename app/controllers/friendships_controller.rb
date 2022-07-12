class FriendshipsController < ApplicationController
  def create
  end

  def destroy
    friend = User.find(params[:id])
    friendship = Friendship.where(user_id: current_user.id , friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Dejaste de seguir a #{friend.full_name} "
    redirect_to my_friends_path
  end
end
