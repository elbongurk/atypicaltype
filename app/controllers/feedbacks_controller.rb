class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(create_params)

    if @feedback.save
      redirect_to root_url
    else
      render action: :new
    end
  end

  private

  def create_params
    params.require(:feedback).permit(:name, :email, :message)
  end
end
