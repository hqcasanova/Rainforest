module ApplicationHelper
  
  #Generates sequence of anchors from the current path by splitting it into its constituent 'pages'
  #The name of the current page is the only item in the sequence not marked up with a anchor.
  #Cutoff: array of strings which would abort the anchor sequence generation
  def breadcrumbs(cutoff)
    partial_path = ''
    pages = request.path[1..-1].split('/')
    content_tag(:span, class: "breadcrumbs") do
      pages[0..-2].each do |page| 
        if cutoff.include?(page)
          break
        end
        partial_path = "#{partial_path}/#{page}"
        concat link_to(page, partial_path, title: "Go to #{page}", class: 'crumb-link')
      end
      concat content_tag(:span, pages[-1], class: 'crumb-current')
    end
  end

  #Employs the current controller and action names to generate a human-readable page title
  #Tagline: string used for the homepage instead of the aforementioned names. Useful for SEO purposes.  
  def page_titles(tagline)
    if request.path == root_path
      tagline
    elsif request.path['edit'] || request.path['new']
      "#{action_name.capitalize} #{controller_name.singularize}"
    else
      "#{controller_name.singularize.capitalize} #{action_name}"
    end
  end
end
