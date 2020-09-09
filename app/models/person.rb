class Person < ApplicationRecord
  has_many :cards, dependent: :destroy

  def self.aggregatable_card(email, name, title)
    Card.all.select { |card| card.aggregatable?(email, name, title) }.first
  end
end
