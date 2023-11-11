Port of OpenBSD's file(1) to Linux.

This is based on: https://github.com/brynet/file.

Installation
------------
This project makes no attempt at coexisting with other file(1) implementations.
Take note before installing system wide.

	% make
	% make install
	% useradd -r -s /usr/sbin/nologin _file
	% install -b -c -o root -g root -m 444 ./magic /etc/magic
