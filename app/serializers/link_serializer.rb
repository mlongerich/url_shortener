# frozen_string_literal: true

class LinkSerializer < ActiveModel::Serializer
  attributes :short_url, :url

  def short_url
    "#{domain}/#{object.short_url}"
  end

  private 
    def domain
      Rails.env.production? ? Rails.application.routes.url_helpers.root_url : "localhost:3000"
    end
end
