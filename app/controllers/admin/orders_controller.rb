class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.subtotal }
    @order.postage = 800
    @order.total_payment = @order.postage + @total.round.to_i
  end

  def update
    @order = Order.find(params[:id])
    status = (params[:order][:status]).to_i
    status_change_to_1 = @order.status_was == 0 and @order.status == 1
    if @order.update(status: status)
      @order.order_details.update_all(make_status: 1)
    redirect_to admin_order_path(@order)
    end
  end


  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :payment_method, :total_payment, :postage, :status)
  end
end
