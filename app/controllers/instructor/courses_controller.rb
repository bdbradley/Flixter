class Instructor::CoursesController < ApplicationController
  #Means user has to be signed in, in order to access this page
  before_action :authenticate_user!

  def new
    @course = Course.new 
  end

  def create
    @course = current_user.courses.create(course_params)
    #if the course is valid then 
    if @course.valid?
      redirect_to instructor_course_path(@course)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @course = Course.find(params[:id])
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :cost)
  end
end
