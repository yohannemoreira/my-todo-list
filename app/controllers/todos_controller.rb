class TodosController < ApplicationController
  before_action :set_list
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :toggle]

  def index
    @todos = @list.todos.order(created_at: :desc)
  end

  def show
  end

  def new
    @todo = @list.todos.new
  end

  def edit
  end

  def create
    @todo = @list.todos.new(todo_params)

    if @todo.save
      redirect_to list_path(@list), notice: t('todos.flash.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      redirect_to list_path(@list), notice: t('todos.flash.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def toggle
    @todo.update(completed: !@todo.completed)
    redirect_to list_path(@list), notice: t('todos.flash.status_updated')
  end

  def destroy
    @todo.destroy
    redirect_to list_path(@list), notice: t('todos.flash.deleted')
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_todo
    @todo = @list.todos.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:name, :description, :completed)
  end
end
