# frozen_string_literal: true

class LinksController < ApplicationController
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
    @url = Link.clean_url(link_params[:url])

    @link = Link.find_by(url: @url) || Link.create!(url: @url, short_url: Link.generate_short_url)
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
end
