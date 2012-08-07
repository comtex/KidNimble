ActiveAdmin::Dashboards.build do
  list_limit = 10

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  section "New Users" do
    ul do
      User.order(:created_at).limit(list_limit).collect do |user|
        li link_to(user.name, edit_user_registration_path(user))
      end
    end
  end
  
  section "Pending Reviews" do
    ul do
      Review.where(:approved => 'N').order(:created_at).limit(list_limit).collect do |review|
        li link_to(review.title, edit_review_path(review))
      end
    end
  end

  section "Pending Counselors" do
    ul do
      Counselor.where(:approved => 'N').order(:created_at).limit(list_limit).collect do |counselor|
        li link_to(counselor.user.email, edit_counselor_path(counselor))
      end
    end
  end
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
