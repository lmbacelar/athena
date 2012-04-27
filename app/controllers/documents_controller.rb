class DocumentsController < ApplicationController
  respond_to :html, :json

  def index
    @documents = Document.all
    respond_with @documents
  end

  def show
    @document = Document.find(params[:id])
    respond_with @document
  end

  def new
    @document = Document.new
  end

  def edit
    @document = Document.find(params[:id])
  end

  def create
    @document = Document.new(params[:document])
    if @document.save
      redirect_to @document, notice: "#{Document.model_name.human} #{ t('flash.notice.create')}"
    else
      render action: 'new'
    end
  end

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(params[:document])
      redirect_to @document, notice: "#{Document.model_name.human} #{ t('flash.notice.update')}"
    else
      render action: 'edit'
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_url, notice: "#{Document.model_name.human} #{ t('flash.notice.destroy')}"
  end
end
