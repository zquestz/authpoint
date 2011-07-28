class Credential < ActiveRecord::Base
  validates_presence_of :user, :provider, :uid

  # Belongs to a User.
  belongs_to :user

  # Slug the url.
  def to_param
    "#{id}-#{uid.parameterize}"
  end
end