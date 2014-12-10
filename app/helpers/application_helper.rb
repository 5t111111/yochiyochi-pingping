module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'yochiyochi-pingping'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # Returns Bootstrap friendly type
  def alert_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      danger: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def website_owner(website)
    User.find(website.user_id)
  end
end
