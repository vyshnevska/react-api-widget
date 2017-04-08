module PostsHelper

  def author_select_options
    [[current_user.name, current_user.id]] + User.all.map{|u| [u.name, u.id] if u.id != current_user.id }
  end
end
