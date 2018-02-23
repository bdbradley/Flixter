class Instructor::LessonsController < ApplicationController
  #Makes sure user logged in
  before_action :authenticate_user!
  #Makes sure user authorized
  before_action :require_authorized_for_current_section
  def new
      #Have to have this form template before we can add it to the view
    #in view/instructors/lessons/new.html.erb
    #The code below builds a new blank lesson
    @lesson = Lesson.new
  end


  def create
    #Makes create section secure if instructor(user) isn't current_user
    @lesson = current_section.lessons.create(lesson_params)
    redirect_to instructor_course_path(current_section.course)
  end

  private

   def require_authorized_for_current_section
    if current_section.course.user != current_user
      return render plain: 'Unauthorized', status: :unauthorized
    end
  end

  #@current_section ||= ) says: if we've looked up the 
  #currentent_section beforehand use the value that we looked up previously. If we 
  #haven't looked up this section before, go into the database, look it up and also 
  #make sure to remember the value in case we need to look it up again later.

  helper_method :current_section
  def current_section
    @current_section ||= Section.find(params[:section_id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle, :video)
  end

end
