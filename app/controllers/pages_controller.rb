class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i(home contact about chart cgu)

  def home; end

  def contact; end

  def about
    @steps = t('.steps.steps')
    @tips = t('.tips.tips')
  end

  def chart; end

  def cgu; end

end
