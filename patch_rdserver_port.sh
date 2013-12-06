#!/bin/bash
mv config/Configuration config/Configuration.old
sed 's/define RD_SERVER_PORT\s*[0-9]*/define RD_SERVER_PORT 10000/g' config/Configuration.old > config/Configuration
mv include/paging.h include/paging.h.old
sed 's/define NFRAMES\s*[0-9]*/define NFRAMES 50/g' include/paging.h.old > include/paging.h
