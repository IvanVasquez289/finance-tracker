class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @acciones_rastreadas = current_user.stocks
  end
  
  def my_friends
    @mis_amigos = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @acciones_rastreadas = @user.stocks
  end
  
  # def search
  #   friend = params[:friend]  estos son los parametros que recibimos de la url
  #   render json: friend
  # end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends.count < 1
        respond_to do |format|
          flash.now[:alert] = 'No se pudo encontrar el usuario'
          format.js { render partial: 'users/friend_result' }
        end
      else
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Por favor ingresa el nombre del amigo o el correo'
        format.js { render partial: 'users/friend_result' }
      end
    end
  end



end
