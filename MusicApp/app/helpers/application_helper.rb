module ApplicationHelper
  def auth_token
    "<input type='hidden' value='#{form_authenticity_token}'>".html_safe
  end
end
