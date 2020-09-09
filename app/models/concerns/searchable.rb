module Searchable
  extend ActiveSupport::Concern

  class_methods do
    def define_like_search(*columns)
      columns.each do |column|
        scope :"#{column}_like", ->(query) { where("#{column} LIKE ?", "%#{query}%") }
      end
    end
  end
end
