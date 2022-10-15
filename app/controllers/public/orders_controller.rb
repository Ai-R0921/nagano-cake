class Public::OrdersController < ApplicationController
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
      if Address.exists?(name: params[:order][:registered])
        @order.postal_code = Address.find(params[:order][:registered]).postal_code
        @order.address = Address.find(params[:order][:registered]).address
        @order.name = Address.find(params[:order][:registered]).name
      else
        render :new
      end
    elsif params[:order][:address_number] == "3"
      address_new = current_customer.Address.new(address_params)
      if address_new.save
      else
        render :new
      end
    end
    @cart_items = current_customer.cart_items.all
    @order.postage = 800
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.total_payment = @order.postage + @total.round.to_i
  end

  def complete
  end

  def create
  end

  def index
  end

  def show
  end


  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :payment_method, :total_payment, :postage, :status)
  end

  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
end
