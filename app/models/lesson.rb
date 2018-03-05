class Lesson < ApplicationRecord
  belongs_to :section
  mount_uploader :video, VideoUploader
  #Should rank lessons in database
   include RankedModel
   ranks :row_order, with_same: :section_id

   def next_lesson
    #Returns the next lesson in the section,, if not returns nill
    lesson = section.lessons.where("row_order > ?", self.row_order).rank(:row_order).first
    return lesson
   end

end
