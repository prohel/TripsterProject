class AttachmentsController < ApplicationController
  before_filter :set_attachment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @trip = Trip.find(params[:trip_id])
    @attachments = Attachment.all
    respond_with(@trip, @attachments)
  end

  def show
    respond_with(@trip, @attachment)
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @attachment = @trip.attachments.new
    @attachment.created_by = current_user.id
    if(params.has_key?(:album_id))
      @attachment.album_id = params[:album_id]
    end
    #@attachment = Attachment.new
    respond_with(@trip, @attachment)
  end

  def edit
    @trip = Trip.find(params[:trip_id])
  end

  def create
    @attachment = Attachment.new(params[:attachment])
    @attachment.created_by = current_user.id
    if(params.has_key?(:album_id))
      @attachment.album_id = params[:album_id]
    end
    @attachment.save
    @trip = Trip.find(params[:trip_id])
    respond_with(@trip, @attachment)
  end

  def update
    @attachment.update_attributes(params[:attachment])
    @trip = Trip.find(params[:trip_id])
    respond_with(@trip, @attachment)
  end

  def destroy
    @trip = Trip.find(params[:trip_id])
    @attachment.destroy
    respond_with(@trip)
  end

  private
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end
end
