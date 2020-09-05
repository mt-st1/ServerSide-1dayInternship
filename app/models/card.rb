class Card < ApplicationRecord
  belongs_to :person
  include CalculationTitleScore

  def name_matched?(name)
    trim_all_space_char(self.name) == trim_all_space_char(name)
  end

  def similar_title?(title)
    calculation(self.title, title) >= 80
  end

  private

  def trim_all_space_char(str)
    str.gsub(/[\s　]*/, '')
  end
end
