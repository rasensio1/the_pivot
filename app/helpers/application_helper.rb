module ApplicationHelper

  def dollars(cents)
    number_to_currency(cents.to_f / 100)
  end

  def photo_preview(photo)
    if photo.store.watermark_id
      cl_image_tag(photo.file,
                       :transformation => {:height => 500, :crop => :fill},
                       :overlay => photo.store.watermark_accessor,
                       :html_height => 200, :gravity => :south_east, :x => 10, :y => 10)
    else
      cl_image_tag(photo.file,
                       :transformation => {:height => 500, :crop => :fill})
    end
  end

end
