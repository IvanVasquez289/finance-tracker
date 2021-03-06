class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
        # render 'users/my_portfolio'
      else
        respond_to do |format|
          flash.now[:alert] = 'Por favor ingresa un simbolo valido'
          format.js { render partial: 'users/result' }
        end
        # redirect_to my_portfolio_path
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Por favor ingresa un simbolo para buscar'
        format.js { render partial: 'users/result' }
      end
      # redirect_to my_portfolio_path
    end
  end

end