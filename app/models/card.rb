class Card < ApplicationRecord
  belongs_to :person
  include CalculationTitleScore
  require 'levenshtein'

  def name_matched?(name)
    trim_all_space_char(self.name) == trim_all_space_char(name)
  end

  def lastname_matched?(name)
    splitted_target_names = self.name.split(/[\s　]/)
    splitted_names = name.split(/[\s　]/)

    return false unless splitted_target_names.size == 2 && splitted_names.size == 2

    splitted_target_names.last == splitted_names.last
  end

  def similar_email?(email)
    Levenshtein.distance(self.email, email) <= 2
  end

  def similar_title?(title)
    calculation(self.title, title) >= 80
  end

  private

  def trim_all_space_char(str)
    str.gsub(/[\s　]*/, '')
  end
end
