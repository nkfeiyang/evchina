module EventsHelper
  def ShowEventStatus(status)
    case status
    when 'published'    : '发布'
    when 'draft'        : '草稿'
    end
  end
end
