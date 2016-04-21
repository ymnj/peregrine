class SearchesController < ApplicationController

  def index

    @photos = Photo.all.order('created_at DESC')

  end
   
end
