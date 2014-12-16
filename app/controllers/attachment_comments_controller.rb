class AttachmentCommentsController < ApplicationController
  before_filter :set_attachment_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @trip = Trip.find(params[:trip_id])
    @attachment = Attachment.find(params[:attachment_id])
    @attachment_comments = AttachmentComment.all
    respond_with(@trip, @attachment, @attachment_comments)
  end

  def show
    @trip = Trip.find(params[:trip_id])
    @attachment = Attachment.find(params[:attachment_id])
    respond_with(@trip, @attachment, @attachment_comments)
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @attachment = Attachment.find(params[:attachment_id])
    @attachment_comment = @trip.attachment.attachment_comments.new
    @attachment_comment.user = current_user
    respond_with(@trip, @attachment, @attachment_comment)
  end

  def edit
    @trip = Trip.find(params[:trip_id])
    @attachment = Attachment.find(params[:attachment_id])
    respond_with(@trip, @attachment, @attachment_comment)
  end

  def create
    @attachment_comment = AttachmentComment.new(params[:attachment_comment])
    @attachment_comment.save
    @trip = Trip.find(params[:trip_id])
    @attachment = Attachment.find(params[:attachment_id])
    respond_with(@trip, @attachment)
  end

  def update
    @attachment_comment.update_attributes(params[:attachment_comment])
    @attachment = Attachment.find(params[:attachment_id])
    respond_with(@trip, @attachment)
  end

  def destroy
    @trip = Trip.find(params[:trip_id])    
    @attachment = Attachment.find(params[:attachment_id])
    @attachment_comment.destroy
    respond_with(@trip, @attachment)
  end

  private
    def set_attachment_comment
      @attachment_comment = AttachmentComment.find(params[:id])
    end
end
