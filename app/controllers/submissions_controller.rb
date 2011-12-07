class SubmissionsController < ApplicationController
  # GET /submissions
  # GET /submissions.json
  before_filter :authenticate_user!

  def showresponse
    @submission = Submission.find(params[:id])
	part=Participation.find(@submission.Participation_id)
	comp=Competion.find(part.Competion_id)
	if not(((comp.endtime<Time.now) and (part.submissionspublic))or current_user.id==part.User_id or current_user.id==comp.User_id)
		data=File.read(Rails.root.join('public','na.png'))
		send_data data, :type => 'image/png',:disposition => 'inline'
	else
		respmime=''
		respFext=@submission.responcefileext.downcase
		if(respFext=='png')
		pespmime='image/png'
		elsif respFext=='jpg'
		    pespmime='image/jpg'
		elsif respFext=='bmp'
		    pespmime='image/bmp'
		elsif respFext=='zip'
		    pespmime='file/zip'
		elsif respFext=='csv'
		    pespmime='file/csv'
		end
		send_data @submission.response, :type => respmime,:disposition => 'inline'
	end
  end

  def showchalengeinput
    @submission = Submission.find(params[:id])
	chal=Chalenge.find(@submission.Chalenge_id)
	part=Participation.find(@submission.Participation_id)
	comp=Competion.find(part.Competion_id)
	if (current_user.id==comp.user_id)or((comp.starttime<Time.now) and (current_user.id==part.User_id))or(part.submissionspublic and comp.endtime<Time.now)
		if current_user.id==part.User_id and @submission.announced==nil
			@submission.announced=Time.now
		end
		inputmime=''
		inputFext=chal.inputfileext.downcase
		if(inputFext=='png')
		inputmime='image/png'
		elsif inputFext=='jpg'
		    inputmime='image/jpg'
		elsif inputFext=='bmp'
		    inputmime='image/bmp'
		elsif inputFext=='zip'
		    inputmime='file/zip'
		elsif inputFext=='csv'
		    inputmime='file/csv'
		end
		send_data chal.input, :type => inputmime,:disposition => 'inline'
	else
		data=File.read(Rails.root.join('public','na.png'))
		send_data data, :type => 'image/png',:disposition => 'inline'
	end
  end


  def index
    @submissions = Submission.find(:all,:conditions => { :User_id => current_user.id})
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @submissions }
    end
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @submission = Submission.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @submission }
    end
  end


  # GET /submissions/1/edit
  def edit
    @submission = Submission.find(params[:id])
  end

  # POST /submissions
  # POST /submissions.json
  # PUT /submissions/1
  # PUT /submissions/1.json
  def update
    @submission = Submission.find(params[:id])
	part=Participation.find(@submission.Participation_id)
	comp=Competition.find(part.Competition_id)
	if current_user.id == part.User_id
	  if comp.endtime>Time.new

		respond_to do |format|
		  if @submission.response!=nil
			@submission.submited=Time.now
		  end
		  if @submission.update_attributes(params[:submission])
		    format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
		    format.json { head :ok }
		  else
		    format.html { render action: "edit" }
		    format.json { render json: @submission.errors, status: :unprocessable_entity }
		  end
		end
	  else
		redirect_to @submission, status: 'Competition expired.'
	  end
	else
	  redirect_to @submission, status: 'Submissions can only be modified by the participant.'
	end
  end

end
