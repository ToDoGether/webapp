#!/usr/bin/env ruby
# frozen_string_literal: true

# Controller to handle tasks
class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks or /tasks.json
  def index
    session_vars
    calculate_user_tasks
  end

  # GET /filter-reset
  def reset_filter
    session[:subject] = nil
    session[:team] = nil
    session[:status] = nil
    session[:fulltext] = nil
    session[:duedate_min] = nil
    session[:duedate_max] = nil

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  # GET /filter-apply
  def apply_filter
    session_vars(true) # Force setting session vars

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  # GET /change_status/1/prev or /change_status/1/next
  def change_status
    user_task_id = params[:id]
    direction = params[:direction]

    user_task = UserTask.find(user_task_id)

    error = false
    redirect_destination = tasks_url

    case direction
    when 'prev'
      user_task.status = user_task.status_prev
    when 'next'
      user_task.status = user_task.status_next
    when 'todo'
      user_task.status = 1
      redirect_destination = user_task.task
    when 'doing'
      user_task.status = 2
      redirect_destination = user_task.task
    when 'done'
      user_task.status = 3
      redirect_destination = user_task.task
    else
      # Wrong direction-parameter
      error = true
    end

    # Ensure other users can not change staus
    error = true if user_task.user_id != current_user.id

    # Ensure User can not change to status 'nostatus'
    error = true if user_task.status_name(user_task.status) == 'nostatus'

    respond_to do |format|
      # Save only if no error!
      if !error && user_task.save
        format.html { redirect_to redirect_destination, notice: 'Task status was successfully changed.' }
      else
        format.html { redirect_to redirect_destination, notice: 'Task status change failed.' }
      end
      format.json { head :no_content }
    end
  end

  def calendar
    session_vars
    calculate_user_tasks
    calculate_exams
  end

  def exams
    session_vars
    calculate_exams
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    redirect_permission_denied unless current_user.task?(@task)
  end

  # GET /tasks/new
  def new
    unless current_user.admin_teams.any?
      respond_to do |format|
        format.html { redirect_to tasks_url, notice: 'Task can only be created when you are team admin.' }
        format.json { head :no_content }
      end
      return
    end

    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    redirect_permission_denied unless current_user.task_admin?(@task)
  end

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
    unless current_user.task_admin?(@task)
      redirect_permission_denied
      return
    end

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
    unless current_user.task_admin?(@task)
      redirect_permission_denied
      return
    end

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
    params.require(:task).permit(
      :name,
      :subject_id,
      :subject,
      :duedate,
      :worktype,
      :is_exam,
      :description,
      attachments: [],
      weblinks_attributes: %i[
        id
        name
        url
        _destroy
      ]
    )
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

  def redirect_permission_denied
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Permission denied.' }
      format.json { head :no_content }
    end
  end

  def session_vars(force = false)
    force ||= params[:force]

    session[:subject] = params[:subject] if !params[:subject].blank? || force
    session[:team] = params[:team] if !params[:team].blank? || force
    session[:status] = params[:status] if !params[:status].blank? || force
    session[:fulltext] = params[:fulltext] if !params[:fulltext].blank? || force
    session[:duedate_min] = params[:duedate_min] unless params[:duedate_min].blank?
    session[:duedate_max] = params[:duedate_max] unless params[:duedate_max].blank?
  end

  def calculate_exams
    @exams = current_user.tasks.where(is_exam: :true)
    @exams = apply_task_filters(@exams)
  end

  def calculate_user_tasks
    # Filtern nach Status nur WENN
    #   1. KEIN Fulltext-Filter ist ODER
    #   2. spezieller Status-Filter ausgewählt wurde
    user_tasks = if session[:fulltext].blank? || session[:status].present?
                   current_user.user_tasks.filter_by_status(session[:status])
                 else
                   current_user.user_tasks
                 end

    @tasks = current_user.tasks.where(id: user_tasks.map(&:task_id), is_exam: :false)
    @tasks = apply_task_filters(@tasks)

    # Changing order of results
    @user_tasks = filtered_user_tasks(2) +
                  filtered_user_tasks(1) +
                  filtered_user_tasks(3)
  end

  def apply_task_filters(tasks)
    tasks
      .filter_by_subject(session[:subject])
      .filter_by_team(session[:team])
      .filter_by_fulltext(session[:fulltext])
      .filter_by_duedate_min(session[:duedate_min])
      .filter_by_duedate_max(session[:duedate_max])
  end

  def filtered_user_tasks(status)
    current_user.user_tasks.where(status: status, task_id: @tasks.map(&:id)).includes(:task).order('tasks.duedate')
  end
end
