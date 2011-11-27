class ChalengesController < ApplicationController
  # GET /chalenges
  # GET /chalenges.json
  def index
    @chalenges = Chalenge.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chalenges }
    end
  end

  # GET /chalenges/1
  # GET /chalenges/1.json
  def show
    @chalenge = Chalenge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chalenge }
    end
  end

  # GET /chalenges/new
  # GET /chalenges/new.json
  def new
    @chalenge = Chalenge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chalenge }
    end
  end

  # GET /chalenges/1/edit
  def edit
    @chalenge = Chalenge.find(params[:id])
  end

  # POST /chalenges
  # POST /chalenges.json
  def create
    @chalenge = Chalenge.new(params[:chalenge])

    respond_to do |format|
      if @chalenge.save
        format.html { redirect_to @chalenge, notice: 'Chalenge was successfully created.' }
        format.json { render json: @chalenge, status: :created, location: @chalenge }
      else
        format.html { render action: "new" }
        format.json { render json: @chalenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chalenges/1
  # PUT /chalenges/1.json
  def update
    @chalenge = Chalenge.find(params[:id])

    respond_to do |format|
      if @chalenge.update_attributes(params[:chalenge])
        format.html { redirect_to @chalenge, notice: 'Chalenge was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @chalenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chalenges/1
  # DELETE /chalenges/1.json
  def destroy
    @chalenge = Chalenge.find(params[:id])
    @chalenge.destroy

    respond_to do |format|
      format.html { redirect_to chalenges_url }
      format.json { head :ok }
    end
  end
end
