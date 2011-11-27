class DatasetsController < ApplicationController
  # GET /datasets
  # GET /datasets.json
	def parseZipFile(fin)
		allData = Hash.new	
		Zip::ZipFile.open(fin) do |zip_file|
		    zip_file.each do |f|
     			if f.name[-1]!='/'
					dname=f.name.split('/')[-2]
					allData[dname]=Hash.new
				end
			end
		end
		Zip::ZipFile.open(fin) do |zip_file|
			zip_file.each do |f|
				fdata=zip_file.read(f.name)
				if f.name[-1]!='/' && f.name.split['/'][-1].split('.').length()>=2
					dname=f.name.split('/')[-2]
					if f.name.split('/')[-1].split('.')[-2]=='in'
						allData[dname]['in']=fdata
						allData[dname]['inFnameExt']=f.name.split('.')[-1]
						allData[dname]['name']=f.name.split('.')[-3]
					end
					if f.name.split('/')[-1].split('.')[-2]=='gt'
						allData[dname]['gt']=fdata
						allData[dname]['gtFnameExt']=f.name.split('.')[-1]
					end
				end
			 #puts fdata
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
    @dataset = Dataset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dataset }
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
    respond_to do |format|
      if @dataset.save
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

    respond_to do |format|
      if @dataset.update_attributes(params[:dataset])
        format.html { redirect_to @dataset, notice: 'Dataset was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @dataset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datasets/1
  # DELETE /datasets/1.json
  def destroy
    @dataset = Dataset.find(params[:id])
    @dataset.destroy

    respond_to do |format|
      format.html { redirect_to datasets_url }
      format.json { head :ok }
    end
  end
end
