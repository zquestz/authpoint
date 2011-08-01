module ApplicationHelper
  # Render's flash notices and errors
  def render_flash_messages
    output = ''
    flash.each do |key, value|
      output = ([:notice, :error].include?(key) ? content_tag(:div, content_tag(:div, value, :class => (key.to_s + ' rollup')), :id => 'message') : nil)
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
  
  # Display user info for header
  def login_info
    (link_to(current_user.name, user_path(current_user)) + ' - ') if current_user
  end
  
  def connected_networks
    providers = current_user.credentials.map(&:provider)
    output = '<div id="networks">'
    output += image_tag('providers/tiny/google.png') if providers.include?('google')
    output += image_tag('providers/tiny/facebook.png') if providers.include?('facebook')
    output += image_tag('providers/tiny/twitter.png') if providers.include?('twitter')
    output += '</div>'
  end
end
