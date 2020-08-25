package = "kong-plugin-jq-transformer"
version = "1.0-1"
supported_platforms = {"linux", "macosx"}
source = {
  url = "git://github.com/tibbycat/kong-jq-transformer",
  tag = "1.0-1"
}
description = {
  summary = "./jq transformer plugin for kong",
  license = "Apache 2.0",
  homepage = "https://github.com/tibbycat/kong-jq-transformer",
}
dependencies = {
  "lua ~> 5.1"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.jq-transformer.handler"] = "handler.lua",
    ["kong.plugins.jq-transformer.schema"] = "schema.lua",
    ["kong.plugins.jq-transformer.jq-transformer"] = "jq-transformer.lua"
  }
}
