class AttachmentCommentsController < ApplicationController
  before_filter :set_attachment_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @attachment_comments = AttachmentComment.all
    respond_with(@attachment_comments)
  end

  def show
    respond_with(@attachment_comment)
  end

  def new
    @attachment_comment = AttachmentComment.new
    respond_with(@attachment_comment)
  end

  def edit
  end

  def create
    @attachment_comment = AttachmentComment.new(params[:attachment_comment])
    @attachment_comment.save
    respond_with(@attachment_comment)
  end

  def update
    @attachment_comment.update_attributes(params[:attachment_comment])
    respond_with(@attachment_comment)
  end

  def destroy
    @attachment_comment.destroy
    respond_with(@attachment_comment)
  end

  private
    def set_attachment_comment
      @attachment_comment = AttachmentComment.find(params[:id])
    end
end
