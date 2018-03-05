class Instructor::LessonsController < ApplicationController
  #Makes sure user logged in
  before_action :authenticate_user!
  #Makes sure user authorized but only for new and create actions
  before_action :require_authorized_for_current_section, only: [:new, :create]
  before_action :require_authorized_for_current_lesson, only: [:update]
  


  def create
    #Makes create section secure if instructor(user) isn't current_user
    @lesson = current_section.lessons.create(lesson_params)
    redirect_to instructor_course_path(current_section.course)
  end

  def update
    current_lesson.update_attributes(lesson_params)
    render plain: 'updated!'
  end

  private

   def require_authorized_for_current_lesson
    if current_lesson.section.course.user != current_user
      render plain: 'Unauthorized', status: :unauthorized
    end
   end

   def current_lesson
      @current_lesson ||= Lesson.find(params[:id])
   end

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
    params.require(:lesson).permit(:title, :subtitle, :video, :row_order_position)
  end

end
