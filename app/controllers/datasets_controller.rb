#require 'zip'
require 'zip/zip'
require 'zip/zipfilesystem'

class DatasetsController < ApplicationController
  # GET /datasets
  # GET /datasets.json
	before_filter :authenticate_user!, :except => [:index,:show]
	#before_filter :user_admin, :except => [:show,:index]
	#before_filter :user_owns,:except => [:show,:index,:new,:create]
	
	def createZipFile(dataset)
		
	end
	def parseZipFile(fin)
		allData = Hash.new
		zip_file=Zip::ZipFile.open(fin)
		    zip_file.each do |f|
     			if f.name[-1]!='/'
					dname=f.name.split('.')[-3]
					allData[dname]=Hash.new
				end
			end
			zip_file.each do |f|
				if not(f.directory?())
					fdata=zip_file.read(f.name)
					if f.name[-1]!='/' && f.name.split('/')[-1].split('.').length()>=2
						dname=f.name.split('.')[-3]

						if f.name.split('/')[-1].split('.')[-2]=='in'
							allData[dname]['in']=fdata
							allData[dname]['inFname'] = f.name
							allData[dname]['inFnameExt']=f.name.split('.')[-1]
							allData[dname]['name']=f.name.split('.')[-3]
						end
						if f.name.split('/')[-1].split('.')[-2]=='gt'
							allData[dname]['gt']=fdata
              allData[dname]['gtFname'] = f.name
							allData[dname]['gtFnameExt']=f.name.split('.')[-1]
						end
					end	
				end
			end
		return allData
	end

  def index
    @datasets = Dataset.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @datasets }
    end
  end


  # GET /datasets/1
  # GET /datasets/1.json
  def show
    @dataset = Dataset.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dataset }
    end
  end

  # GET /datasets/new
  # GET /datasets/new.json
  def new
	    if current_user.isadmin
			@dataset = Dataset.new
			respond_to do |format|
			  format.html # new.html.erb
			  format.json { render json: @dataset }
			end
		else
			redirect_to datasets_path,:alert => 'You must be an administrator to create datasets'
		end
  end

  # GET /datasets/1/edit
  def edit
    @dataset = Dataset.find(params[:id])
  end

  # POST /datasets
  # POST /datasets.json
  def create
    @dataset = Dataset.new(params[:dataset])	
	@dataset.User_id=current_user.id
    respond_to do |format|
      if @dataset.save
		if params['zipfile'].present?
			chalAsDict=parseZipFile(File.open(params['zipfile'].path))
			count=1;
			chalAsDict.keys.each do
				|k|
				chal=Chalenge.new()
				chal.Dataset_id=@dataset.id
    		chal.name=@dataset.name+'.'+sprintf('%05d',count)
    		chal.inputfilename=chalAsDict[k]['inFname']
    		chal.input=chalAsDict[k]['in']
    		chal.gt=chalAsDict[k]['gt']
    		chal.gtfilename=chalAsDict[k]['gtFname']
    		chal.inputfileext=chalAsDict[k]['inFnameExt']
    		chal.gtfileext=chalAsDict[k]['gtFnameExt']
				chal.save
				count=count+1
			end
		end
        format.html { redirect_to @dataset, notice: 'Dataset was successfully created.' }
        format.json { render json: @dataset, status: :created, location: @dataset }
      else
        format.html { render action: "new" }
        format.json { render json: @dataset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /datasets/1
  # PUT /datasets/1.json
  def update
    @dataset = Dataset.find(params[:id])
	if current_user.id==@dataset.User_id
		respond_to do |format|
		  if @dataset.update_attributes(params[:dataset])
			if params['zipfile'].present?
				chalAsDict=parseZipFile(File.open(params['zipfile'].path))
				count=1;
				chalAsDict.keys.each do
					|k|
					chal=Chalenge.new()
					chal.Dataset_id=@dataset.id
					chal.name=@dataset.name+'.'+sprintf('%05d',count)
					chal.input=chalAsDict[k]['in']
					chal.gt=chalAsDict[k]['gt']
					chal.inputfileext=chalAsDict[k]['inFnameExt']
					chal.gtfileext=chalAsDict[k]['gtFnameExt']
					chal.save
					count=count+1
				end
			end
		    format.html { redirect_to @dataset, notice: 'Dataset was successfully updated.' }
		    format.json { head :ok }
		  else
		    format.html { render action: "edit" }
		    format.json { render json: @dataset.errors, status: :unprocessable_entity }
		  end
		end
	else
		redirect_to datasets_path,:alert => 'You must own a dataset to edit it'
	end
  end


  def copy
	if user_signed_in? and current_user.isadmin
		@dataset = Dataset.find(params[:id])
		if (@dataset.inputpublic and @dataset.gtpublic) or current_user.id=@dataset.User_id
			nds=Dataset.new
			nds.User_id=current_user.id
			nds.name=@dataset.name+current_user.email.split('@')[0]
			nds.gtpublic=false
			nds.inputpublic=false
			nds.description="Copy of "+@dataset.name+"Original description:\n------\n"+@dataset.description
			if nds.save
				dstchalenges=[]
				all_ok=true;
				count=1
				srcchalenges=Chalenge.find(:all,:conditions => { :Dataset_id => @dataset.id})
				srcchalenges.each do |srcchal|
					dstchal=Chalenge.new()
					dstchal.Dataset_id=nds.id
					dstchal.name=String(count)
					dstchal.gt=srcchal.gt
					dstchal.input=srcchal.input
					dstchal.gtfileext=srcchal.gtfileext
					dstchal.inputfileext=srcchal.inputfileext
					dstchal.save
					count=count+1;
				end
				redirect_to edit_dataset_path(nds) ,:notice => 'Dataset cloned successfuly.'
			else
			  print "\nCOPY 9\n\n"
              redirect_to @dataset ,:alert => 'Could not copy Dataset.'
			end
		else
			print "\nCOPY 10\n\n"
		  redirect_to @dataset ,:alert => 'Could not copy Dataset its not public.'
		end
	else
	  redirect_to @dataset ,:alert => 'Only administrators can create/copy Datasets.'
	end
  end
  # DELETE /datasets/1
  # DELETE /datasets/1.json
  def destroy
    @dataset = Dataset.find(params[:id])
	if current_user.id==@dataset.User_id
		chl=Chalenge.find(:all,:conditions => { :Dataset_id => @dataset.id})
		chl.each do
			|chalenge|
			chalenge.destroy
		end
		@dataset.destroy
		respond_to do |format|
		  format.html { redirect_to datasets_url }
		  format.json { head :ok }
		end
	else
		redirect_to datasets_path,:alert => 'You must own a dataset to destroy it'
	end
  end
end
