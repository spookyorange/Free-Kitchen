class StepsController < ApplicationController
  before_action :authenticate_owner

  def authenticate_owner
    @recipe = Recipe.find(params[:recipe_id])
    if !user_signed_in? || !current_user.profile || !(current_user.profile == @recipe.profile)
      redirect_to @recipe
    end
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @step = @recipe.steps.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @step = @recipe.steps.new(step_params)
    if @step.save
      flash.now[:notice] = 'Step successfully saved'
    else
      flash.now[:alert] = 'Something went wrong'
    end
    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
    @step = Step.find(params[:id])

    if @step.update(step_params)
      flash[:notice] = 'Step successfully updated'
    else
      flash[:alert] = 'Something went wrong'
    end
    redirect_to @recipe

  end

  def destroy
    @step = Step.find(params[:id])
    @step.delete

    flash[:notice] = 'Step successfully deleted'
    redirect_to @recipe
  end

  private

  def step_params
    params.require(:step).permit(:title, :description, :time_consumption, :order)
  end
end