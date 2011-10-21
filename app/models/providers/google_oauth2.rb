class Providers::GoogleOauth2 < Providers::Default
  def initialize
    init_api_object
    discover_api
    super
  end

  # Update profile info.
  def profile_info(credential)
    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.people.get,
        'userId' => 'me'
      )
      profile = JSON.parse(body[0])

      attrs = { :profile_api_data => profile }
      attrs.merge!({ 
        :name => profile['displayName']
      }) if profile['displayName']

      attrs.merge!({ 
        :description => profile['tagline']
      }) if profile['tagline']

      attrs.merge!({ 
        :image => profile['image']['url']
      }) if profile['image'] && profile['image']['url']

      attrs
    end
  end

  # List all activities
  # https://code.google.com/+/partners/pages/api/activities/list.html
  def list_activities(credential, params = {})
    if update_token(credential)
      default_params = {
        'collection' => 'all',
        'userId' => 'me'
      }

      params = default_params.merge(params)
      
      status, headers, body = @api_object.execute(
        @plus_api.activities.list,
        params
      )
      JSON.parse(body[0])
    end
  end

  # Get an activity
  # https://code.google.com/+/partners/pages/api/activities/get.html
  def get_activity(credential, params = {})
    return false unless check_required_params(params, ['activityId'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.activities.get,
        params
      )
      JSON.parse(body[0])
    end
  end

  # Insert an activity
  # https://code.google.com/+/partners/pages/api/activities/insert.html
  def insert_activity(credential, params = {}, request_body = {})
    if update_token(credential)
      default_params = {
        'userId' => 'me'
      }

      params = default_params.merge(params)

      status, headers, body = @api_object.execute(
        @plus_api.activities.insert,
        params,
        request_body.to_json,
        {'Content-Type' => 'application/json'}
      )
      JSON.parse(body[0])
    end
  end

  # Update an activity
  # https://code.google.com/+/partners/pages/api/activities/update.html
  def update_activity(credential, params = {}, request_body = {})
    return false unless check_required_params(params, ['activityId'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.activities.update,
        params,
        request_body.to_json,
        {'Content-Type' => 'application/json'}
      )
      JSON.parse(body[0])
    end
  end

  # List activities by circle
  # https://code.google.com/+/partners/pages/api/activities/listByCircle.html
  def list_activities_by_circle(credential, params = {})
    return false unless check_required_params(params, ['circleId'])

    if update_token(credential)      
      status, headers, body = @api_object.execute(
        @plus_api.activities.list_by_circle,
        params
      )
      JSON.parse(body[0])
    end
  end

  # Search activities
  # https://code.google.com/+/partners/pages/api/activities/search.html
  def search_activities(credential, params = {})
    if update_token(credential)      
      status, headers, body = @api_object.execute(
        @plus_api.activities.search,
        params
      )
      JSON.parse(body[0])
    end
  end

  # Remove activity
  # https://code.google.com/+/partners/pages/api/activities/remove.html
  def remove_activity(credential, params = {})
    return false unless check_required_params(params, ['activityId'])

    if update_token(credential)      
      status, headers, body = @api_object.execute(
        @plus_api.activities.remove,
        params
      )
      JSON.parse(body[0])
    end
  end
  
  # List all circles.
  # https://code.google.com/+/partners/pages/api/circles/list.html
  def list_circles(credential, params = {})
    if update_token(credential)
      default_params = {
        'userId' => 'me'
      }

      params = default_params.merge(params)
      
      status, headers, body = @api_object.execute(
        @plus_api.circles.list,
        params
      )
      JSON.parse(body[0])
    end
  end
  
  # Get circle.
  # https://code.google.com/+/partners/pages/api/circles/get.html
  def get_circle(credential, params = {})
    return false unless check_required_params(params, ['circleId'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.circles.get,
        params
      )
      JSON.parse(body[0])
    end
  end
  
  # Insert circle.
  # https://code.google.com/+/partners/pages/api/circles/insert.html
  def insert_circle(credential, params = {}, request_body = {})
    if update_token(credential)
      default_params = {
        'userId' => 'me'
      }

      params = default_params.merge(params)
      
      status, headers, body = @api_object.execute(
        @plus_api.circles.insert,
        params,
        request_body.to_json,
        {'Content-Type' => 'application/json'}
      )
      JSON.parse(body[0])
    end
  end
  
  # Update circle.
  # https://code.google.com/+/partners/pages/api/circles/update.html
  def update_circle(credential, params = {}, request_body = {})
    return false unless check_required_params(params, ['circleId'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.circles.update,
        params,
        request_body.to_json,
        {'Content-Type' => 'application/json'}
      )
      JSON.parse(body[0])
    end
  end
  
  # Remove circle.
  # https://code.google.com/+/partners/pages/api/circles/remove.html
  def remove_circle(credential, params = {})
    return false unless check_required_params(params, ['circleId'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.circles.remove,
        params
      )
      JSON.parse(body[0])
    end
  end

  # List comments on activity
  # https://code.google.com/+/partners/pages/api/comments/list.html
  def list_comments(credential, params = {})
    return false unless check_required_params(params, ['activityId'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.comments.list,
        params
      )
      JSON.parse(body[0])
    end
  end

  # Get a comment
  # https://code.google.com/+/partners/pages/api/comments/get.html
  def get_comment(credential, params = {})
    return false unless check_required_params(params, ['commentId'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.comments.get,
        params
      )
      JSON.parse(body[0])
    end
  end

  # Insert comment
  # https://code.google.com/+/partners/pages/api/comments/insert.html
  def insert_comment(credential, params = {}, request_body = {})
    return false unless check_required_params(params, ['activityId'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.comments.insert,
        params,
        request_body.to_json,
        {'Content-Type' => 'application/json'}
      )
      JSON.parse(body[0])
    end
  end

  # Update comment
  # https://code.google.com/+/partners/pages/api/comments/update.html
  def update_comment(credential, params = {}, request_body = {})
    return false unless check_required_params(params, ['commentId'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.comments.update,
        params,
        request_body.to_json,
        {'Content-Type' => 'application/json'}
      )
      JSON.parse(body[0])
    end
  end

  # Remove a comment
  # https://code.google.com/+/partners/pages/api/comments/remove.html
  def remove_comment(credential, params = {})
    return false unless check_required_params(params, ['commentId'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.comments.remove,
        params
      )
      JSON.parse(body[0])
    end
  end

  # List people
  # https://code.google.com/+/partners/pages/api/people/list.html
  def list_people(credential, params = {})
    return false unless check_required_params(params, ['userId', 'collection'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.people.list,
        params
      )
      JSON.parse(body[0])
    end
  end

  # Get person
  # https://code.google.com/+/partners/pages/api/people/get.html
  def get_person(credential, params = {})
    return false unless check_required_params(params, ['userId'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.people.get,
        params
      )
      JSON.parse(body[0])
    end
  end

  # Search people
  # https://code.google.com/+/partners/pages/api/people/search.html
  def search_people(credential, params = {})
    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.people.search,
        params
      )
      JSON.parse(body[0])
    end
  end

  # Add to circle
  # https://code.google.com/+/partners/pages/api/people/addToCircle.html
  def add_person_to_circle(credential, params = {})
    return false unless check_required_params(params, ['circleId', 'userId'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.people.add_to_circle,
        params
      )
      JSON.parse(body[0])
    end
  end

  # Remove from circle
  # https://code.google.com/+/partners/pages/api/people/removeFromCircle.html
  def remove_person_from_circle(credential, params = {})
    return false unless check_required_params(params, ['circleId', 'userId'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.people.remove_from_circle,
        params
      )
      JSON.parse(body[0])
    end
  end

  # List people by activity
  # https://code.google.com/+/partners/pages/api/people/listByActivity.html
  def list_people_by_activity(credential, params = {})
    return false unless check_required_params(params, ['activityId', 'collection'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.people.list_by_activity,
        params
      )
      JSON.parse(body[0])
    end
  end

  # List people by circle
  # https://code.google.com/+/partners/pages/api/people/listByCircle.html
  def list_people_by_circle(credential, params = {})
    return false unless check_required_params(params, ['circleId'])

    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.people.list_by_circle,
        params
      )
      JSON.parse(body[0])
    end
  end

  def self.provider_name
    'Google'
  end

  protected

  def init_api_object
    @api_object ||= Google::APIClient.new(
      :authorization => :oauth_2,
      :host => 'www.googleapis.com',
      :http_adapter => HTTPAdapter::NetHTTPAdapter.new
    )
  end

  def discover_api
    @api_object.register_discovery_document(
      'plusPages', 'v1',
      open("#{Rails.root}/config/api/plusPages-v1.json") { |f| f.read }
    )

    @plus_api = @api_object.discovered_api('plusPages', 'v1')
  end

  def update_token(credential, options = {})
    return false unless credential.refresh_token && credential.token && credential.expires_at

    auth_info = @api_object.authorization.update_token!({
      :refresh_token => credential.refresh_token,
      :access_token => credential.token,
      :expires_in => credential.expires_at,
      :issued_at => credential.issued_at
    })

    if auth_info
      credential.token = auth_info.access_token
      credential.refresh_token = auth_info.refresh_token
      credential.expires_at = auth_info.expires_in
      credential.issued_at = auth_info.issued_at
      credential.save if options[:save] == true && credential.changed?
    end

    auth_info
  end

  def check_required_params(params, required_params)
    unless (missing_params = required_params - params.keys).empty?
      puts "Missing required params - #{missing_params.join(',')}"
      return false
    else
      return true
    end
  end
end