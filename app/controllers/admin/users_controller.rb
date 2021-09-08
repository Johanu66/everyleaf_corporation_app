class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy do_admin not_do_admin ]

  skip_before_action :login_required, only: [:new, :create]

  before_action :is_admin?

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: "L'utilisateur a été créé avec succès." }
        #format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: "L'utilisateur a été mis à jour avec succès." }
        #format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.tasks.destroy_all
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: "L'utilisateur a été détruit avec succès." }
      format.json { head :no_content }
    end
  end

  def do_admin
    if @user.update(admin: true)
      respond_to do |format|
        format.html { redirect_to admin_users_url, notice: "L'utilisateur est desormais admin." }
      end
    end
  end

  def not_do_admin
    if User.where(admin: true).count == 1
      respond_to do |format|
        format.html { redirect_to admin_users_url, notice: "Impossible de supprimer le dernier administrateur." }
      end
    else
      if @user.update(admin: false)
        respond_to do |format|
          format.html { redirect_to admin_users_url, notice: "L'utilisateur n'est plus admin desormais." }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def is_admin?
      if current_user.admin == false
        respond_to do |format|
          format.html { redirect_to tasks_url, notice: "Seul l'administrateur peut accéder" }
        end
      end
    end
end
