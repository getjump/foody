module Api
  module V1
    class TagsController < ApiController

      api! 'Return tags'
      description 'Return tags'
      meta :object =>
      [
        {
          :name => "string"
        }
      ]
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

      api! 'Create tag'
      description 'Create tag'
      meta :object =>
      {
        :sucess => "bool"
      }
      param :name, String, desc: 'Name for new tag', required: true

      def post
        param! :name, String, required: true

        tag = Tag.new
        tag.name = params[:name]
        tag.save

        obj = {:success => true}

        answer obj
      end
    end
  end
end
