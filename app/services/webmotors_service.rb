class WebmotorsService

  attr_reader :uri, :model, :response

  def initialize(model)
    @uri = URI("#{Rails.configuration.webmotors_uri}#{model}")
  end

  def list(id)
    id ? connect({ marca: id }) : connect({})
    return populate(JSON.parse(@response.body), id)
  end

  private
    def connect(params)
      @response = Net::HTTP.post_form(uri, params)
    end

    def populate(models_json, id)
      names = []
      models_json.each do |json|
        names << json["Nome"]
      end
      unless id
        Make.where(name: names).each do |make|
          names.delete make.name
        end
        models_json.each do |json|
          if names.include?(json["Nome"])
            Make.create(name: json["Nome"], webmotors_id: json["Id"])
          end
        end
        return Make.all
      else
        make = Make.where(webmotors_id: id)[0]
        Model.where(make_id: make.id, name: names).each do |model|
          names.delete model.name
        end
        models_json.each do |json|
          if names.include?(json["Nome"])
            Model.create(make_id: make.id, name: json["Nome"])
          end
        end
        return Model.where(make_id: make.id)
      end
    end
end
