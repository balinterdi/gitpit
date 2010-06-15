class String
  # returns a slugified version of the string (Foo Bar => foo-bar)
  # uses the friendly_id gem (http://norman.github.com/friendly_id)
  def to_slug
    FriendlyId::SlugString.new(self).normalize.to_s
  end
end