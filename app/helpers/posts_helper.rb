module PostsHelper

  def author_select_options
    [[current_user.name, current_user.id]] + User.all.map{|u| [u.name, u.id] if u.id != current_user.id }
  end

  def image_urls(post)
    %w(top_image image_1 image_2).inject([]) do |arr, image_type|
      arr << post.send(image_type).url(:medium)
      arr.compact
    end
  end

  def gravatar_helper(user)
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", width: 60
  end

  def comment_details(comment)
    time = distance_of_time_in_words(comment.created_at, Time.now)
    "posted by <b>#{comment.user.username}</b> #{time} ago".html_safe
  end
end
