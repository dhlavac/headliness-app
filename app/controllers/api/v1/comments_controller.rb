class Api::V1::CommentsController < ApplicationController
  before_action :find_headline
  before_action :find_headline_comments, only: [:show, :update, :destroy]

  # GET /headline/:headline_id/comments
  def index
    json_response(@headline.comments)
  end

  # POST /headline/:headline_id/comments
  def create
    if @headline = @headline.comments.create!(comment_params)
      process_success(@headline)
    else
      process_error
    end
  end

  # GET /headline/:headline_id/comments/:id
  def show
    json_response(@comment)
  end

  # PUT /headline/:headline_id/comments:id
  def update
    if @comment.update(comment_params)
      process_success(@comment)
    else
      process_error
    end
  end

  # DELETE /headline/:headline_id/comments:id
  def destroy
    if @comment.destroy
      process_success(@comment)
    else
      process_error
    end
  end


  private

  def comment_params
    params.permit(:author, :text, :up_vote, :down_vote)
  end

  def find_headline
    @headline = Headline.find(params[:headline_id])
  end

  def find_headline_comments
    @comment = @headline.comments.find_by!(id: params[:id]) if @headline
  end
end
