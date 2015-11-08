class TagsController < ApiController
  skip_before_action :verify_authenticity_token

  def get
    param! :name, String

    unless params[:name].nil?
      tags = Tag.search_by_name(params[:name])
    else
      tags = Tag.all
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
