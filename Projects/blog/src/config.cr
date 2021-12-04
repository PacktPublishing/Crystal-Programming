def ATH::Config::CORS.configure : ATH::Config::CORS?
  new(
    allow_credentials: true,
    allow_origin: ["*"],
  )
end

ACF.configuration_annotation Blog::Annotations::Template, name : String

def ATH::Config::ContentNegotiation.configure : ATH::Config::ContentNegotiation?
  new(
    Rule.new(path: /^\/article\/\d+$/, priorities: ["json", "html"], methods: ["GET"], fallback_format: "json"),
    Rule.new(priorities: ["json"], fallback_format: "json")
  )
end
