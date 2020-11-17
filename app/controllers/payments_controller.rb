class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]

    def success
    end

    def webhook
        payment_id= params[:data][:object][:payment_intent]
        payment = Stripe::PaymentIntent.retrieve(payment_id)
            product_id = payment.metadata.product_id
            buyer_id = payment.metadata.buyer_id
            seller_id = payment.metadata.buyer_id
            product_name = payment.metadata.product_name
            product_price = payment.metadata.product_price

        Order.create(product_id:product_id, buyer_id:buyer_id, seller_id:seller_id, product_name:product_name, product_price:product_price)
    end
end