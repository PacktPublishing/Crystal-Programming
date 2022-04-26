require "json"

require "athena"
require "pg"
require "crinja"

require "./config"

require "./controllers/*"
require "./entities/*"
require "./param_converters/*"
require "./services/*"

module Blog
  VERSION = "0.1.0"

  module Controllers; end

  module Entities; end
end
