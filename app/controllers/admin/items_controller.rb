class Admin::ItemsController < ApplicationController
  before_action :set_q

  def index
    @results = @q.result
    if @results == nil
      @items = Item.page(params[:page]).per(8)
    else
      @items = @results.page(params[:page]).per(8)
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
       redirect_to admin_item_path(@item)
    # else
    #   render :new
    # end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item)
  end



  private
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :is_active, :genre_id)
  end

  def set_q
    @q = Item.ransack(params[:q])
  end


end
