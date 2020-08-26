local BasePlugin = require "kong.plugins.base_plugin"
local jq_filter = require "kong.plugins.jq-transformer.jq_transformer"

local table_concat = table.concat

local TransformerHandlerJq = BasePlugin:extend()


local JSON, MULTI, ENCODED = "json", "multi_part", "form_encoded"

function TransformerHandlerJq:new()
  TransformerHandlerJq.super.new(self, "jq-transformer")
end

function TransformerHandlerJq:access(conf)
  TransformerHandlerJq.super.access(self)
  local content_type = ngx.req.get_headers()["content-type"]

  if jq_filter.is_request_transform_set(conf) and jq_filter.is_json_body(content_type) then
    ngx.req.read_body()
    local body = ngx.req.get_body_data()
    if not body or body == "" then
      local filename = ngx.req.get_body_file()
      if filename then
	local filehandle=io.open (filename, "r")
	if filehandle then
          filehandle:seek("set")
          body = filehandle:read("*a")
          filehandle:close()
	end
      end
    end

    if(#body>0) then
      body = jq_filter.transform_jq_body(conf.request, body)
      ngx.req.set_body_data(body)
    end

    ngx.req.set_header("content-length", #body)

  end

end

function TransformerHandlerJq:header_filter(conf)
  TransformerHandlerJq.super.header_filter(self)
  ngx.header["content-length"] = nil

  local ctx = ngx.ctx

  ctx.rt_body_chunks = {}
  ctx.rt_body_chunk_number = 1
end

function TransformerHandlerJq:body_filter(conf)
  TransformerHandlerJq.super.body_filter(self)

  if ngx.status == ngx.HTTP_OK then
    if jq_filter.is_response_transform_set(conf) and jq_filter.is_json_body(ngx.header["content-type"]) then
      local ctx = ngx.ctx
      local chunk, eof = ngx.arg[1], ngx.arg[2]
      if eof and ctx.rt_body_chunks then
        local body = jq_filter.transform_jq_body(conf.response, table_concat(ctx.rt_body_chunks))
        ngx.arg[1] = body
      else
        ctx.rt_body_chunks[ctx.rt_body_chunk_number] = chunk
        ctx.rt_body_chunk_number = ctx.rt_body_chunk_number + 1
        ngx.arg[1] = nil
      end
    end
  end
end


TransformerHandlerJq.PRIORITY = 750
TransformerHandlerJq.VERSION = "0.1.0"

return TransformerHandlerJq
