module ApplicationHelper
  
  def title(name=nil)
    if content_for?(:title)
      content_for :title
    else
      t("#{ controller_path.tr('/', '.') }.#{ action_name }.title", name: name, default: :site_name)
    end
  end

  def active_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end

  def active_menu?(menu_path, item='list')
    if request.path.start_with?(menu_path)
      return 'menu-open' if item=='list'
      return 'active' if item=='link'
    end
    ''
  end

end
