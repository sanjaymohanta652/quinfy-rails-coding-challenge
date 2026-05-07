class OrdersController < ApplicationController
  def index
    @orders = Order.includes(:order_items)
                  .where.not(state: "COMPLETED")
                  .order(ordered_at: :desc)
  end

  def update
    @order = Order.find(params[:id])
    @order.update!(state: "COMPLETED")
    redirect_to root_path, notice: "Order completed successfully."
  end
end
