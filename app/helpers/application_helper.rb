# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title
    base_title = "优客网"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{h(@title)}"
    end
  end
  
  def logo
    image_tag("logo.gif", :alt => "Sample App", :class => "round")
  end
end
