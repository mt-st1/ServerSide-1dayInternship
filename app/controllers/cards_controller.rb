class CardsController < ApplicationController
  def show
    @card = Card.find(params[:id])
    send_data s3_object.get.body.read
  end

  def create
    ActiveRecord::Base.transaction do
      if (aggregatable_card = Person.aggregatable_card(card_params[:email], card_params[:name], card_params[:title]))
        person = Person.find(aggregatable_card.person_id)
      else
        person = Person.create
      end
      card = person.cards.create!(card_params)
      SampleCardImageUploader.upload(card)
    end

    head :created
  end

  private

  def card_params
    params.permit(:name, :email, :organization, :department, :title)
  end

  def s3_object
    s3_bucket.object(@card.id.to_s)
  end

  def s3_bucket
    s3_resource.bucket('cards').exists? ? s3_resource.bucket('cards') : s3_resource.create_bucket(bucket: 'cards')
  end

  def s3_resource
    @s3_resource ||= Aws::S3::Resource.new(
      endpoint: 'http://serverside-1dayinternship_minio_1:9000',
      region: 'us-east-1',
      access_key_id: 'ak_eight',
      secret_access_key: 'sk_eight',
      force_path_style: true
    )
  end
end
