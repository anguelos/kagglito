class CompetitionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index,:show]
  # GET /competitions
  # GET /competitions.json
  def index
    @competitions = Competition.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @competitions }
    end
  end
  def myindex
    @competitions = Competition.find(:all,:conditions =>{:User_id => current_user.id})
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @competitions }
    end
  end
  # GET /competitions/1
  # GET /competitions/1.json
  def show
    @competition = Competition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @competition }
    end
  end

  # GET /competitions/new
  # GET /competitions/new.json
  def new
	@competition = Competition.new
	respond_to do |format|
	  format.html # new.html.erb
	  format.json { render json: @competition }
	end
  end

  # GET /competitions/1/edit
  def edit
    @competition = Competition.find(params[:id])
  end

  # POST /competitions
  # POST /competitions.json
  def participate
	@competition = Competition.find(params[:id])
	print '{',Time.now,'}'
	print '{',String(@competition.endtime),'}'
	if Time.now < @competition.endtime
		ds=Dataset.find(@competition.Dataset_id)
		chalenges=Chalenge.find(:all,:conditions => { :Dataset_id => ds.id})
		part=Participation.new()
		part.name=current_user.email.split('@')[0]+'.'+@competition.name+'.'+String(part.id)
		part.description='Insert a brief description of your method here.'
		part.Competition_id=@competition.id
		part.User_id=current_user.id
		part.save
		chalenges.each do |chalenge|
			sub=Submission.new
			sub.Participation_id=part.id
			sub.Chalenge_id=chalenge.id
			sub.save
		end
		redirect_to edit_participation_path(part),:notice => 'Subscription succesfull.'		
	else
		redirect_to competitions_path,:alert => 'You cant sucscribe, competition has expired'
	end
  end


  def create
	@competition = Competition.new(params[:competition])
	respond_to do |format|
		if user_signed_in? and current_user.isadmin
		  @competition.User_id=current_user.id
		  if @competition.save
		    format.html { redirect_to @competition, notice: 'Competition was successfully created.' }
		    format.json { render json: @competition, status: :created, location: @competition }
		  else
		    format.html { render action: "new" }
		    format.json { render json: @competition.errors, status: :unprocessable_entity }
		  end
		else
			redirect_to competitions_path, status: 'Only admins can create competitions.' 
		end
	end
  end

  # PUT /competitions/1
  # PUT /competitions/1.json
  def update
    @competition = Competition.find(params[:id])
    respond_to do |format|
      if user_signed_in? and current_user.id == @competition.User_id 
        @competition.User_id=current_user.id
		if @competition.update_attributes(params[:competition])
		  format.html { redirect_to @competition, notice: 'Competition was successfully updated.' }
		  format.json { head :ok }
		else
		  format.html { render action: "edit" }
		  format.json { render json: @competition.errors, status: :unprocessable_entity }
		end
	  else
		redirect_to competitions_path, status: 'Only admin owners can modify competitions.' 
	  end
    end
  end
  def evaluateSubmissions
    @competition= Competition.find(params[:id])
    subm=@competition.Submissions
    subm.each do |s|
      Submission.evaluate(s)
    end
    redirect_to @competition,:notice=> 'All submissions have been scored'
  end
  # DELETE /competitions/1
  # DELETE /competitions/1.json
  def destroy
    @competition = Competition.find(params[:id])
    if user_signed_in? and current_user.id == @competition.User_id
		@competition.destroy
		respond_to do |format|
		  format.html { redirect_to competitions_url }
		  format.json { head :ok }
		end
	else
      redirect_to competitions_path, status: 'Only admin owners can destroy competitions.' 
	end
  end
end
