class AlbumsController < ApplicationController
  before_filter :set_album, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @trip = Trip.find(params[:trip_id])
    @albums = Album.all
    respond_with(@trip, @albums)
  end

  def show
    @trip = Trip.find(params[:trip_id])
    @attachments = Attachment.where("album_id = ?", @album.id)
    @album_comments = AlbumComment.where("album_id = ?", @album.id)
    @album_comment = @album.album_comments.new
    respond_with(@trip, @album)
  end

  def new
    #@album = Album.new
    @trip = Trip.find(params[:trip_id])
    @album = @trip.albums.new
    @album.created_by = current_user.id
    respond_with(@trip, @album)
  end

  def edit
    @trip = Trip.find(params[:trip_id])
    respond_with(@trip, @album)
  end

  def create
    @album = Album.new(params[:album])
    @album.save
    @trip = Trip.find(params[:trip_id])
    respond_with(@trip, @album)
  end

  def update
    @album.update_attributes(params[:album])
    @trip = Trip.find(params[:trip_id])
    respond_with(@trip, @album)
  end

  def destroy
    @trip = Trip.find(params[:trip_id])
    @album.destroy
    respond_with(@trip)
  end

  private
    def set_album
      @album = Album.find(params[:id])
    end
end
