class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :show_edition_page]
  before_filter :find_or_404, :only => [:show, :show_edition_page, :trunk, :edit, :update, :destroy]
  before_filter :hbaw, :only => [:show, :show_edition_page]

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
#    raise @project.pages.first.inspect
    @pages = @project.pages.arrange(:order => :created_at)
    render "projects/trunk"
  end
  
  def show_edition_page
    unless @edition = @project.editions.find(params[:edition_id])
      render_error "404"
      return
    end

    @page_version = @edition.pages.select{|page| page.first == @page.id}.first.last
    @page.revert_to @page_version
    
    @project = @edition.versioned_project
    @pages = @project.pages.arrange_nodes(@edition.versioned_pages)
    
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
