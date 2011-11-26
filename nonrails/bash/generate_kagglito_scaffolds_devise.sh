#!/bin/bash
echo 'gem '\''devise'\'' '>>Gemfile #user managment
echo 'gem '\''narray'\'' '>>Gemfile #matrix library numpy-like
echo 'gem '\''rmagick'\'' '>>Gemfile #image managment with the help of imagemagick
echo 'gem '\''imageruby'\'' '>>Gemfile #image managment 
echo 'gem '\''imageruby-bmp'\'' '>>Gemfile #loading and storing bmps
bundle install

rails generate devise User password:string email:string profile:text isadmin:boolean

rails generate scaffold Dataset name:string gtpublic:boolean inputpublic:boolean description:text

rails generate scaffold Evaluator name:string description:text minvalue:float maxvalue:float src:binary User:references

rails generate scaffold Competition name:string description:text starttime:timedate endtime:timedate publicscore:boolean 
User:references Evaluator:references Dataset:references

rails generate scaffold Participation submissionspublic:boolean User:references Competition:references

rails generate scaffold Chalenge gt:blob gtfileext:string input:blob input:string name:string Dataset:references

rails generate scaffold Submission responce:blob responcefileext:string announced:datetime submited:datetime score:float Chalenge:references participation:references


