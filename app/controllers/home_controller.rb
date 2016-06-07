class HomeController < ApplicationController
  def index
    WebmotorsService.new("marcas").list(nil)
  end
end
