class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def update
  end

  def destroy
  end

  def destroy_all
    CartItem.destroy_all
    current_customer.cart_item.destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item = current_customer.cart_items.build(cart_item_params)
    @cart_item.save
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
