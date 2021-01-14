PROJECT = "newman-reporter-sql"

.PHONY: local-install 

local-install:
	npm uninstall -g ${PROJECT}
	npm pack
	npm install -g ${PROJECT}-*.tgz

test-v1:
	newman run https://www.getpostman.com/collections/631643-f695cab7-6878-eb55-7943-ad88e1ccfd65-JsLv -r influxdb \
		--reporter-influxdb-server localhost \
		--reporter-influxdb-port 8086 \
		--reporter-influxdb-name vijay \
		--reporter-influxdb-measurement okay

test-v2:
	newman run https://www.getpostman.com/collections/631643-f695cab7-6878-eb55-7943-ad88e1ccfd65-JsLv -r influxdb \
		--reporter-influxdb-server localhost \
		--reporter-influxdb-port 8086 \
		--reporter-influxdb-org viz \
		--reporter-influxdb-version 2 \
		--reporter-influxdb-username viz \
		--reporter-influxdb-password db123456 \
		--reporter-influxdb-name viz \
		--reporter-influxdb-measurement api_results

test-failed:
	newman run test/failed.json -r influxdb \
		--reporter-influxdb-server localhost \
		--reporter-influxdb-port 8086 \
		--reporter-influxdb-name vijay \
		--reporter-influxdb-measurement okay

failed:
	newman run test/failed.json -r influxdb \
		--reporter-influxdb-server localhost \
		--reporter-influxdb-port 8086 \
		--reporter-influxdb-name vijay \
		--reporter-influxdb-measurement okay \
		--reporter-influxdb-mode udp

test-remote:
	newman run test/failed.json -r influxdb \
		--reporter-influxdb-server 192.168.100.40 \
		--reporter-influxdb-port 8086 \
		--reporter-influxdb-name failed \
		--reporter-influxdb-measurement failed6

test-udp:
	newman run https://www.getpostman.com/collections/631643-f695cab7-6878-eb55-7943-ad88e1ccfd65-JsLv -r influxdb \
		--reporter-influxdb-server localhost \
		--reporter-influxdb-port 8086 \
		--reporter-influxdb-name vijay \
		--reporter-influxdb-mode udp

bump:
	npm version patch -m "Bumped to version %s"

publish:
	npm publish