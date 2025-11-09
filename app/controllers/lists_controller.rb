class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    @lists = List.all.order(created_at: :desc)
  end

  def show
    @todos = @list.todos.order(created_at: :desc)
  end

  def new
    @list = List.new
  end

  def edit
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to @list, notice: "List was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @list.update(list_params)
      redirect_to @list, notice: "List was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_url, notice: "List was successfully deleted."
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :description)
  end
end
