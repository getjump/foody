class TagsController < ApiController
  skip_before_action :verify_authenticity_token

  def get
    param! :name, String

    tags = Tag.all

    unless params[:name].nil?
      tags = Tag.search(query: { match: { name: params[:name] } }).records
    end

    answer TagsRepresenter.new(tags)
  end

  def post
    param! :name, String, required: true

    tag = Tag.new
    tag.name = params[:name]
    tag.save
  end
end
