class Admin::OrderDetailsController < ApplicationController
  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    make_status = params[:order_detail][:make_status].to_i
    @order_details.update(make_status: make_status)
    redirect_to admin_order_path(@order)
  end
end
