LUA_DIR=/usr/local
LUA_LIBDIR=$(LUA_DIR)/lib/lua/5.1
LUA_SHAREDIR=$(LUA_DIR)/share/lua/5.1
KONG_PLUGINS_DIR=$(LUA_SHAREDIR)/kong/plugins
install:
	cp -r kong-jq-transformer/kong/plugins/jq-transformer $(KONG_PLUGINS_DIR)


