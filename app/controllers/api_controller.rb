require 'multi_json'

class ApiController < ApplicationController
  rescue_from RailsParam::Param::InvalidParameterError, :with => :error_render_method

  def answer(object = nil, error = nil)
    obj = ApiAnswer.new

    if object != nil
      obj.object = object
    end

    if error != nil
      obj.error = error
    end

    logger.debug obj.extend(ApiAnswerRepresenter).to_json

    # logger.warn "*** BEGIN RAW REQUEST HEADERS ***"
    # self.request.env.each do |header|
    #   logger.warn "HEADER KEY: #{header[0]}"
    #   logger.warn "HEADER VAL: #{header[1]}"
    # end
    # logger.warn "*** END RAW REQUEST HEADERS ***"

    render json: obj.extend(ApiAnswerRepresenter).to_json
  end

  def error_render_method(exception)
    answer nil, {code: 1, message: exception.message}
  end
end
