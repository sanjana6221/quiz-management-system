module ApplicationHelper
  def current_admin_user
    @current_admin_user ||= AdminUser.find(session[:admin_user_id]) if session[:admin_user_id]
  end

  def admin_signed_in?
    current_admin_user.present?
  end

  def nav_link_class(active_condition = false)
    base_classes = "px-3 py-2 rounded-md text-sm font-medium transition-colors duration-200"
    if active_condition
      "#{base_classes} bg-blue-100 text-blue-700"
    else
      "#{base_classes} text-gray-700 hover:text-blue-600 hover:bg-gray-100"
    end
  end

  def admin_nav_link_class(active_condition = false)
    base_classes = "px-3 py-2 rounded-md text-sm font-medium transition-colors duration-200"
    if active_condition
      "#{base_classes} bg-gray-700 text-white"
    else
      "#{base_classes} text-gray-300 hover:text-white hover:bg-gray-700"
    end
  end

  def brand_logo_class
    "flex items-center space-x-2 text-xl font-bold"
  end
end
