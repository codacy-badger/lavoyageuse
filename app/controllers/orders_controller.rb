class OrdersController < ApplicationController

  def show
    @user = current_user
    @order = Order.where(state:"paid").find(params[:id])
  end

  def create
    if order_params[:state] == "offered"
      @user = User.find(params[:user_id])
      order = Order.new(order_params)
      order.user = @user
      if order.save!
        redirect_to @user
        flash[:success] = "Plan successfully offered !"
        # TODO: fix expiration on plan duration
        plan = Plan.find_by(name: order.plan_sku)
        @user.update(premium: true, premium_expiration: DateTime.now.next_year(plan.duration))
      else
        flash[:warning] = "Something went wrong"
      end
    else
      plan = Plan.find(params[:plan_id])
      order = Order.create!(plan_sku: plan.name, amount: plan.price, state: 'pending', user: current_user)
      redirect_to new_user_order_payment_path(current_user, order)
    end
  end

  private

  def order_params
    params.require(:order).permit(:plan_sku, :amount, :state)
  end
end
