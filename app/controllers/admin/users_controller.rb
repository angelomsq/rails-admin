class Admin::UsersController < Admin::DashboardController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :main_breadcrumb
  before_action :action_breadcrumb, only: %i[show new edit]

  # GET /admin/users
  def index
    @users = User.all.order(id: :asc)
  end

  # GET /admin/users/1
  def show
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "User was successfully created."
      redirect_to [:admin,@user]
    else
      flash[:error] = "Please review the problems below."
      render :new
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      flash[:success] = "User was successfully updated."
      redirect_to [:admin,@user]
    else
      flash[:error] = "Please review the problems below."
      render :edit
    end
  end

  # DELETE /admin/users/1
  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, role_ids: [])
    end

    def main_breadcrumb
      breadcrumb t("#{controller_path.tr('/', '.')}.index.title"), :admin_users_path, match: :exact
    end

    def action_breadcrumb
      @resource_name = @user.username
      breadcrumb t(@resource_path, name: @resource_name),:admin_users_path
    end
end
