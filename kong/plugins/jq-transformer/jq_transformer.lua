require("jq")

local table_insert = table.insert
local pcall = pcall
local lower = string.lower
local find = string.find

local _M = {}

function _M.is_json_body(content_type)
  return content_type and find(lower(content_type), "application/", nil, true) and find(lower(content_type), "json", nil, true)
end

function _M.is_request_transform_set(conf)
  if conf.request == nil then return false end
  return #conf.request > 0 
end

function _M.is_response_transform_set(conf)
  if conf.response == nil then return false end
  return #conf.response > 0 
end

function _M.transform_jq_body(transform, buffered_data)
  if buffered_data then
    local status, res = pcall(jq, transform, buffered_data)
    if status then
      if res then
        return res
      else
        return buffered_data
      end
    else
      return buffered_data
    end
  end
end

return _M
