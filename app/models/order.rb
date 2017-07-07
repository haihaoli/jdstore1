class Order < ApplicationRecord
  validates_presence_of :billing_name, :billing_address, :shipping_name, :shipping_address

  has_many :productlists

  before_create :generate_token

  belongs_to :user

  def generate_token
    self.token = SecureRandom.uuid
  end

  def pay!
    self.update(:is_paid => true)
  end

  include AASM

  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :order_cancelled
    state :good_retured

    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid
    end

    event :ship do
      transitions form: :paid, to: :shipping
    end

    event :deliver do
      transitions from: :shipping, to: :shipped
    end

    event :return_good do
      transitions form: :shipped, to: :good_retured
    end

    event :cancel_order do
      transitions form: [:order_placed, :paid], to: :order_cancelled
    end

  end


end
