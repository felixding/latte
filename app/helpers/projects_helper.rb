module ProjectsHelper

  def nested_ordered_list(project, pages)
    content_tag :ol do
      pages.collect do |page, child_pages|
        klass = (params[:project_id] == project.slug && params[:id] = page.id) ? "current" : nil
        content_tag :li, :class => klass do
            (link_to_unless_current(page.title, url_for([project, page])) { content_tag :span, page.title } + (nested_ordered_list(project, child_pages) if child_pages)).html_safe
        end
      end.join.html_safe
    end
  end

end