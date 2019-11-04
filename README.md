# kong-jq-transformer
jq request/response transformer for kong
## Prerequisites
1. Kong 0.12, or 0.14
2. Requires lua-jq which you can get from https://github.com/tibbycat/lua-jq
## Installing
Install jq-transformer
```
1. git clone https://github.com/tibbycat/kong-jq-transformer.git
2. sudo mkdir /usr/local/share/lua/5.1/kong/plugins/jq-transformer
3. sudo cp kong-jq-transformer/* /usr/local/share/lua/5.1/kong/plugins/jq-transformer
4. Add jq-transformer to /etc/kong/kong.conf custom_plugins
5. restart kong
```
