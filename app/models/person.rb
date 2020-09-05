class Person < ApplicationRecord
  has_many :cards, dependent: :destroy

  def self.aggregatable_card(email, name, title)
    cards = Card.all
    target_cards = cards.select { |card| card.name_matched?(name) || card.lastname_matched?(name) }
    return nil if target_cards.empty?

    target_cards.each do |card|
      return card if card.similar_email?(email) || card.similar_title?(title)
    end
  end
end
