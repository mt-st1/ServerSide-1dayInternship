class Person < ApplicationRecord
  has_many :cards, dependent: :destroy

  # 名寄せ可能なPersonを返す
  def self.aggregatable_person(**params)
    return unless (aggregatable_card = Card.all.find { |card| card.aggregatable?(params) })

    Person.find(aggregatable_card.person_id)
  end
end
