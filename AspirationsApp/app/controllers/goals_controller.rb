class GoalsController < ApplicationController
  before_action :ensure_logged_in

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to :back
    end
  end

  def edit
    # fail
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to user_url(current_user)
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    Goal.delete(params[:id])
    redirect_to user_url(current_user)
  end

  private

  def goal_params
    params.require(:goal).permit(:body, :visibility)
  end
end
