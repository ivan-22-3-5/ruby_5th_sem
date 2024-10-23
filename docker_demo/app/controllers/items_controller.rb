class ItemsController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    render json: @item
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      render json: @item, status: :created
    else
      render json: { error: @item.errors }, status: :unprocessable_entity
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    render json: @item
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :stock)
  end

  def handle_parameter_missing(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end
end
