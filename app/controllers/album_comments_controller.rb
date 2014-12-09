class AlbumCommentsController < ApplicationController
  before_filter :set_album_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @album_comments = AlbumComment.all
    respond_with(@album_comments)
  end

  def show
    respond_with(@album_comment)
  end

  def new
    @album_comment = AlbumComment.new
    respond_with(@album_comment)
  end

  def edit
  end

  def create
    @album_comment = AlbumComment.new(params[:album_comment])
    @album_comment.save
    respond_with(@album_comment)
  end

  def update
    @album_comment.update_attributes(params[:album_comment])
    respond_with(@album_comment)
  end

  def destroy
    @album_comment.destroy
    respond_with(@album_comment)
  end

  private
    def set_album_comment
      @album_comment = AlbumComment.find(params[:id])
    end
end
