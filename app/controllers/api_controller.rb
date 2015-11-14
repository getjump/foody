require 'multi_json'

class ApiController < ApplicationController
  rescue_from Apipie::ParamInvalid, :with => :error_render_method
  rescue_from ActiveRecord::InvalidForeignKey, :with => :error_render_method_without_output

  def answer(object = nil, error = nil)
    obj = ApiAnswer.new

    if object != nil
      obj.object = object
    end

    if error != nil
      obj.error = error
    end

    render json: obj.extend(ApiAnswerRepresenter).to_json
  end

  def error_render_method_without_output
    answer nil, {code: 1, message: "something went wrong"}
  end

  def error_render_method(exception)
    answer nil, {code: 1, message: exception.message}
  end
end
