class SubmissionsController < ApplicationController
  # GET /submissions
  # GET /submissions.json
  before_filter :authenticate_user!

  def showresponse
    @submission = Submission.find(params[:id])
    part=Participation.find(@submission.Participation_id)
    comp=Competition.find(part.Competition_id)
    if not(((comp.endtime<Time.now) and (part.submissionspublic))or current_user.id==part.User_id or current_user.id==comp.User_id)
      data=File.read(Rails.root.join('public','na.png'))
      send_data data, :type => 'image/png',:disposition => 'inline'
    else
      respmime=''
      respFext=@submission.responsefileext.downcase
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
    print current_user
    @submission = Submission.find(params[:id])
    chal=Chalenge.find(@submission.Chalenge_id)
    part=Participation.find(@submission.Participation_id)
    comp=Competition.find(part.Competition_id)
    if (current_user.id==comp.User_id)or((comp.starttime<Time.now) and (current_user.id==part.User_id))or(part.submissionspublic and comp.endtime<Time.now)
      if current_user.id==part.User_id and @submission.announced==nil
        @submission.announced=Time.now
        @submission.save!
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
    #@submissions = Submission.find(:all,:conditions => { :User_id => current_user.id})
    @submissions = Submission.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @submissions }
    end
  end

  def myindex
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
  # 

  def update
    @submission = Submission.find(params[:id])
    part=Participation.find(@submission.Participation_id)
    comp=Competition.find(part.Competition_id)
    if current_user.id == part.User_id
      if comp.endtime>Time.now and comp.starttime<Time.now
        respond_to do |format|
          if @submission.response!=nil
            @submission.submited=Time.now
          end
          if @submission.update_attributes(params[:submission])
            if comp.publicscore
              Submission.evaluate(@submission)
            end
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
  #FOR CLIENT
  def chalengepngclient
    submission=Submission.find(params[:id])
    if current_user.id == submission.Participation.User_id
      if submission.Participation.Competition.starttime<Time.now
        require 'RMagick'
        img=Magick::Image.from_blob(submission.Chalenge.input)
        if img.class==Array
          img=img[0]
        end
        img.format='PNG'
        send_data img.to_blob, :type => 'image/png',:disposition => 'inline'
      else
        render :text => "Competition hasen't yet started", :status => :unauthorized
      end
    else
      render :text => "You are not authorised to view the chalenge", :status => :unauthorized
    end
  end
  def submitresponseclient
    submission=Submission.find(params[:id])
    if current_user.id == submission.id
      if submission.Participation.Competition.endtime>Time.now
        submission.response=params[:response].read
        submission.responsefileext=params[:response].original_filename.split('.')[-1]
        submission.save!
        if submission.Participation.Competition.publicscore
          Submission.evaluate(submission)
          send_data submission.score.to_s, :type => 'text/plain',:disposition => 'inline'
        else
          send_data 'NA', :type => 'text/plain',:disposition => 'inline'
        end
      else
        render :text => "Competition has ended no more submissions are accepted", :status => :unauthorized
      end
    else
      render :text => "You are not authorised to submit a response", :status => :unauthorized
    end
    
  end
end
