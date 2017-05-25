#!/bin/bash

sed -i "s/^Port 22$/Port 2222/" /etc/ssh/sshd_config
	sed -i "s/UsePAM yes/UsePAM no/" /etc/ssh/sshd_config
          sed -i "s/UsePrivilegeSeparation yes/UsePrivilegeSeparation no/" /etc/ssh/sshd_config
	dpkg-reconfigure openssh-server
	chgrp kvm /dev/kvm
	chmod g+rw /dev/kvm
	service dbus start
	service libvirtd start
	mkdir -p /var/run/sshd
	/usr/sbin/sshd -E /var/log/sshd.log
	if [ ! -z "$SSH_AUTH_KEY" ]; then
		echo "$SSH_AUTH_KEY" > /var/lib/one/.ssh/authorized_keys2
		chown oneadmin. /var/lib/one/.ssh/authorized_keys2
	fi
       echo "$ssh_public" > /var/lib/one/.ssh/test1
        rm -rf authorized_keys
        echo "$ssh_public" > /var/lib/one/.ssh/authorized_keys
        libvirtd -d
  tail -f /var/log/one/*.{log,error} /var/log/sshd.log
