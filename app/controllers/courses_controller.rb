class CoursesController < ApplicationController
  def index
  
     @courses = Course.all
     
  end

  def show
    #/courses/9
    #val = params[:id]
    @course = Course.find(params[:id])
  end
end
