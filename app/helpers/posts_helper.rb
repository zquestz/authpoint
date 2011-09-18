module PostsHelper
  def linked_tag_list(post)
    post.tags.map do |tag|
      link_to tag.name, posts_path(:tag => tag.name)
    end.join(', ').html_safe
  end
end
