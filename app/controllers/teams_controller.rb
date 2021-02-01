class TeamsController < ApplicationController
  before_action :set_team, only: %i[show edit update destroy]

  # GET /teams or /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1 or /teams/1.json
  def show; end

  # GET /subscribe
  def subscribe
    @team = Team.find_by name: params[:team]

    respond_to do |format|
      if @team == nil
        format.html { redirect_to teams_url, notice: 'Team not found.' }
        format.json { render json: "Team not found.", status: :unprocessable_entity }
      elsif @team.users.include?(current_user)
        format.html { redirect_to teams_url, notice: 'User is already subscribed.' }
        format.json { render json: "User is already subscribed.", status: :unprocessable_entity }
      elsif create_team_user(@team.id, current_user.id, false)
        format.html { redirect_to @team, notice: 'Successfully subscribed to team.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { redirect_to @team, notice: 'Error while subscribing: ' + @team.errors }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
    @subjects = Subject.all
  end

  def create_team_user(team_id, user_id, is_admin)
    team_user = TeamUser.new

    team_user.team_id = team_id
    team_user.user_id = user_id
    team_user.is_admin = is_admin

    team_user.save
  end

  # POST /teams or /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        create_team_user(@team.id, current_user.id, true)

        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def team_params
    params.require(:team).permit(
      :name,
      subjects_attributes: %i[
        id
        name
        _destroy
      ],
      users_attributes: [
        :email
      ]
    )
  end
end
