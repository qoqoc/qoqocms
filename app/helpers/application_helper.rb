module ApplicationHelper
  def menu_pages
    Page.roots.ordered.active
  end
end
