class TasksController < ApplicationController
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice]='Tâche créer avec succès'
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice]='Tâche mise à jour avec succès'
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:notice]='Tâche supprimer avec succès'
    redirect_to tasks_path
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content, :user_id)
    end

    def correct_user
      @task=Task.find(params[:id])
      redirect_to tasks_path unless current_owmner?(@task)
  end 
end
