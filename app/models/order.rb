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
           array << order_detail.price * order_detail.amount
       end
        array.sum
    end
    
    def change_order_details_status
        if self.status == "payment_waiting"
          self.order_details.update(making_status: "production_not_possible")
        elsif self.status == "payment_confirmation"
          self.order_details.update(making_status: "production_pending")
        end
    end
  
    enum payment_method:{credit_card:0,transfer:1}
    enum status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4}

end
