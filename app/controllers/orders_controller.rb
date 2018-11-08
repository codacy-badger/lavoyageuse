class OrdersController < ApplicationController
  def show
    @user = current_user
    @order = Order.where(state:"paid").find(params[:id])
  end

  def create
    plan = Plan.find(params[:plan_id])
    order = Order.create!(plan_sku: plan.name, amount: plan.price, state: 'pending', user: current_user)

    redirect_to new_user_order_payment_path(current_user, order)
  end
end
