module ApplicationHelper
  def locale_to
    @locale_to = "#{controller_name.capitalize}##{action_name}"
  end  
end
