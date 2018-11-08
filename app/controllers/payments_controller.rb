class PaymentsController < ApplicationController
  before_action :set_order

  def new; end

  def create
    user = current_user
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    user.stripe_customer_id ||= customer.id
    user.save!

    charge = Stripe::Charge.create(
      customer:     user.stripe_customer_id,
      amount:       @order.amount_cents,
      description:  "Paiement pour #{@order.plan_sku}, commande #{@order.id}",
      currency:     @order.amount.currency
    )

    @order.update(payment: charge.to_json, state: 'paid')
    user.update(premium: true, premium_expiration: DateTime.now.next_year)

    redirect_to user_order_path(user,@order)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_order_payment_path(@order)
  end


  private

  def set_order
    @order = Order.where(state: 'pending').find(params[:order_id])
  end
end
