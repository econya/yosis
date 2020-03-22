class PagesController < ApplicationController
  def home
    @courses = Course.all
  end
end
