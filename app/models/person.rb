class Person < ApplicationRecord
  has_many :cards, dependent: :destroy

  def self.aggregatable_card(email, name, title)
    return nil unless Card.find_by(email: email)

    cards = Card.where(email: email)
    cards.each do |card|
      return card if card.name_matched?(name) || card.similar_title?(title)
    end
  end
end
