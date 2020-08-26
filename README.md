# kong-jq-transformer
jq request/response transformer for kong
## Prerequisites
1. Kong 0.12-CE, 0.14-CE, 1.5-EE
2. Requires lua-jq which you can get from https://github.com/tibbycat/lua-jq
2.1. lua-jq requires gcc and jq-devel (or libjq-dev)
## TODO
1.5-EE : After adding the plugin and saving, editing is not available. Use the API to modify/delete until fixed.
## Installing
### Quick
```
1. sudo luarocks install kong-plugin-jq-transformer
2. Add jq-transformer to /etc/kong/kong.conf custom_plugins
3. restart kong
```
### Old hat
Install jq-transformer
```
1. git clone https://github.com/tibbycat/kong-jq-transformer.git
2. sudo mkdir /usr/local/share/lua/5.1/kong/plugins/jq-transformer
3. sudo make install (sudo cp kong-jq-transformer/* /usr/local/share/lua/5.1/kong/plugins/jq-transformer)
4. Add jq-transformer to /etc/kong/kong.conf custom_plugins
5. restart kong
```
### Adding plugin config
/etc/kong/kong.conf
```
# 0.12-CE, 0.14-CE
custom_plugins = jq-transformer

```
```
# 1.5-EE
plugins = bundled,jq-transformer

```
## Recipies
### Transform elasticsearch 7 .../_search response total to 6 compatible
jq-transformer response
```
.hits.total.value as $v|if $v then .hits.total |= $v else . end
```
### kafka-gateway via Confluent kafka REST
jq-transformer response
```
{"message":"Message successfully sent."}+.
```
jq-transformer request
```
{"records":[{"value":.}]}
```
request-transformer append header
```
Content-Type:application/vnd.kafka.json.v2+json
```
### Filter or rename fields. (If you have low bandwidth [eg. mobile] , or sensitive data)
jq-transformer response
```
{fieldA: .field1, fieldB: .field2 }
```
