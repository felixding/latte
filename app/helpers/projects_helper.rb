module ProjectsHelper

  def nested_ordered_list(project, pages, edition=nil)
    content_tag :ol do
      pages.collect do |page, child_pages|
        klass = (params[:project_id] == project.slug && params[:id] = page.id) ? "current" : nil
        content_tag :li, :class => klass do
          begin
#            raise child_pages.inspect if page.id==61
            (link_to_unless_current(page.title, url_for([project, edition, page])) { content_tag :span, page.title } + (nested_ordered_list(project, child_pages, edition) if child_pages)).html_safe
          rescue
            raise url_for([project, edition, page])
            #(link_to_unless_current(page.title, url_for([project, edition, page])) { content_tag :span, page.title }).html_safe
          end
        end
      end.join.html_safe
    end
  end

end