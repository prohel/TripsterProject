class AttachmentsController < ApplicationController
  before_filter :set_attachment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @attachments = Attachment.all
    respond_with(@attachments)
  end

  def show
    respond_with(@attachment)
  end

  def new
    @attachment = Attachment.new
    respond_with(@attachment)
  end

  def edit
  end

  def create
    @attachment = Attachment.new(params[:attachment])
    @attachment.save
    respond_with(@attachment)
  end

  def update
    @attachment.update_attributes(params[:attachment])
    respond_with(@attachment)
  end

  def destroy
    @attachment.destroy
    respond_with(@attachment)
  end

  private
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end
end
