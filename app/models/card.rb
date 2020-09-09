class Card < ApplicationRecord
  belongs_to :person
  include CalculationTitleScore
  require 'levenshtein'

  BLANK_REGEXP = /[\s　]/.freeze
  TITLE_RELEVANCE_THRESHOLD = 80
  SIMILARITY_DISTANCE_THRESHOLD = 2

  # 名寄せ可能かどうか
  def aggregatable?(email, name, title)
    # メールアドレスが類似している かつ (表記ゆれを考慮した名前が一致 または 職業関連度が高い)
    similar_email?(email) && (same_person_name?(name) || relevant_title?(title))
  end

  private

  def similar_email?(email)
    Levenshtein.distance(self.email, email) <= SIMILARITY_DISTANCE_THRESHOLD
  end

  def relevant_title?(title)
    calculation(self.title, title) >= TITLE_RELEVANCE_THRESHOLD
  end

  def same_person_name?(name)
    name_matched?(name) || last_name_matched?(name)
  end

  def name_matched?(name)
    trim_all_space_char(self.name) == trim_all_space_char(name)
  end

  def last_name_matched?(name)
    splitted_target_names = self.name.split(BLANK_REGEXP)
    splitted_names = name.split(BLANK_REGEXP)

    return false unless splitted_target_names.size == 2 && splitted_names.size == 2

    splitted_target_names.last == splitted_names.last
  end

  def trim_all_space_char(str)
    str.gsub(/[\s　]*/, '')
  end
end
