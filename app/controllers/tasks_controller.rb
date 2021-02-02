#!/usr/bin/env ruby
# frozen_string_literal: true

# Controller to handle tasks
class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks or /tasks.json
  def index
    # @tasks = Task.filter(params.slice(:title, :description, :subject, :team, :search))
    @tasks = current_user.tasks
    @tasks = @tasks.filter_by_title(params[:title])
    @tasks = @tasks.filter_by_description(params[:description])
    @tasks = @tasks.filter_by_subject(params[:subject])
    @tasks = @tasks.filter_by_team(params[:team])
    @tasks = @tasks.filter_by_search(params[:search])
  end

  # GET /tasks/1 or /tasks/1.json
  def show; end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit; end

  # GET /filter
  def filter; end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        fill_user_tasks(@task)

        format.html { redirect_to @task, notice: 'Task was successfully created.' }
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
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    delete_from_user_tasks(@task.id)
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
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
    params.require(:task).permit(:name, :subject, :duedate, :worktype, :description)
  end

  def fill_user_tasks(task)
    task.subject.team.users.each do |user|
      user_task = UserTask.new

      user_task.user_id = user.id
      user_task.task_id = task.id
      user_task.status = 1

      user_task.save
    end
  end

  def delete_from_user_tasks(task_id)
    UserTask.where(task_id: task_id).destroy_all
  end
end
