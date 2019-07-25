class Api::V1::HeadlinesController < ApplicationController

  before_action :find_headline, only: [:show, :update, :destroy]

  # GET /headlines
  def index
    @headlines = Headline.all
    json_response(@headlines)
  end

  # POST /headlines
  def create
    if @headline = Headline.create!(headline_params)
      process_success(@headline)
    else
      process_error
    end
  end

  # GET /headlines/:id
  def show
    json_response(@headline)
  end

  # PUT /headlines/:id
  def update
    if @headline.update(headline_params)
      process_success(@headline)
    else
      process_error
    end
  end

  # DELETE /headlines/:id
  def destroy
    if @headline.destroy
      process_success(@headline)
    else
      process_error
    end
  end

  private

  def headline_params
    params.permit(:text, :created_at, :updated_at, :origin, :publisher)
  end

  def find_headline
    @headline = Headline.find(params[:id])
  end

end
