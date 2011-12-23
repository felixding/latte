class EdtionsController < ApplicationController
  # GET /edtions
  # GET /edtions.json
  def index
    @edtions = Edtion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @edtions }
    end
  end

  # GET /edtions/1
  # GET /edtions/1.json
  def show
    @edtion = Edtion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @edtion }
    end
  end

  # GET /edtions/new
  # GET /edtions/new.json
  def new
    @edtion = Edtion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @edtion }
    end
  end

  # GET /edtions/1/edit
  def edit
    @edtion = Edtion.find(params[:id])
  end

  # POST /edtions
  # POST /edtions.json
  def create
    @edtion = Edtion.new(params[:edtion])

    respond_to do |format|
      if @edtion.save
        format.html { redirect_to @edtion, notice: 'Edtion was successfully created.' }
        format.json { render json: @edtion, status: :created, location: @edtion }
      else
        format.html { render action: "new" }
        format.json { render json: @edtion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /edtions/1
  # PUT /edtions/1.json
  def update
    @edtion = Edtion.find(params[:id])

    respond_to do |format|
      if @edtion.update_attributes(params[:edtion])
        format.html { redirect_to @edtion, notice: 'Edtion was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @edtion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /edtions/1
  # DELETE /edtions/1.json
  def destroy
    @edtion = Edtion.find(params[:id])
    @edtion.destroy

    respond_to do |format|
      format.html { redirect_to edtions_url }
      format.json { head :ok }
    end
  end
end
