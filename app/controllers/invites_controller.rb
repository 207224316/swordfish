class InvitesController < ApplicationController
  before_filter :ensure_team_admin, :except => :accept

  def create
    invite = current_team.invite(params[:email])
    TeamMailer.invite(current_team, invite).deliver
    render :json => invite, :status => :created
  end

  def accept
    invite = Invite.from_token(params[:token])
    invite.accept(current_user)
    head :ok
  end

  def fulfill
    invite = Invite.from_token(params[:token])
    invite.fulfill(params[:key])
    head :ok
  end
end
