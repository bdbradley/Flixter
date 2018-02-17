class Instructor::LessonsController < ApplicationController
  def new
    #Pulls the section_id from the params
    @section = Section.find(params[:section_id])
    #Have to have t his form template before we can add it to the view
    #in view/instructors/lessons/new.html.erb
    #The code below builds a new blank lesson
    @lesson = Lesson.new
  end

  def create
    @section = Section.find(params[:section_id])
    @lesson = @section.lessons.create(lesson_params)
    redirect_to instructor_course_path(@section.course)
  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle)
  end

end
