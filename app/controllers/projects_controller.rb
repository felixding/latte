class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :trunk]
  before_filter :find_by_slug_or_404, :only => [:show, :trunk, :edit, :update, :destroy]
  before_filter :hbaw, :only => [:show]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @edition = @project.editions.last unless @project.editions.empty?
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  def trunk
    @page = @project.pages.first
    redirect_to url_for([@project, @page])
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.build(params[:project])
    @project.slug = params[:project][:slug]
    
#    raise @project.inspect + @project.valid?.to_s

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project.updater_id = current_user.id

    if @project.update_attributes(params[:project])
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :ok }
    end
  end

end