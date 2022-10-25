class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]

  def index
    @results = @q.result
    if @results == nil
      @items = Item.page(params[:page]).per(8)
    else
      @items = @results.page(params[:page]).per(8)
    end

    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:id])
      @items = @genre.items.page(params[:page]).per(8)
    else
      @items = Item.page(params[:page]).per(8)
    end
  end
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :is_active)
  end

end
