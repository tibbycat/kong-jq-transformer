# kong-jq-transformer
jq request/response transformer for kong
## Prerequisites
1. Kong 0.12, or 0.14
2. Requires lua-jq which you can get from https://github.com/tibbycat/lua-jq
2.1 lua-jq requires gcc and jq-devel (or libjq-dev)
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
## Recipies
### Transform elasticsearch 7 /_search response total to 6 compatible
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

