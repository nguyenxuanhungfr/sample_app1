module UsersHelper
  def gravatar_for user, options = {size: Settings.user_model.max_length_name}
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def relationship
    current_user.active_relationships.build
  end

  def following_user user_id
    current_user.active_relationships.find_by followed_id: user_id
  end
end
