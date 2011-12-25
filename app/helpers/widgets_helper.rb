module WidgetsHelper
  
  def clearfix options={}
    opt = {:class => " clearfix"}
    options[:class] += opt[:class] if options[:class]
    (options[:class] || opt[:class]).strip!
    opt = opt.merge(options)
    content_tag(:div, nil, opt)
  end
  
  def link_to_user(user, options={})
    
    default_options = {
      :subdomain => false,
      :avatar => false,
      :title => user.name,
      :class => ""
    }
    
    options = default_options.merge(options)

    if options[:avatar]
      return unless user.avatar?

      text = image_tag(user.avatar.url(options[:avatar]), :alt => user.name, :class => "avatar")

      options[:class] += " avatar".strip
    else
      text = user.name
    end
    
    #raise url_for(user)#user_path(:subdomain => "aaa").inspect
    link_to(text, user, :title => options[:title], :class => options[:class])
  end
  
	def title(*titles)
	  seperator = " - "

    default_options = {:sitename => true}
    options = titles.last.is_a?(Hash) ? titles.pop : {}
    options = default_options.merge(options)

	  page_title = page_title_for_return = titles.join(seperator)
	  page_title = "latte" + seperator + page_title_for_return if options[:sitename]

    content_for(:title, page_title)

    page_title_for_return
 end
  
  def required_mark(label)
    raw(label + content_tag(:span, " *", :class => "required_mark"))
  end

  #
	# paginator
	#
	def paginator(collections, options={})
	 will_paginate collections, options
	end
	
	#
	# call to action
	#
	def cta(text, href, options=nil)
	  link_to content_tag(:span, text), href, :class => "cta"
	end
end