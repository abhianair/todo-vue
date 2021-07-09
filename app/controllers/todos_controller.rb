class TodosController < ApplicationController

   def index
     if params[:assignee].present?
       @todos = Todo.where(:assignee => params[:assignee]).order(:id => "desc")
     else
       @todos = Todo.all.order(:id => "desc")
     end
     render json: @todos.as_json(include: :ruser)
   end

   def home
     if Rails.env != "production"
      # render json: Task.all
     else
       redirect_to root_path
     end
   end

  def create
    todo = current_user.reported_todos.create(permitted_params)
    if todo.valid?
      render json: todo.as_json(include: :ruser)
    else
      render json: { errors: todo.errors }, status: :bad_request
    end
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy
    head :ok
  end

  def update
    todo = Todo.find(params[:id])
    if todo.update(permitted_params)
      render json: todo
    else
      render json: { errors: todo.errors }, status: :bad_request
    end
  end

  def update_status
    todo = Todo.find(params[:id])
    todo.update_attributes(:status => params[:status])
    render json: todo
  end


   private

  def permitted_params
    params.permit(:body, :assignee)
  end





end
