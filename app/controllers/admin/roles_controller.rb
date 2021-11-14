class Admin::RolesController < Admin::DashboardController
  before_action :set_role, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  before_action :main_breadcrumb
  before_action :action_breadcrumb, only: %i[show new edit]

  # GET /roles or /roles.json
  def index
    @roles = Role.all
  end

  # GET /roles/1 or /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles or /roles.json
  def create
    @role = Role.new(role_params)

    if @role.save
      flash[:success] = "Role was successfully created."
      redirect_to [:admin,@role] 
    else
      flash[:error] = "Please review the problems below."
      render :new
    end
  end

  # PATCH/PUT /roles/1 or /roles/1.json
  def update
    if @role.update(role_params)
      flash[:success] = "Role was successfully updated."
      redirect_to [:admin,@role]
    else
      flash[:error] = "Please review the problems below."
      render :edit
    end
  end

  # DELETE /roles/1 or /roles/1.json
  def destroy
    @role.destroy
    flash[:success] = "Role was successfully deleted."
    redirect_to admin_roles_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def role_params
      params.require(:role).permit(:name, :description)
    end

    def main_breadcrumb
      breadcrumb t("#{controller_path.tr('/', '.')}.index.title"), :admin_roles_path, match: :exact
    end

    def action_breadcrumb
      @resource_name = @role.name
      breadcrumb t(@resource_path, name: @resource_name),:admin_roles_path
    end
end
