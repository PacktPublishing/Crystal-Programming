@[ADI::Register]
class Blog::Converters::Database < ATH::ParamConverter
  def initialize(@entity_manager : Blog::Services::EntityManager); end

  # :inherit:
  def apply(request : ATH::Request, configuration : Configuration(T)) : Nil forall T
    id = request.attributes.get "id", Int64

    unless model = @entity_manager.repository(T).find? id
      raise ATH::Exceptions::NotFound.new "An item with the provided ID could not be found."
    end

    request.attributes.set configuration.name, model, T
  end
end
