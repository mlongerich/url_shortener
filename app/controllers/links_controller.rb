# frozen_string_literal: true

class LinksController < ApplicationController
  require 'uri'

  before_action :set_link, only: %i[show destroy]

  # GET /links
  def index
  end

  def links
    @links = Link.all
    json_response(@links)
  end

  # POST /add
  def create
    url = clean_url(link_params[:url])

    @link = Link.find_by(url: url) || Link.create!(url: url, short_url: generate_short_url)
    json_response(@link)
  end

  # GET /:id
  def show
    @link.present? ? redirect_to(@link.url) : json_response(error: 'Short url is invalid')
  end

  # DELETE /urls/:id
  def destroy
    @link.destroy
    head :no_content
  end

  private

  def link_params
    # whitelist params
    params.permit(:url)
  end

  def set_link
    @link = Link.find_by(short_url: params[:id])
  end
  def generate_short_url
    return '000001' if Link.last.nil?

    # prepends 0's, turns id into base36 digit, returns 6 digit string
    ('000000' + (Link.last.id + 1).to_s(36))[-6, 6]
  end

  def clean_url(url)
    url = no_whitespace(url)
    url = URI.escape(url) unless url.nil?
  end

  def no_whitespace(url)
    return if url.nil?
    # replaces all %20 with spaces, removes all leading and trailing spaces
    # with conjunction with URI.escape, this allows for 'http://random_blog.com/this%20is%20my%20blog'
    # while correcting for 'http://random_site.com %20 %20 %20' to 'http://random_site.com'
    url.html_safe.gsub("%20", ' ').strip
  end
end
