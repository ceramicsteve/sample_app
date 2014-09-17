module UsersHelper

  # Returns the Gravatar (http://gravatar.com) for the given user
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase) # :: selector that Digest is MD5 which uses hexdigest command to create MD5
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

end
