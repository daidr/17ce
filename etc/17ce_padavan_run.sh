#!/bin/sh
# Copyight (C) 2017  www.17ce.com
START=99
CDN_BASE="https://coding.net/u/weimjsam/p/17ce/git/raw/master"
WORK_DIR="/tmp/17ce"
SAVE_DIR="/etc/storage/17ce"
export LD_LIBRARY_PATH=/lib:$WORK_DIR
logging()
{
    logger -t "【17ce】" "$1"
}
wget_install(){
	wget -T 60 -O $1  $2 --no-check-certificate 
	chmod +x $1
}
init_files()
{

    killall -9 17ce_v3 2>/dev/null  >/dev/null
    rm -f /tmp/17ce/UUID
    mkdir -p $WORK_DIR
    mkdir -p $SAVE_DIR
	cd $WORK_DIR
	
	if [ ! -f "/tmp/17ce/17ce_v3" ]; then
		
		wget_install conf.json    $CDN_BASE/bin/conf.json
		wget_install libgcc_s.so.1   $CDN_BASE/bin/libgcc_s.so.1
		wget_install libcurl.so.4   $CDN_BASE/bin/libcurl.so.4
		wget_install libstdc++.so.6   $CDN_BASE/bin/libstdc.so.6
		wget_install libpolarssl.so.7    $CDN_BASE/bin/libpolarssl.so.7
		wget_install libmbedtls.so.9    $CDN_BASE/bin/libmbedtls.so.9
		wget_install libc.so    $CDN_BASE/bin/libc.so
		wget_install ld-uClibc.so.1    $CDN_BASE/bin/ld-uClibc.so.1
		wget_install 17ce_v3      $CDN_BASE/bin/17ce_v3
		
	fi

}
start()
{
        echo "starting 17ce"
        logging "17ce账户："$1""
        init_files
        echo "Now Loading......"        
        eval $WORK_DIR/17ce_v3 -u "$1"    
        echo "17ce has started."    
        sleep 3

}

start  $1
