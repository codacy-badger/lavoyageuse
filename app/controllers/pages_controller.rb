class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :contact, :about, :chart, :cgu]

  def home; end

  def contact; end

  def about; end

  def chart; end

  def cgu; end

end
