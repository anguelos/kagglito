class ChalengesController < ApplicationController
  # GET /chalenges
  # GET /chalenges.json
  before_filter :authenticate_user!, :except => [:index,:show]
  def showgt
    @chalenge = Chalenge.find(params[:id])
	ds=Dataset.find(@chalenge.Dataset_id)
	if( not(ds.gtpublic) )and (not(ds.User_id==current_user.id)) 
		data=File.read(Rails.root.join('public','na.png'))
		send_data data, :type => 'image/png',:disposition => 'inline'
	else
		gtmime=''
		gtFext=@chalenge.gtfileext.downcase
		if(gtFext=='png')
		gtmime='image/png'
		elsif gtFext=='jpg'
		    gtmime='image/jpg'
		elsif gtFext=='bmp'
		    gtmime='image/bmp'
		elsif gtFext=='zip'
		    gtmime='file/zip'
		elsif gtFext=='csv'
		    gtmime='file/csv'
		end
		send_data @chalenge.gt, :type => gtmime,:disposition => 'inline'
	end
  end

  def showinput
    @chalenge = Chalenge.find(params[:id])
	ds=Dataset.find(@chalenge.Dataset_id)
	if( not(ds.inputpublic) )and (not(ds.User_id==current_user.id)) 
		data=File.read(Rails.root.join('public','na.png'))
		send_data data, :type => 'image/png',:disposition => 'inline'
	else
		inputmime=''
		inputFext=@chalenge.gtfileext.downcase
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
		send_data @chalenge.input, :type => inputmime,:disposition => 'inline'
	end  
  end

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
	if user_signed_in? and current_user.isadmin and Dataset.find(:all,:conditions => { :User_id => current_user.id}).length>0
    @chalenge = Chalenge.new	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chalenge }
    end
	else
		redirect_to chalenges_path,:alert => 'You must be an administrator owning at least one Dataset to create a chalenge.'
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
	  if current_user.isadmin and current_user.id==Dataset.find(@chalenge.Dataset_id).User_id
		if params['gtfile'].present? and params['inputfile'].present?
		  @chalenge.input=File.read(params['inputfile'].tempfile)
		  @chalenge.inputfileext=params['inputfile'].original_filename.split('.')[-1]
		  @chalenge.gt=File.read(params['gtfile'].tempfile)
		  @chalenge.gtfileext=params['gtfile'].original_filename.split('.')[-1]
		  if @chalenge.save
			format.html { redirect_to @chalenge, notice: 'Chalenge was successfully created.' }
			format.json { render json: @chalenge, status: :created, location: @chalenge }
		  else
			format.html { render action: "new" }
			format.json { render json: @chalenge.errors, status: :unprocessable_entity }
		  end
		else
		  redirect_to chalenges_path,:alert => 'You must upload an input and groundtruth file.'
		end
	  else
		redirect_to chalenges_path,:alert => 'You must be an administrator and own the dataset to which you add the chalenge.'
	  end
    end
  end


  def update
     @chalenge = Chalenge.find(params[:id])
    respond_to do |format|
	  if current_user.isadmin and current_user.id==Dataset.find(@chalenge.Dataset_id).User_id
		if params['inputfile'].present?
		  @chalenge.input=File.read(params['inputfile'].tempfile)
		  @chalenge.inputfileext=params['inputfile'].original_filename.split('.')[-1]
		end
		if params['gtfile'].present?
		  @chalenge.gt=File.read(params['gtfile'].tempfile)
		  @chalenge.gtfileext=params['gtfile'].original_filename.split('.')[-1]
		end
		if @chalenge.update_attributes(params[:chalenge])
		  format.html { redirect_to @chalenge, notice: 'Chalenge was successfully updated.' }
		  format.json { head :ok }
		else
		  format.html { render action: "edit" }
		  format.json { render json: @chalenge.errors, status: :unprocessable_entity }
		end
	  else
		redirect_to chalenges_path,:alert => 'You must be an administrator and own the dataset to which you add the chalenge.'
	  end
    end
  end



  # DELETE /chalenges/1
  # DELETE /chalenges/1.json
  def destroy
    @chalenge = Chalenge.find(params[:id])
	if current_user.id==Dataset.find(@chalenge.Dataset_id).User_id
		@chalenge.destroy
		respond_to do |format|
		  format.html { redirect_to chalenges_url }
		  format.json { head :ok }
		end
	else
		redirect_to chalenges_path,:alert => 'You must own the dataset that contains a chalenge to destroy it'
	end
  end
end
