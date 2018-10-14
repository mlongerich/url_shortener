# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :set_link, only: %i[show destroy]

  # GET /links
  def index
    @links = Link.all
    json_response(@links)
  end

  # POST /links
  def create
    @link = Link.find_by(url: link_params[:url]) || Link.create!(url: link_params[:url], short_url: generate_short_url)
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
end
