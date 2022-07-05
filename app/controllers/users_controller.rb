class UsersController < ApplicationController
  def my_portfolio
    @acciones_rastreadas = current_user.stocks
  end
end
