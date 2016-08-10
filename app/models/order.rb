class Order < ApplicationRecord
  require "active_merchant/billing/rails"

  has_many :line_items, dependent: :destroy
  has_many :transactions
  belongs_to :user, optional: true

  CREDIT_CARD_TYPES = [["Visa", "visa"], ["Mastercard", "master"],
    ["Discover", "discover"], ["American Express", "american_express"]]

  validates_presence_of :name, :address, :email, :card_type,
    :card_number, :card_verification, :card_expires_on

  validates :card_type, inclusion: CREDIT_CARD_TYPES.map { |k, v| v }
  validate :validate_card

  attr_accessor :card_number, :card_verification

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def purchase(cart)
    response = GATEWAY.purchase(price_in_cents(cart.total_price), credit_card, ip: ip_address)
    transactions.create!(action: "purchase",
      amount: price_in_cents(cart.total_price), response: response)
    response.success?
  end

  private

  def price_in_cents(total)
    (total * 100).round
  end

  def validate_card
    unless credit_card.valid?
      errors.add(:base, "The credit card information you provided is not valid.
        Please double check the information you provided and then try again.")
    end
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      brand:              card_type,
      number:             card_number,
      verification_value: card_verification,
      month:              card_expires_on.month,
      year:               card_expires_on.year,
      name:               name
    )
  end
end
