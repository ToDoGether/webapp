#!/usr/bin/env ruby
# frozen_string_literal: true

# Controller to handle tasks
class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks or /tasks.json
  def index
    # @tasks = Task.filter(params.slice(:title, :description, :subject, :team, :search))
    @tasks = current_user.tasks
                         .filter_by_title(params[:title])
                         .filter_by_description(params[:description])
                         .filter_by_subject(params[:subject])
                         .filter_by_team(params[:team])
                         .filter_by_search(params[:search])

    @user_tasks = UserTask.where(status: 2, task_id: @tasks.map(&:id)).includes(:task).order('tasks.duedate') +
                  UserTask.where(status: 1, task_id: @tasks.map(&:id)).includes(:task).order('tasks.duedate') +
                  UserTask.where(status: 3, task_id: @tasks.map(&:id)).includes(:task).order('tasks.duedate')
  end

  # GET /change_status/1/prev or /change_status/1/next
  def change_status
    user_task_id = params[:id]
    direction = params[:direction]

    user_task = UserTask.find(user_task_id)

    error = false

    case direction
    when 'prev'
      user_task.status = user_task.status_prev
    when 'next'
      user_task.status = user_task.status_next
    else
      # Wrong direction-parameter
      error = true
    end

    # Ensure User can not change staus
    error = true if user_task.user_id != current_user.id

    # Ensure User can not change to status 'nostatus'
    error = true if user_task.status_name(user_task.status) == 'nostatus'

    respond_to do |format|
      # Save only if no error!
      if !error && user_task.save
        format.html { redirect_to tasks_url, notice: 'Task status was successfully changed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to tasks_url, notice: 'Task status change failed.' }
        format.json { head :no_content }
      end
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show; end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit; end

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
    params.require(:task).permit(:name, :subject_id, :duedate, :worktype, :description)
  end

  # A list of the param names that can be used for filtering the Product list
  def filtering_params(params)
    params.slice(:status, :location, :starts_with)
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
    UserTask.find_by(task_id: task_id).destroy
  end
end
