class TagsController < ApiController
  def post
    param! :name, String, required: true

    tag = Tag.new
    tag.name = params[:name]
    tag.save
  end
end
