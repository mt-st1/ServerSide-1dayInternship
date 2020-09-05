class PeopleController < ApplicationController
  def index
    @people = Person.all.includes(:cards)
  end
end
