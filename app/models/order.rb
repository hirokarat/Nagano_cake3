class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer

    # 注文の全ての数量合計
    def sum_order_items
        self.order_details.all.sum(:amount)
    end

    #注文の合計金額
    def total_price
        array = []
        self.order_details.each do |order_detail|
           array << order_detail.tax_price * order_detail.amount
       end
        array.sum
    end

#   def self.billing(order)
#       total_price(current_cart) + order.shipping_cost
#   end


    enum payment_method:{credit_card:0,transfer:1}
    # enum select_address:{customer_address:0,registered_address:1,new_address:2}
    enum order_status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4}

end
