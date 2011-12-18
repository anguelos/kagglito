class Submission < ActiveRecord::Base
  belongs_to :Chalenge
  belongs_to :Participation
  belongs_to :User

  def self.evaluate(subm)
    require 'RMagick'
    src=subm.Participation.Competition.Evaluator.src
    response=subm.response
    gt=subm.Chalenge.gt
    input=subm.Chalenge.input
    if src==nil or response==nil or gt==nil or input==nil
      return
    end
    src=blob2tmpSrc(src)
    response=blob2tmpPng(response)
    gt=blob2tmpPng(gt)
    input=blob2tmpPng(input)
    cmd=[src,response,gt,input].join(' ')    
    subm.score=IO.popen(cmd).read.to_f
    subm.save!
    File.delete(src)
    File.delete(gt)
    File.delete(input)
    File.delete(response)
  end
  
  private
  def self.blob2tmpPng(b)
    img=Magick::Image.from_blob(b)
    if img.class==Array
      img=img[0]
    end
    img.format='PNG'
    tmpFname='/tmp/kagglito_evaluate_'+rand().to_s[2..-1]+'.png'
    f=File.open(tmpFname,'wb' )
    f.write(img.to_blob())
    f.flush()
    f.close()
    return tmpFname
  end
  def self.blob2tmpSrc(b)
    tmpFname='/tmp/kagglito_evaluate_'+rand().to_s[2..-1];
    f=File.open(tmpFname,'wb')
    b=b.split("\r\n").join("\n")
    f.write(b)
    f.flush()
    f.close()
    File.chmod(0755,tmpFname)
    return tmpFname
  end
  
end
