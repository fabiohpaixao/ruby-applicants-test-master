class ModelsController < ApplicationController
  def index
    @models = WebmotorsService.new("modelos").list(params[:make][:"webmotors_id"])
    make = Make.where(webmotors_id: params[:make][:"webmotors_id"])[0]
    @name = make.name
  end
end
