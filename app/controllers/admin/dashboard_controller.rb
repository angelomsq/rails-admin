class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :initial_breadcrumbs

  def index
    
  end

  def styles
    breadcrumb t(@resource_path), :admin_styles_path
  end


  private
  def initial_breadcrumbs
    breadcrumb t("admin.dashboard.index.title"), :admin_root_path, match: :exact
    @resource_path = "#{controller_path.tr('/', '.')}.#{action_name}.title"
  end
  
end
