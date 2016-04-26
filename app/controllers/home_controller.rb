class HomeController < ApplicationController

  def index
    @recent_photos = Photo.last(4).reverse;
  end
end
