class AlbumsController < ApplicationController
  before_filter :set_album, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @albums = Album.all
    respond_with(@albums)
  end

  def show
    respond_with(@album)
  end

  def new
    @album = Album.new
    respond_with(@album)
  end

  def edit
  end

  def create
    @album = Album.new(params[:album])
    @album.save
    respond_with(@album)
  end

  def update
    @album.update_attributes(params[:album])
    respond_with(@album)
  end

  def destroy
    @album.destroy
    respond_with(@album)
  end

  private
    def set_album
      @album = Album.find(params[:id])
    end
end
