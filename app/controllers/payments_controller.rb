class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]

    def success
    end

    def webhook
        payment_id= params[:data][:object][:payment_intent]
        payment = Stripe::PaymentIntent.retrieve(payment_id)

        product_id = payment.metadata.product_id
        buyer_id = payment.metadata.buyer_id
        seller_id = payment.metadata.seller_id
        product_name = payment.metadata.product_name
        product_price = payment.metadata.product_price
        
        p "*******************************"
        p product_id, buyer_id, seller_id, product_name, product_price
        p "*******************************"

        # order_details = JSON.parse(payment.metadata)
        # Order.create(order_details)

        @order = Order.new(
            product_id: product_id,
            buyer_id: buyer_id,
            seller_id: seller_id,
            product_name: product_name,
            product_price: product_price
        )

        respond_to do |format|
            if @order.save
              format.html { redirect_to @order, notice: 'Product was successfully created.' }
              format.json { render :show, status: :created, location: @order }
            else
              format.html { render :new }
              format.json { render json: @order.errors, status: :unprocessable_entity }
            end
        end

    end
end