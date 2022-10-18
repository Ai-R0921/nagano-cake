class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.subtotal }
    @order.postage = 800
    @order.total_payment = @order.postage + @total.round.to_i
  end

  def update
  end


  private
  def oeder_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :payment_method, :total_payment, :postage, :status)
  end
end
