module ProjectsHelper

  def nested_ordered_list(project, pages)
    content_tag :ol do
      pages.collect do |page, child_pages|
          content_tag :li do
              link_to(page.title, url_for([project, page])) + (nested_ordered_list(project, child_pages) if child_pages)
          end
      end.join.html_safe
    end
  end

end