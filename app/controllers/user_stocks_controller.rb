class UserStocksController < ApplicationController

  def create
    # si doy click en agregar a mi portafolio, primero revisa si ya se encuentra en la db
    stock = Stock.revisar_db(params[:ticker])

    # Si no esta procede a crear esa stock y le daremos save para que haga hit a la db y tenga id
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end

    # de forma implicita obtiene el id del user y del stock
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "La accion #{stock.name} se agrego con exito a tu portafolio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    user_stock.destroy
    flash[:notice] = "#{stock.ticker} se elimino con exito del portafolio"
    redirect_to my_portfolio_path
  end

end
