class TagsController < ApiController
  def get
    param! :name, String

    tags = Tag.all

    unless params[:name].nil?
      tags = tags.search(params[:name]).records
    end

    answer TagRepresenter.new(tags)
  end

  def post
    param! :name, String, required: true

    tag = Tag.new
    tag.name = params[:name]
    tag.save
  end
end
