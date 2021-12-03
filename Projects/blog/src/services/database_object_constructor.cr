@[ADI::Register(alias: ASR::ObjectConstructorInterface)]
class Blog::Services::DBObjectConstructor
  include ASR::ObjectConstructorInterface

  def initialize(
    @request_store : ATH::RequestStore,
    @fallback_constructor : ASR::InstantiateObjectConstructor,
    @entity_manager : Blog::Services::EntityManager
  ); end

  # :inherit:
  def construct(navigator : ASR::Navigators::DeserializationNavigatorInterface, properties : Array(ASR::PropertyMetadataBase), data : ASR::Any, type)
    unless type <= DB::Serializable
      return @fallback_constructor.construct navigator, properties, data, type
    end

    unless "PUT" == @request_store.request.method
      return @fallback_constructor.construct navigator, properties, data, type
    end

    unless entity = @entity_manager.repository(type).find? data["id"].as_i64
      raise ATH::Exceptions::NotFound.new "An item with the provided ID could not be found."
    end

    entity.apply navigator, properties, data

    entity
  end
end
