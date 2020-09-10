class PeopleController < ApplicationController
  def index
    query = params[:query]
    if query.present?
      searched_cards = Card.name_like(query).or(Card.organization_like(query))
      target_person_ids = searched_cards.pluck(:person_id).uniq
      @people = Person.where(id: target_person_ids).preload(:cards)
      return
    end
    @people = Person.preload(:cards)
  end
end
