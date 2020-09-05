class PeopleController < ApplicationController
  def index
    if params[:query]
      @people = Person.joins(:cards).where('cards.name LIKE ? OR cards.organization LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%").uniq
      return
    end
    @people = Person.includes(:cards)
  end
end
