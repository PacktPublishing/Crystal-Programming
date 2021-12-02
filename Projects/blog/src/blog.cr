require "json"

require "athena"
require "jwt"
require "pg"

require "./controllers/*"
require "./event_listeners/*"
require "./models/*"

module Blog
  VERSION = "0.1.0"

  module Controllers; end

  module Models; end
end

ATH.run
