class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    elsif params[:order][:address_number] == "2"
      if Address.exists?(id: params[:order][:registered])
        @order.postal_code = Address.find(params[:order][:registered]).postal_code
        @order.address = Address.find(params[:order][:registered]).address
        @order.name = Address.find(params[:order][:registered]).name
      else
        render :new
      end
    elsif params[:order][:address_number] == "3"
      address_new = current_customer.addresses.new(address_params)
      if address_new.save
      else
        render :new
      end
    end
    @cart_items = current_customer.cart_items.all
    # @order.payment_methods_i18n = @order.payment_method_id
    @order.postage = 800
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.total_payment = @order.postage + @total.round.to_i
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.purchase_price = cart_item.item.add_tax_price
      @order_detail.save
    end

    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path

  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.subtotal }
    @order.postage = 800
    @order.total_payment = @order.postage + @total.round.to_i
  end


  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :payment_method, :total_payment, :postage, :status)
  end

  def address_params
    params.require(:order).permit(:customer_id, :name, :postal_code, :address)
  end
end
