class ParticipationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  # GET /participations
  # GET /participations.json
  def index
    @participations = Participation.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participations }
    end
  end

  # GET /participations/1
  # GET /participations/1.json
  def show
    @participation = Participation.find(params[:id])
	comp=Competition.find(@participation.Competition_id)
	if (@participation.submissionspublic and comp.endtime<Time.now) or current_user.id==@participation.User_id or current_user.id==comp.User_id
		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @participation }
		end
	else
		if !@participation.submissionspublic
			redirect_to participations_path, status: 'The participant chose not to publish his submissions.' 
		elsif comp.endtime<Time.now
			redirect_to participations_path, status: 'You cant view submissions while the competion is stil active.'
		else
			redirect_to participations_path, status: 'You are not authorised to view these submissions.'
		end
	end
  end

  # GET /participations/new
  # GET /participations/new.json
  def new
    @participation = Participation.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participation }
    end
  end

  # GET /participations/1/edit
  def edit
    @participation = Participation.find(params[:id])
  end

  # POST /participations
  # POST /participations.json
  def create
    @participation = Participation.new(params[:participation])
    respond_to do |format|
	  if user_signed_in?
		  @participation.User_id=current_user.id
		  if @participation.save
			comp=Competition.find(@participation.Competition_id)
			ds=Dataset.find(comp.Dataset_id)
			chalenges=Chalenge.find(:all,:conditions => { :Dataset_id => ds.id})
			chalenges.each do |chal|
				sub=Submission.new
				sub.Participation_id=@participation.id
				sub.Chalenge_id=chal.id
				sub.save
			end
		    format.html { redirect_to @participation, notice: 'Participation was successfully created.' }
		    format.json { render json: @participation, status: :created, location: @participation }
		  else
		    format.html { render action: "new" }
		    format.json { render json: @participation.errors, status: :unprocessable_entity }
		  end
	  else
		redirect_to signin_path, status: 'You must sign in to declare a participation.' 
	  end
    end
  end

  # PUT /participations/1
  # PUT /participations/1.json
  def update
    @participation = Participation.find(params[:id])
	if user_signed_in? and current_user.id==@participation.User_id
		comp_id=@participation.Competiton_id
		respond_to do |format|
		  if comp_id==@participation.Competiton_id
			  if @participation.update_attributes(params[:participation])
				format.html { redirect_to @participation, notice: 'Participation was successfully updated.' }
				format.json { head :ok }
			  else
				format.html { render action: "edit" }
				format.json { render json: @participation.errors, status: :unprocessable_entity }
			  end
		  else
			redirect_to participations_path, status: 'You cant change the competition of a participation destroy it and create a new one.'
		  end
		end
	else
      redirect_to participations_path, status: 'You cant modify a participation you havent created.'
	end
  end

  # DELETE /participations/1
  # DELETE /participations/1.json
  def destroy
    @participation = Participation.find(params[:id])
	if user_signed_in? and current_user.id==@participation.User_id
		if Time.now< Competition.find(@participation.Competition_id).endtime
			@participation.destroy
			respond_to do |format|
			  format.html { redirect_to participations_url }
			  format.json { head :ok }
			end
		else
		  redirect_to participations_path, status: 'Participation can only be deleted before a competition expires.' 
		end
	else
		redirect_to participations_path, status: 'Participation can only be deleted by participant.' 
	end
  end
end
