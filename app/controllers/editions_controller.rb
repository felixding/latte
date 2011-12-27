class EditionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  before_filter :find_or_404, :only => [:show]

  # GET /editions
  # GET /editions.json
  def index
    @editions = Edition.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @editions }
    end
  end

  # GET /editions/1
  # GET /editions/1.json
  def show
    

    redirect_to url_for([@project, @edition, @page])
    #render "projects/trunk"
  end

  # GET /editions/new
  # GET /editions/new.json
  def new
    @project = Project.find_by_slug(params[:project_id])
    @edition = @project.editions.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @edition }
    end
  end

  # GET /editions/1/edit
  def edit
    @edition = Edition.find(params[:id])
  end

  # POST /editions
  # POST /editions.json
  def create
    @project = Project.find_by_slug(params[:project_id])
    @edition = @project.editions.build(params[:edition])

    respond_to do |format|
      if @edition.save
        format.html { redirect_to [@project, @edition], notice: 'Edition was successfully created.' }
        format.json { render json: @edition, status: :created, location: @edition }
      else
        format.html { render action: "new" }
        format.json { render json: @edition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /editions/1
  # PUT /editions/1.json
  def update
    @edition = Edition.find(params[:id])

    respond_to do |format|
      if @edition.update_attributes(params[:edition])
        format.html { redirect_to @edition, notice: 'Edition was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @edition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /editions/1
  # DELETE /editions/1.json
  def destroy
    @edition = Edition.find(params[:id])
    @edition.destroy

    respond_to do |format|
      format.html { redirect_to editions_url }
      format.json { head :ok }
    end
  end
  
  private
  
  def find_or_404
    @project = Project.find_by_slug(params[:project_id])
    @edition = @project.editions.find(params[:id])
    @page = Page.find @edition.pages.first.first
  end
  
end