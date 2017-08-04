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

end
