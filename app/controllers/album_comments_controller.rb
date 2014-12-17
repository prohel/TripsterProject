class AlbumCommentsController < ApplicationController
  before_filter :set_album_comment, only: [:show, :edit, :update, :destroy]
  before_filter :check_privacy, only: [:edit, :update, :destroy]
  respond_to :html

  def index
    @trip = Trip.find(params[:trip_id])
    @album = Album.find(params[:album_id])
    @album_comments = AlbumComment.all
    respond_with(@trip, @album, @album_comments)
  end

  def show
    @trip = Trip.find(params[:trip_id])
    @album = Album.find(params[:album_id])
    respond_with(@trip, @album, @album_comment)
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @album = Album.find(params[:album_id])
    @album_comment = @trip.album.album_comments.new
    @album_comment.user = current_user
    respond_with(@trip, @album, @album_comment)
  end

  def edit
    @trip = Trip.find(params[:trip_id])
    @album = Album.find(params[:album_id])
    respond_with(@trip, @album, @album_comment)
  end

  def create
    @album_comment = AlbumComment.new(params[:album_comment])
    @album_comment.save
    @trip = Trip.find(params[:trip_id])
    @album = Album.find(params[:album_id])
    respond_with(@trip, @album)
  end

  def update
    @album_comment.update_attributes(params[:album_comment])
    @album = Album.find(params[:album_id])
    respond_with(@trip, @album)
  end

  def destroy
    @trip = Trip.find(params[:trip_id])
    @album = Album.find(params[:album_id])
    @album_comment.destroy
    respond_with(@trip, @album)
  end

  private
    def set_album_comment
      @album_comment = AlbumComment.find(params[:id])
    end

    def check_privacy
      @album_comment = AlbumComment.find(params[:id])
      @album_comments.user_id = current_user.id
    end
end
