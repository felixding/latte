class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  before_filter :find_or_404, :only => [:show, :trunk, :edit, :update, :destroy]  

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    render "projects/trunk"
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page.project_id = @project.id
    @page.updater_id = current_user.id

    if @page.update_attributes(params[:page])
      redirect_to [@project, @page], notice: 'Page was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @project = Project.find_by_slug(params[:project_id])
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to (:back || @project) }
      format.json { head :ok }
    end
  end
  
  private
  
  def find_or_404
    @project = Project.find_by_slug(params[:project_id])
    @page = Page.find(params[:id])
  end
end
