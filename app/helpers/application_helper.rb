module ApplicationHelper
  def locale_to
    @locale_to = "#{controller_name.capitalize}##{action_name}"
  end

  def is_nil_and_zero(data)
     data.blank? || data == 0
  end
end
