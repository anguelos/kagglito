#!/usr/bin/env ruby

require 'zip/zip'
require 'zip/zipfilesystem'
require 'sqlite3'


fin=File.open("../hdibco2010.zip")
sqldb=SQLite3::Database.new('./db/development.sqlite3')
sqldb.execute('INSERT INTO users(email,password,isadmin,profile) values("anguelos.nicolaou@gmail.com","anguelos",TRUE,"From Unibe");')
sqldb.execute('INSERT INTO users(email,password,isadmin,profile) values("anguelos.chief@gmail.com","guest",FALSE,"From nowhere");')
sqldb.commit()
sqldb.execute('INSER INTO datasets(name,description,gtpublic,inputpublic) values("sample","This is a sample dataset",FALSE,TRUE);')
sqldb.commit()

sqldb.execute('INSER INTO evaluators(name,description,src,minscore,maxscore,user_id) values("allisgood","This is a stupid evaluator. He likes all submissions the same","def allisgood(inputGtSubmission)return 1.0 end ",0.0,1.0,1);')
sqldb.commit()


sqldb.execute('INSER INTO competitions(name,description,scorepublic,minscore,maxscore,user_id) values("allisbad","This is a stupid evaluator. He hates all submissions the same","def allisbad(inputGtSubmission)return 0.0 end ",0.0,1.0,1);')
sqldb.commit()



zf =Zip::ZipFile.open(fin)
allData = Hash.new
Zip::ZipFile.open(fin) { |zip_file|
   zip_file.each { |f|
     if f.name[-1]!='/'
	dname=f.name.split('/')[-2]
	allData[dname]=Hash.new
     end
     #puts fdata
   }
}

Zip::ZipFile.open(fin) { |zip_file|
   zip_file.each { |f|
     fdata=zip_file.read(f.name)
     if f.name[-1]!='/'
	dname=f.name.split('/')[-2]
	if f.name.split('/')[-1].split('.')[-2]=='in'
		allData[dname]['in']=fdata
		allData[dname]['inFname']=f.name
	end
	if f.name.split('/')[-1].split('.')[-2]=='gt'
		allData[dname]['gt']=fdata
		allData[dname]['gtFname']=f.name
	end
	puts f.name
	puts fdata.length
     end
     #puts fdata
   }
}
allData.keys.each(){
	|patName|
	puts patName
	gt=allData[patName]['gt'];
	input=allData[patName]['in'];
	gtFname=allData[patName]['gtFname'];
	puts '{'+gtFname+'}'
	inputFname=allData[patName]['inFname'];
	puts '{'+inputFname+'}'
	gtFnameExt=gtFname.split('.')[-1]
	inputFnameExt=inputFname.split('.')[-1]
	name=inputFname.split('.')[-3]
	#new schema
	sqldb.execute('INSERT INTO chalenges(gt,input,inputfileext,gtfileext,name)value(?,?,?,?,?);',
		SQLite3::Blob.new(gt),
		SQLite3::Blob.new(input),
		inputFnameExt,gtFnameExt,name
	)
	#old schema
	#sqldb.execute('INSERT INTO chalenges(gt,input,inputfileext,gtfileext,name)value(?,?,?,?,?);',
	#	SQLite3::Blob.new(gt),
	#	SQLite3::Blob.new(input),
	#	inputFnameExt,gtFnameExt,name
	#	)


	sqldb.commit()
}





















