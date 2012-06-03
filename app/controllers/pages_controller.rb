class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :show_edition_page]
  before_filter :find_or_404, :only => [:show, :trunk, :edit, :update, :destroy]
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
    @pages = @project.pages.arrange(:order => :index_id)
  end
  
  def show_edition_page
    begin
      @project = Project.find_by_slug(params[:project_id])
      @edition = @project.editions.find(params[:edition_id])
      
      page_id = params[:id].to_i
      page_version = @edition.pages.select{|page| page.first == page_id}.first.last

      @page = Page.find_by_id_and_version_or_restore_from_history(page_id, page_version)
    rescue
      render_error "404"
      return
    end
    #raise @edition.versioned_pages.collect{|p|p.class.to_s}.inspect
    @project = @edition.versioned_project
    @pages = @project.pages.arrange_nodes(@project.pages.sort_by_ancestry(@edition.versioned_pages))
    
    render "show"
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

    redirect_to trunk_project_url(@project), notice: "The page \"#{@page.title}\" was successfully destroyed."
  end
  
  private
  
  def find_or_404
    @project = Project.find_by_slug(params[:project_id])
    @page = Page.find(params[:id])
  end
end
