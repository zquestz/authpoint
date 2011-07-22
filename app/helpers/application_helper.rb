module ApplicationHelper
  # Render's flash notices and errors
  def render_flash_messages
    output = ''
    flash.each do |key, value|
      output = ([:notice, :error].include?(key) ? content_tag(:div, value, :class => (key.to_s + ' rollup')) : nil)
    end
    return output
  end

  # Quick way to link a url. Pass options to add classes/etc.
  def display_website(url, options = {})
    return link_to(url, url, options)
  end

  # Quick way to link an email address. Works just like display_website
  def display_email(email, options = {})
    return link_to(email, 'mailto:' + email, options)
  end
end
