class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend])
    friendship = Friendship.create(user_id: current_user.id , friend_id: friend.id)

    if friendship.save
      flash[:notice] = "Ahora tu y #{friend.full_name} son amigos"
    else
      flash[:notice] = "Hubo un error con tu solicitud"
    end
    redirect_to my_friends_path
  end

  def destroy
    friend = User.find(params[:id])
    friendship = Friendship.where(user_id: current_user.id , friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Dejaste de seguir a #{friend.full_name} "
    redirect_to my_friends_path
  end
end
