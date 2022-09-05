class Item < ApplicationRecord
  has_one_attached:image
  
  has_many :order_details, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  
  belongs_to:genre
  
  validates :genre_id, :name, :price, presence: true
  validates :introduction, length: {maximum: 200}
  validates :price, numericality: { only_integer: true }
  
end
