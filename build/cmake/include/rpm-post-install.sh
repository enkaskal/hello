#!/bin/bash
echo "/usr/lib" > /etc/ld.so.conf.d/hello.conf
ldconfig
