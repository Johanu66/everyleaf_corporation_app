class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    if params[:task].present?
      if params[:task][:name].present? && params[:task][:status].present?
        @tasks = Task.search_by_name_and_status(params[:task][:name],params[:task][:status]).page(params[:page])
      elsif params[:task][:name].present?
        @tasks = Task.search_by_name(params[:task][:name]).page(params[:page])
      elsif params[:task][:status].present?
        @tasks = Task.search_by_status(params[:task][:status]).page(params[:page])
      else
        @tasks = current_user.tasks.order(created_at: :desc).page(params[:page])
      end
    elsif params[:sort_expired]=='true'
      @tasks = current_user.tasks.order(expired_at: :desc).page(params[:page])
    elsif params[:sort_priority]=='true'
      @tasks = current_user.tasks.order(priority: :desc).page(params[:page])
    else
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page])
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "La tâche a été créée avec succès." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "La tâche a été mise à jour avec succès." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "La tâche a été détruite avec succès." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :detail, :expired_at, :sort_expired, :status, :priority, :sort_priority)
    end
end
