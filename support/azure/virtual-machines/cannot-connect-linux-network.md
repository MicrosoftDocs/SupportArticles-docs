---
title: Can't connect to Azure Linux VM through network
description: Describes network errors on Azure Linux virtual machines that are logged in serial logs. These errors prevent you from connecting to the VMs. A resolution is provided.
ms.date: 07/21/2020
author: genlin
ms.author: genli
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.custom: linux-related-content
ms.collection: linux
ms.reviewer: 
---
# Can't connect to Azure Linux VM through network

This article fixes an issue in which network errors prevent you from connecting to Azure Linux virtual machines.

_Original product version:_ &nbsp; Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4010059

## Symptoms

The primary interface on an Azure Linux virtual machine (VM) is eth0. If eth0 isn't configured, the VM is not accessible over a network connection even when other tools indicate the VM is up.

When the issue occurs, the Secure Shell (SSH) connection that has correct permissions may start to connect to the VM. However, it ultimately cannot access the VM because of the network issue.

The networking errors are typically logged in the serial console log. Specifically, you may see the following errors.  

## Errors in the serial console log  

### CentOS Linux distribution errors  

#### Error 1

```
Bringing up interface eth0:
Device eth0 does not seem to be present, delaying initialization.
[FAILED]

```

#### Error 2

```
Bringing up loopback interface: [ OK ]
Bringing up interface eth0: Device eth0 has different MAC address than expected, ignoring.
[FAILED]

```

#### Error 3

```
YYYY/MM/DD HH:MM:SS Discovered Windows Azure endpoint: ###.##.###.##
/usr/sbin/waagent:2275: DeprecationWarning: BaseException.message has been deprecated as of Python 2.6
Error('socket IOError ' + e.message + ' args: ' + repr(e.args))
YYYY/MM/DD HH:MM:SS ERROR:socket IOError args: (113, 'No route to host')

YYYY/MM/DD HH:MM:SS ERROR:socket IOError args: (113, 'No route to host')
Failed services in runlevel 3:network

```

#### Error 4

```
login: YYYY/MM/DD HH:MM:SS ERROR:timed out

YYYY/MM/DD HH:MM:SS ERROR:Traceback (most recent call last):
YYYY/MM/DD HH:MM:SS ERROR: File "/usr/sbin/waagent", line 3395, in DoDhcpWork
YYYY/MM/DD HH:MM:SS ERROR: receiveBuffer = sock.recv(1024)
YYYY/MM/DD HH:MM:SS ERROR:timeout: timed out
YYYY/MM/DD HH:MM:SS ERROR:
YYYY/MM/DD HH:MM:SS DoDhcpWork: Setting socket.timeout=10, entering recv
YYYY/MM/DD HH:MM:SS ERROR:timed out
YYYY/MM/DD HH:MM:SS ERROR:Traceback (most recent call last):
YYYY/MM/DD HH:MM:SS ERROR: File "/usr/sbin/waagent", line 3395, in DoDhcpWork
YYYY/MM/DD HH:MM:SS ERROR: receiveBuffer = sock.recv(1024)
YYYY/MM/DD HH:MM:SS ERROR:timeout: timed out

Customer changed the IP from DHCP to FIXED

```  

### SUSE Linux distribution errors  

```
Setting up (localfs) network interfaces:
 lo 
 lo IP address: 127.0.0.1/8 
 IP address: 127.0.0.2/8 
done eth4 
 No configuration found for eth4
unused Waiting for mandatory devices: eth0 
29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0 

eth0 No interface found

```

### Ubuntu  

#### Error 1

```
cloud-init-nonet waiting 120 seconds for a network device.
cloud-init-nonet gave up waiting for a network device.
ci-info: lo : 1 127.0.0.1 255.0.0.0 .
ci-info: eth1 : 0 . . 00:0d:3a:10:6a:53
route_info failed
Waiting for network configuration...
Waiting up to 60 more seconds for network configuration...
Booting system without full network configuration...

```  

#### Error 2

```
ci-info: | eth0 | False | . | . | 00:0d:3a:21:f9:ad |
ci-info: +--------+-------+-----------+-----------+-------------------+
ci-info: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Route info failed!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
+ i=eth0
+ x=0
+ ifdown eth0
ifdown: interface eth0 not configured
+ ifup eth0
Missing required variable: address
Missing required configuration variables for interface eth0/inet.
Failed to bring up eth0.
+ exit 0x\

```

## Resolution  

### For CentOS

Remove the **HWADDR** directive from the **ifcfg-eth0** file under `/etc/sysconfig/network-script`.  

### For SUSE Linux

Remove the files that contain entries for eth0 or eth1 under `/etc/udev/rules.d`.  

### For Ubuntu  

#### Error 1

This error indicates that the aneth1 interface is configured instead of eth0. This may occur if the operating system on the VM does not have some updates for _udev_ installed. In this situation, *udev* incorrectly saves the previous network interface. When the VM is resized or moved, it receives a different MAC address, which will be assigned to eth1.

> [!NOTE]
> You can verify the version of the image from the serial logs. If a very old Ubuntu kernel (for example 3.2.0-58.88, released in January 2014) is found, this indicates that the operating system has not been updated.

To resolve this issue, attach the OS disk to another running VM, and then delete the udev rule file under `/etc/udev/rules.d/70-persistent-net.rules`.

To avoid this issue in the future, we recommend that you update the udev package on the VM. For example, run the following command:

```bash
sudo apt-get update
sudo apt-get install udev
```

#### Error 2

To resolve this issue, reset the `/etc/network/interfaces.d/eth0.cfg` file to the default, and make it request the Azure DHCP to obtain an IP address. Then, remove the files in the `/var/lib/dhcp` folder that contain cached DHCP settings. The following is an example of the default eth0.cfg file:

```bash
# The primary network interface
auto eth0
iface eth0 inet dhcp
```

## Resolve the issue on a customized Linux operating system

If the VM that has the networking issue uses your uploaded VHD, you can try to configure the network based on a working gallery image. To do this, attach the problematic disk as a data disk to the gallery VM, and then run the following commands.  

```bash
fdisk -l
df -h
mount /dev/sdc1 /temporary
df -h
cd /temporary/etc/udev/rules.d
ls -ltr
mv 70-persistent-net.rules /temporary/root/
cd ../../network

ls
mv interfaces interfaces.org
ls -ltr
```

Copy to the current folder files from the working VM:

```bash
cp /etc/network/interfaces . 
cp -R /etc/network/interfaces
cp -R /etc/network/interfaces.d .
cp -R /etc/network/interfaces.dynamic.d .
ls -ltr
cd ..
cd
umount /mnt
```

For more information about how to attach a data disk to the gallery VM, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).

## Reference: network files for operating systems  

### Network card configuration

```
/etc/sysconfig/network-scripts/ifcfg-eth0 ..ifcfg-eth0:1 (Centos, Oracle)
/etc/sysconfig/network/ifcfg-eth0 (SuSE)
/etc/network/interfaces (Ubuntu)  
```

### Hostname configuration

```
/etc/sysconfig/network (Centos , Oracle)
/etc/HOSTNAME (SuSE)
/etc/hostname (Ubuntu)  
```

### DNS configuration files

```
/etc/resolv.conf
/etc/nsswitch.conf  
```

### Configuration files for default gateway

```
set in ifcfg-ethn or /etc/sysconfig/network
/etc/sysconfig/network/route (SuSE)
/etc/network/interfaces (Ubuntu)  
```

### Static routes

```
/etc/sysconfig/network-scripts/route-ethX (Centos, Oracle)
/etc/sysconfig/network/routes (SuSE)
/etc/network/interfaces (Ubuntu)  
```

### Firewall rules

```
/etc/sysconfig/iptables (centos, Oracle)
/etc/sysconfig/SuSEfirewall2.d/services (SuSE)
/etc/ufw/ufw.conf (Ubuntu)
```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
