# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ error: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ error: e.message }, :unprocessable_entity)
    end

    rescue_from URI::InvalidURIError do |e|
      json_response({ error: "URL is invalid, please check and try again."}, :unprocessable_entity)
    end
  end
end
