class Order < ApplicationRecord
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [50, 50]
  end
  # has_one_attached :avatar
  validates :name, :email, :address, :phone, :message, presence: true
end
