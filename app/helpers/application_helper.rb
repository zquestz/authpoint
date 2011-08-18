module ApplicationHelper
  # So we can test helpers within rspec that require current_user.
  mattr_accessor :current_user if Rails.env.test?
  
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
    if current_user
      output = '<div id="networks">'
      current_user.credentials.each do |credential|
        title = "#{credential.provider.capitalize} - #{credential.nickname.presence || credential.uid}"
        output += image_tag("providers/tiny/#{credential.provider}.png", :title => title)
      end
      output += '</div>'
    end
  end
end
