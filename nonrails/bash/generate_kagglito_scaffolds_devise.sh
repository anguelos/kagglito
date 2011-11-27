#!/bin/bash
#gems
echo 'gem '\''devise'\'', '\''>=1.5.1'\'' '>>Gemfile #user managment
bundle install
rails generate devise:install
echo 'gem '\''narray'\'' '>>Gemfile #matrix library numpy-like
echo 'gem '\''rmagick'\'' '>>Gemfile #image managment with the help of imagemagick
echo 'gem '\''imageruby'\'' '>>Gemfile #image managment 
echo 'gem '\''imageruby-bmp'\'' '>>Gemfile #loading and storing bmps
bundle install



#generate
rails generate devise User password:string email:string profile:text isadmin:boolean

rails generate scaffold Dataset name:string gtpublic:boolean inputpublic:boolean description:text

rails generate scaffold Evaluator name:string description:text minvalue:float maxvalue:float src:binary User:references

rails generate scaffold Competition name:string description:text starttime:datetime endtime:datetime publicscore:boolean 
User:references Evaluator:references Dataset:references

rails generate scaffold Participation submissionspublic:boolean User:references Competition:references

rails generate scaffold Chalenge gt:binary gtfileext:string input:binary input:string name:string Dataset:references

rails generate scaffold Submission response:binary responsefileext:string announced:datetime submited:datetime score:float Chalenge:references participation:references

#destroy

