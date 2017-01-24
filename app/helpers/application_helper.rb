module ApplicationHelper
  def active_link_to(name, path)
    active_class = "active" if current_page?(path)
    content_tag(:li, class: "nav-item #{active_class}") do
      link_to(name, path, class: "nav-link")
    end
  end
end
