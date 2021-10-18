require "http/client"
require "transform"

private FILTER = %({"name": .info.title, "swagger_version": .swagger, "endpoints": .paths | keys})

HTTP::Client.get "https://petstore.swagger.io/v2/swagger.json" do |response|
  File.open("./out.yml", "wb") do |file|
    Transform::Processor.new.process [FILTER], response.body_io, file
  end
end
