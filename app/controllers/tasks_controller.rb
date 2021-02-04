#!/usr/bin/env ruby
# frozen_string_literal: true

# Controller to handle tasks
class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks or /tasks.json
  def index
    session_vars
    apply_filters
  end

  def reset_filter
    session[:subject] = nil
    session[:team] = nil
    session[:status] = nil
    session[:fulltext] = nil

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
      else
        format.html { redirect_to tasks_url, notice: 'Task status change failed.' }
      end
      format.json { head :no_content }
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    redirect_permission_denied unless current_user.has_task?(@task)
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
    redirect_permission_denied unless current_user.is_task_admin?(@task)
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
    unless current_user.is_task_admin?(@task)
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
    unless current_user.is_task_admin?(@task)
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
      :description,
      attachments_attributes: %i[
        id
        filename
        _destroy
      ],
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

  def session_vars
    session[:subject] = params[:subject] unless params[:subject].blank?
    session[:team] = params[:team] unless params[:team].blank?
    session[:status] = params[:status] unless params[:status].blank?
    session[:fulltext] = params[:fulltext] unless params[:fulltext].blank?
  end

  def apply_filters
    @tasks = current_user.tasks
                         .filter_by_subject(session[:subject])
                         .filter_by_team(session[:team])
                         .filter_by_fulltext(session[:fulltext])

    # Filtern nach Status nur WENN
    #   1. KEIN anderer Filter ist ODER
    #   2. spezieller Status-Filter ausgewählt wurde (NICHT BLANK bzw. DEFAULT)
    @tasks = @tasks.filter_by_status(session[:status]) if !isset_any_filter? || !session[:status].blank?

    # Changing order of results
    @user_tasks = filtered_user_tasks(2) +
                  filtered_user_tasks(1) +
                  filtered_user_tasks(3)
  end

  def filtered_user_tasks(status)
    current_user.user_tasks.where(status: status, task_id: @tasks.map(&:id)).includes(:task).order('tasks.duedate')
  end

  def isset_any_filter?
    if !session[:subject].blank? ||
       !session[:team].blank? ||
       !session[:fulltext].blank?
      true
    else
      false
    end
  end
end
