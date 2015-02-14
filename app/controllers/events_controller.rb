class EventsController < ApplicationController

  def index
    load_team
    @events = @team.events.page params[:page]
  end

  private

  def load_team
    @team ||= Team.find(params[:team_id])
  end
end
