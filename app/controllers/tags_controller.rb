class TagsController < ApiController
  skip_before_action :verify_authenticity_token

  resource_description do
    formats [:json]
  end

  api :GET, '/tags', 'Return tags'
  description 'Return tags'
  param :name, String, desc: 'Lookup for string in database'
  def get
    param! :name, String

    unless params[:name].nil?
      tags = Tag.search_by_name(params[:name])
    else
      tags = Tag.all
    end

    answer TagsRepresenter.new(tags)
  end

  api :POST, '/tags', 'Create tag'
  description 'Create tag'
  param :name, String, desc: 'Name for new tag', required: true
  def post
    param! :name, String, required: true

    tag = Tag.new
    tag.name = params[:name]
    tag.save
  end
end
