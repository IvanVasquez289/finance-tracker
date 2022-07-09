class UsersController < ApplicationController
  def my_portfolio
    @acciones_rastreadas = current_user.stocks
  end
  
  def my_friends
    @mis_amigos = current_user.friends
  end
end
