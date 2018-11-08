require 'multi_json'

module Api
  module V1
    class ApiController < ::ApplicationController
      skip_before_action :verify_authenticity_token

      resource_description do
        api_version "v1"
        formats [:json]
      end

      rescue_from Apipie::ParamInvalid, :with => :error_render_method
      rescue_from ActiveRecord::InvalidForeignKey, :with => :error_render_method_without_output

      def answer(object = nil, error = nil)
        obj = ApiAnswer.new
        status = 200

        if object != nil
          obj.object = object
        end

        if error != nil
          obj.error = error
          status = 500
        end

        render json: obj.extend(ApiAnswerRepresenter), :status => status
      end

      def error_render_method_without_output
        answer nil, {code: 1, message: "something went wrong"}
      end

      def error_render_method(exception)
        answer nil, {code: 1, message: exception.message}
      end
    end
  end
end
