class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user
        items = user.items
      else
        return render json: { error: "User not found" }, status: :not_found
      end
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find_by(id: params[:id])
    if item
      render json: item
    else
      render json: { error: "Item not found" }, status: :not_found
    end
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(item_params)
    render json: item, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

end
