class Lesson < ApplicationRecord
  belongs_to :section
  mount_uploader :video, VideoUploader
  #Should rank lessons in database
   include RankedModel
   ranks :row_order, with_same: :section_id
end
