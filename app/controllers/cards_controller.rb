class CardsController < ApplicationController
  def show
    # TODO: implement me
  end

  def create
    ActiveRecord::Base.transaction do
      card = Person.create.cards.create!(card_params) # TODO:
      SampleCardImageUploader.upload(card)
    end

    head :created
  end

  private

  def card_params
    params.permit(:name, :email, :organization, :department, :title)
  end
end
