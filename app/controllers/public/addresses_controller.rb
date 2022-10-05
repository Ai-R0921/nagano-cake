class Public::AddressesController < ApplicationController
  def index
    @address = current_customer
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
