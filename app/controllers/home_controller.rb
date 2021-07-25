class HomeController < ApplicationController
  def home
    if logged_in?
      redirect_to albums_path
    else
      render :index, layout: false
    end
  end
end
