class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new(cart_item_params)
    @cart_item = current_customer.cart_items.build(cart_item_params)
    @cart_item.save
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :is_active)
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
