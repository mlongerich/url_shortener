# frozen_string_literal: true

class Link < ApplicationRecord
  require 'uri'

  validates_presence_of :url, :short_url
  validates_uniqueness_of :url, :short_url

  validates :short_url, format: { with: /\w{6}/ } 
  validates :short_url, length: { is: 6 }

  validate :valid_url

  private

  def valid_url
    return if url.nil?

    errors.add(:url, 'is invalid') if URI.parse(url).host.nil?
  end
end
