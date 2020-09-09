class Card < ApplicationRecord
  require 'levenshtein'
  require 'kakasi'
  require 'itaiji'
  include CalculationTitleScore

  belongs_to :person

  SPACE_CHAR_REGEXP = /[\s　]/.freeze
  TITLE_RELEVANCE_THRESHOLD = 80
  SIMILARITY_DISTANCE_THRESHOLD = 2
  using Itaiji::Conversions

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
    name_matched?(name) || first_name_matched?(name)
  end

  def name_matched?(name)
    trim_all_space_chars(self.name).downcase == trim_all_space_chars(name).downcase
  end

  def first_name_matched?(name)
    splitted_names = self.name.split(SPACE_CHAR_REGEXP)
    splitted_target_names = name.split(SPACE_CHAR_REGEXP)

    return false if splitted_names.empty? || splitted_target_names.empty?

    # 英語の場合
    if /\A[a-zA-Z]+\z/.match?(splitted_names.first) && /\A[a-zA-Z]+\z/.match?(splitted_target_names.first)
      return splitted_names.first.downcase == splitted_target_names.first.downcase
    end

    convert_japanese_to_hiragana(splitted_names.last) == convert_japanese_to_hiragana(splitted_target_names.last)
  end

  def trim_all_space_chars(str)
    str.gsub(/[\s　]*/, '')
  end

  def convert_japanese_to_hiragana(str)
    Kakasi.kakasi('-JH -KH', str.to_seijitai)
  end
end
