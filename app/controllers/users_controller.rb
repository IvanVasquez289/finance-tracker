class UsersController < ApplicationController
  def my_portfolio
    @acciones_rastreadas = current_user.stocks
  end
  
  def my_friends
    @mis_amigos = current_user.friends
  end

  # def search
  #   friend = params[:friend]  estos son los parametros que recibimos de la url
  #   render json: friend
  # end

  def search
    if params[:friend].present?
      @friend = params[:friend]
      if @friend
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = 'No se pudo encontrar el usuario'
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
