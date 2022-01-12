@[ADI::Register]
class HTMLFormatHandler
  include Athena::Framework::View::FormatHandlerInterface

  private CRINJA = Crinja.new loader: Crinja::Loader::FileSystemLoader.new "#{__DIR__}/../views"

  def call(view_handler : ATH::View::ViewHandlerInterface, view : ATH::ViewBase, request : ATH::Request, format : String) : ATH::Response
    ann_configs = request.action.annotation_configurations

    unless template_ann = ann_configs[Blog::Annotations::Template]?
      raise "Unable to determine the template for the '#{request.attributes.get "_route"}' route."
    end

    unless (data = view.data).is_a? Crinja::Object
      raise "Cannot convert value of type '#{view.data.class}' to '#{format}'."
    end

    content = CRINJA.get_template(template_ann.name).render({data: view.data})

    ATH::Response.new content, headers: HTTP::Headers{"content-type" => "text/html"}
  end

  def format : String
    "html"
  end
end
