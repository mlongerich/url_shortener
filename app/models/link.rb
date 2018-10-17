# frozen_string_literal: true

class Link < ApplicationRecord
  require 'uri'

  validates_presence_of :url, :short_url
  validates_uniqueness_of :url

  validates :short_url, uniqueness: { case_sensitive: false }
  validates :short_url, format: { with: /\w{6}/ }
  validates :short_url, length: { is: 6 }

  validate :valid_url

  # prepends 0's, turns id into base36 digit, returns 6 digit string
  def self.generate_short_url
    return '000001' if Link.last.nil?

    ('00000' + (Link.last.id + 1).to_s(36))[-6, 6]
  end

  def self.clean_url(url)
    URI.escape(no_whitespace(url)) unless url.nil? 
  end

  private

  def valid_url
    return if url.nil?
    errors.add(:url, "is invalid. Did you include 'http://'?") if URI.parse(url).host.nil? && url.present?
  end

  # replaces all %20 with spaces, removes all leading and trailing spaces
  # this allows for 'http://random_blog.com/this%20is%20my%20blog'
  # while correcting for 'http://random_site.com %20 %20 %20' to 'http://random_site.com'
  def self.no_whitespace(url)
    url.html_safe.gsub("%20", ' ').strip
  end
end
