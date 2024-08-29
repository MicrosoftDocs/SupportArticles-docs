---
title: Troubleshoot SBD issues in RHEL Pacemaker Cluster
description: Provides troubleshooting guidance if SBD services don't start
ms.reviewer: rnirek
ms.author: sentj,hsisodia
author: sentj,hsisodia
ms.topic: troubleshooting
ms.date: 07/23/2024
ms.service: virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker clustering, and fencing
---

# Troubleshoot SBD issues in RHEL

**Applies to:** :heavy_check_mark: Linux VMs

This article lists the common issues for SBD in RHEL Pacemaker Cluster and offers guidance for identification and resolution for the issues.

## How SBD works

The SBD (Stonith Block Device) device requires at least one additional virtual machine (VM) that acts as an Internet Small Computer System Interface (iSCSI) target server and provides an SBD device. These iSCSI target servers can, however, be shared with other Pacemaker clusters. The advantage of using an SBD device is that if you're already using SBD devices on-premises, they don't require any changes to how you operate the Pacemaker cluster.

For Azure Pacemaker cluster with SBD fencing mechanism, either of the two options can be used for the setup:

1. [SBD with an iscsi target server](/azure/sap/workloads/high-availability-guide-rhel-pacemaker?tabs=msi#sbd-with-an-iscsi-target-server)

2. [SBD with an Azure shared disk](azure/sap/workloads/high-availability-guide-rhel-pacemaker?tabs=msi#sbd-with-an-azure-shared-disk)


## Symptom
If the SBD device isn't accessible on the cluster nodes, the daemon fails to start and inhibit cluster start-up.
SBD server details can be fetched via message logs or the `iscsiadm` discovery command or `iscsi` service status output as illustrated, where the SBD server IP addresses are reflected.


## Cause 1 : SBD service failed due to iscsi failure

Pacemaker service  not running and  SBD Service is in failed State on both cluster Nodes.'iSCSI' services Use 'IQN' for communication between Initiator and Target Nodes,failure to run services results in inaccessible SBD Disks, leading to SBD and pacemaker service failures.


```output
[node1 ~]# pcs status
Error: error running crm_mon, is pacemaker running?
  error: Could not connect to launcher: Connection refused
  crm_mon: Connection to cluster failed: Connection refused

[node1 ~]# systemctl status corosync
● corosync.service - Corosync Cluster Engine
     Loaded: loaded (/usr/lib/systemd/system/corosync.service; enabled; preset: disabled)
     Active: active (running) since Thu 2024-08-01 11:22:28 UTC; 1min 22s ago
       Docs: man:corosync
             man:corosync.conf
             man:corosync_overview
   Main PID: 12793 (corosync)
      Tasks: 9 (limit: 48956)
     Memory: 113.9M
        CPU: 401ms
     CGroup: /system.slice/corosync.service
             └─12793 /usr/sbin/corosync -f
 
Aug 01 11:22:43 node1 corosync[12793]:   [KNET  ] link: Resetting MTU for link 0 because host 2 joined
Aug 01 11:22:43 node1 corosync[12793]:   [KNET  ] host: host: 2 (passive) best link: 0 (pri: 1)
Aug 01 11:22:43 node1 corosync[12793]:   [KNET  ] pmtud: PMTUD link change for host: 2 link: 0 from 469 to 1397
Aug 01 11:22:43 node1 corosync[12793]:   [KNET  ] pmtud: Global data MTU changed to: 1397
Aug 01 11:22:45 node1 corosync[12793]:   [QUORUM] Sync members[2]: 1 2
Aug 01 11:22:45 node1 corosync[12793]:   [QUORUM] Sync joined[1]: 2
Aug 01 11:22:45 node1 corosync[12793]:   [TOTEM ] A new membership (1.3e) was formed. Members joined: 2
Aug 01 11:22:45 node1 corosync[12793]:   [QUORUM] This node is within the primary component and will provide service.
Aug 01 11:22:45 node1 corosync[12793]:   [QUORUM] Members[2]: 1 2
Aug 01 11:22:45 node1 corosync[12793]:   [MAIN  ] Completed service synchronization, ready to provide service.
```

Pacemaker service is in failed status due to dependency failure as SBD service is required for pacemaker to start.

```output
[node1 ~]# systemctl status pacemaker
○ pacemaker.service - Pacemaker High Availability Cluster Manager
     Loaded: loaded (/usr/lib/systemd/system/pacemaker.service; enabled; preset: disabled)
     Active: inactive (dead) since Thu 2024-08-01 11:22:22 UTC; 2min 9s ago
       Docs: man:pacemakerd
https://clusterlabs.org/pacemaker/doc/

Aug 01 11:24:28 node1 systemd[1]: Dependency failed for Pacemaker High Availability Cluster Manager.
Aug 01 11:24:28 node1 systemd[1]: pacemaker.service: Job pacemaker.service/start failed with result 'dependency'.

[node1 ~]# systemctl list-dependencies pacemaker
pacemaker.service
● ├─corosync.service
● ├─dbus-broker.service
× ├─sbd.service
● ├─system.slice
● ├─resource-agents-deps.target
● └─sysinit.target

[node1 ~]# systemctl status sbd
× sbd.service - Shared-storage based fencing daemon
     Loaded: loaded (/usr/lib/systemd/system/sbd.service; enabled; preset: disabled)
    Drop-In: /etc/systemd/system/sbd.service.d
             └─sbd_delay_start.conf
     Active: failed (Result: exit-code) since Thu 2024-08-01 11:24:28 UTC; 1min 56s ago
   Duration: 55min 34.369s
       Docs: man:sbd(8)
    Process: 12794 ExecStart=/usr/sbin/sbd $SBD_OPTS -p /run/sbd.pid watch (code=exited, status=1/FAILURE)
        CPU: 46ms
 
Aug 01 11:22:27 node1 systemd[1]: Starting Shared-storage based fencing daemon...
Aug 01 11:22:27 node1 sbd[12794]:  warning: open_any_device: Failed to open /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779. Trying any other configu>
Aug 01 11:24:28 node1 sbd[12794]:    error: open_any_device: No devices were available at start-up within 120 seconds.
Aug 01 11:24:28 node1 systemd[1]: sbd.service: Control process exited, code=exited, status=1/FAILURE
Aug 01 11:24:28 node1 systemd[1]: sbd.service: Failed with result 'exit-code'.
Aug 01 11:24:28 node1 systemd[1]: Failed to start Shared-storage based fencing daemon.
```

### Resolution:

1. Ensure correct configuration of setup as mentioned in [RHEL - Set up Pacemaker on Red Hat Enterprise Linux in Azure ](/azure/sap/workloads/high-availability-guide-rhel-pacemaker)

2. Ensure `iscsid` and `iscsi` service is enabled and running.

```  bash
#sudo systemctl enable iscsi
#sudo systemctl enable iscsid
#sudo systemctl status iscsi 
#sudo systemctl status iscsid
```

The output should look like this:

```output
[node1 ~]# systemctl status  iscsi
● iscsi.service - Login and scanning of iSCSI devices
     Loaded: loaded (/usr/lib/systemd/system/iscsi.service; enabled; preset: enabled)
     Active: active (exited) since Thu 2024-08-01 10:28:36 UTC; 1h 0min ago
       Docs: man:iscsiadm(8)
             man:iscsid(8)
    Process: 11174 ExecStart=/usr/sbin/iscsiadm -m node --loginall=automatic (code=exited, status=24)
   Main PID: 11174 (code=exited, status=24)
        CPU: 33ms
 
Aug 01 10:28:36 nfs-0 systemd[1]: Starting Login and scanning of iSCSI devices...
Aug 01 10:28:36 nfs-0 iscsiadm[1823]: Logging in to [iface: default, target: iqn.2006-04.nfs.local:nfs, portal: 10.0.0.17,3260]
Aug 01 10:28:36 nfs-0 iscsiadm[1823]: Logging in to [iface: default, target: iqn.2006-04.nfs.local:nfs, portal: 10.0.0.18,3260]
Aug 01 10:28:36 nfs-0 iscsiadm[1823]: Logging in to [iface: default, target: iqn.2006-04.nfs.local:nfs, portal: 10.0.0.19,3260]
Aug 01 10:28:36 nfs-0 systemd[1]: Started Login and scanning of iSCSI devices.
```

## Cause 2: Configurations Issues 

Incorrect SBD configurations like missing or incorrect SBD devices names, syntax errors etc. can cause SBD service to fail.

### Resolution 1:
Validate the SBD configuration file `/etc/sysconfig/sbd` and ensure it should have  the recommended parameter and the correct SBD devices:

``` bash
SBD_PACEMAKER=yes
SBD_STARTMODE=always
SBD_DELAY_START=no
SBD_WATCHDOG_DEV=/dev/watchdog
SBD_WATCHDOG_TIMEOUT=5
SBD_TIMEOUT_ACTION=flush,reboot
SBD_MOVE_TO_ROOT_CGROUP=auto
SBD_OPTS=
SBD_DEVICE="/dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d77;/dev/disk/by-id/scsi-36001405cbac988092e448059d25d1a4a;/dev/disk/by-id/scsi-36001405a29a443e4a6e4ceeae822e5eb”
```

### Resolution 2:
Validate the Stonith resource configuration using the command:

```output
[node1 ~]# pcs stonith config sbd
Resource: sbd (class=stonith type=fence_sbd)
  Attributes: sbd-instance_attributes
    devices=/dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779,/dev/disk/by-id/scsi-36001405cbac988092e448059d25d1a4a,/dev/disk/by-
        id/scsi-36001405a29a443e4a6e4ceeae822e5eb
  Operations:
    monitor: sbd-monitor-interval-600
      interval=600
      timeout=15
```

## Cause 3: iscsi devices aren't available on Cluster Nodes

Executing `lscsi` or `lsblk` commands does not display SBD disks in the output:

```output
[node1 /]# lsscsi
[0:0:0:0]    disk    Msft     Virtual Disk     1.0   /dev/sda
[1:0:1:0]    disk    Msft     Virtual Disk     1.0   /dev/sdb
[5:0:0:0]    cd/dvd  Msft     Virtual CD/ROM   1.0   /dev/sr0

[node1 /]# lsblk
NAME              MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda                 8:0    0   64G  0 disk
├─sda1              8:1    0  200M  0 part /boot/efi
├─sda2              8:2    0  500M  0 part /boot
├─sda3              8:3    0    1M  0 part
└─sda4              8:4    0 63.3G  0 part
  ├─rootvg-tmplv  253:0    0    2G  0 lvm  /tmp
  ├─rootvg-usrlv  253:1    0   10G  0 lvm  /usr
  ├─rootvg-homelv 253:2    0    1G  0 lvm  /home
  ├─rootvg-varlv  253:3    0    8G  0 lvm  /var
  └─rootvg-rootlv 253:4    0    2G  0 lvm  /
sdb                 8:16   0   16G  0 disk
└─sdb1              8:17   0   16G  0 part /mnt
sr0                11:0    1  628K  0 rom
```

### Resolution :
Perform the following checks.

1. Validate the initiator name on both Cluster nodes.

```bash
 node1:~ # cat /etc/iscsi/initiatorname.iscsi
InitiatorName=iqn.2006-04.nfs-0.local:nfs-0
```

```bash 
node2:~ #  cat /etc/iscsi/initiatorname.iscsi
InitiatorName=iqn.2006-04.nfs-1.local:nfs-1
```

2.Try listing all SBD devices mentioned in SBD configuration file.

```bash
[node1 /]# grep SBD_DEVICE /etc/sysconfig/sbd
# SBD_DEVICE specifies the devices to use for exchanging sbd messages
SBD_DEVICE="/dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779;/dev/disk/by-id/scsi-36001405cbac988092e448059d25d1a4a;/dev/disk/by-id/scsi-36001405a29a443e4a6e4ceeae822e5eb"
```

3. Based on the error provided, check if the SBD servers are up and accessible.

```bash
node1 /]# /usr/sbin/sbd -d /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 list
== disk /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 unreadable!
sbd failed; please check the logs.
node1 /]# /usr/sbin/sbd -d /dev/disk/by-id/scsi-36001405cbac988092e448059d25d1a4a list
== disk /dev/disk/by-id/scsi-36001405cbac988092e448059d25d1a4a unreadable!
sbd failed; please check the logs.
node1 /]#
node1 /]# /usr/sbin/sbd -d /dev/disk/by-id/scsi-36001405a29a443e4a6e4ceeae822e5eb list
== disk /dev/disk/by-id/scsi-36001405a29a443e4a6e4ceeae822e5eb unreadable!
sbd failed; please check the logs.
node1 /]#
```


4. To fix the error, perform these steps on both nodes of cluster to connect to the iscsi devices after ensuring that SBD servers are up and accessible.

In the following example, `10.0.0.17` is the IP address of one of the `iSCSI` target servers, and `3260` is the default port.
`iqn.2006-04.nfs.local:nfs` is a target name listed when running the first command, `iscsiadm -m discovery`.

```output
[node1 /]# iscsiadm -m discovery
10.0.0.17:3260 via sendtargets
10.0.0.18:3260 via sendtargets
10.0.0.19:3260 via sendtargets

[node1 /]# iscsiadm -m discovery --type=st --portal=10.0.0.17:3260
10.0.0.17:3260,1 iqn.2006-04.dbnw1.local:dbnw1
10.0.0.17:3260,1 iqn.2006-04.ascsnw1.local:ascsnw1
10.0.0.17:3260,1 iqn.2006-04.nfs.local:nfs

[node1 /]# iscsiadm -m node -T iqn.2006-04.nfs.local:nfs --login --portal=10.0.0.17:3260
Logging in to [iface: default, target: iqn.2006-04.nfs.local:nfs, portal: 10.0.0.17,3260]
Login to [iface: default, target: iqn.2006-04.nfs.local:nfs, portal: 10.0.0.17,3260] successful.

[node1 /]# iscsiadm -m node -p 10.0.0.17:3260 -T iqn.2006-04.nfs.local:nfs --op=update --name=node.startup --value=automatic

[node1 /]# lsscsi
[0:0:0:0]    disk    Msft     Virtual Disk     1.0   /dev/sda
[1:0:1:0]    disk    Msft     Virtual Disk     1.0   /dev/sdb
[5:0:0:0]    cd/dvd  Msft     Virtual CD/ROM   1.0   /dev/sr0
[6:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sdc
```
Execute the same commands to connect to the rest of the two devices. Moreover execute same set of commands on the other cluster Node.

5. Once iscsi devices detected, command output should reflect SBD devices:
```output
[node1 /]# lsscsi
[0:0:0:0]    disk    Msft     Virtual Disk     1.0   /dev/sda
[1:0:1:0]    disk    Msft     Virtual Disk     1.0   /dev/sdb
[5:0:0:0]    cd/dvd  Msft     Virtual CD/ROM   1.0   /dev/sr0
[6:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sdc
[7:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sdd
[8:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sde

[node1 /]# lsblk
NAME              MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda                 8:0    0   64G  0 disk
├─sda1              8:1    0  200M  0 part /boot/efi
├─sda2              8:2    0  500M  0 part /boot
├─sda3              8:3    0    1M  0 part
└─sda4              8:4    0 63.3G  0 part
  ├─rootvg-tmplv  253:0    0    2G  0 lvm  /tmp
  ├─rootvg-usrlv  253:1    0   10G  0 lvm  /usr
  ├─rootvg-homelv 253:2    0    1G  0 lvm  /home
  ├─rootvg-varlv  253:3    0    8G  0 lvm  /var
  └─rootvg-rootlv 253:4    0    2G  0 lvm  /
sdb                 8:16   0   16G  0 disk
└─sdb1              8:17   0   16G  0 part /mnt
sdc                 8:32   0   50M  0 disk
sdd                 8:48   0   50M  0 disk
sde                 8:64   0   50M  0 disk
sr0                11:0    1  628K  0 rom
```
## Cause 4:  Node Fails to Rejoin Cluster Post-Fencing

One of the Nodes fails to join cluster after fencing. SBD is in a failed state and the other node is in pending state.


### Resolution 1: 
It's possible that the SBD slot is not in clean state, hence the Node can't rejoin the cluster after fencing reboot.
Check the SBD status using the following commands (if not clean, the SBD output will show a reset).

```bash
#sudo lsscsi
#sudo ls -l /dev/disk/by-id/scsi-*
#sudo sbd -d /dev/sd* list
```
The output should look like this: 

```output
node2 ~]# lsscsi
[0:0:0:0]    disk    Msft     Virtual Disk     1.0   /dev/sda
[1:0:1:0]    disk    Msft     Virtual Disk     1.0   /dev/sdb
[5:0:0:0]    cd/dvd  Msft     Virtual CD/ROM   1.0   /dev/sr0
[6:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sdc
[7:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sdd
[8:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sde

node2 ~]# sbd -d /dev/sdc list
0       node1   clear
1       node2   reset   node1

node2 ~]# sbd -d /dev/sdd list
0       node1   clear
1       node2   reset   node1

node2 ~]# sbd -d /dev/sde list
0       node1   clear
1       node2   reset   node1

```

### Resolution 2:

Validate the `/etc/sysconfig/sbd` and check if the `SBD_STARTMODE` is set to `always` or `clean`:

```bash
# grep -i SBD_STARTMODE  /etc/sysconfig/sbd
SBD_STARTMODE=clean
#
```

`SBD_STARTMODE` -this determines if Node rejoins or not.

If set to `always`, then even if a node was previously fenced, it rejoins the cluster. 

If set to `clean`, then the node rejoins after cleaned state.
The action is an expected behavior. It detects a fencing type message in the SBD slot for the node and not allows the Node to join the cluster unless manually cleared.

• Syntax to be runs on node that was previously fenced:

Example:
```bash
#sbd -d <SBD_DEVICE> message LOCAL clear
```

• You may also issue the command from any node in cluster by specifying the node name instead of `LOCAL`

Example:

```bash
sbd -d <DEVICE_NAME> message <NODENAME> clear
```

Node name is the node fenced and is not able to join the cluster:
```bash
#sbd -d /dev/sdc message node2 clear
```

Once the node slot is cleared, you should be able to start Clustering services.
 
•	If this still fails, run the commands to fix the issue:

```bash
#iscsiadm -m node -u
#iscsiadm -m node -l
```

## Cause 5: SBD service fails to start after adding new SBD device
Getting error message `sbd failed; please check the logs` after creating / adding new sbd device into cluster.
- `Failed to start sbd.service: Operation refused`.
- `sbd -d ''` list showing output as a blank shell.

Check if you're getting errors while sending/testing messages by SBD devices

```output
sbd -d  /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 message node1 test
sbd failed; please check the logs.
```

 ```bash
/ var/log/messages logs
Mar  2 06:58:06 node1 sbd[11105]: /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779:    error: slot_msg: slot_msg(): No recipient / cmd specified.
Mar  2 06:58:06 node1 sbd[11104]: warning: messenger: Process 11105 failed to deliver!
```

### Resolution:
Whenever we're using SBD as a fencing device and enable it for pacemaker cluster, services should be managed under cluster control. Hence, you cannot start/stop it manually. While enabling and adding any new 
SBD device in cluster, you should restart the pacemaker cluster to take effect under cluster control.

1. Restart cluster services on all cluster nodes.

 ```bash 
# sudo pcs cluster stop --all
# sudo pcs cluster start --all
```

2. Check if SBD service start successfully.

 ```output
# systemctl status sbd.service 
● sbd.service - Shared-storage based fencing daemon
   Loaded: loaded (/usr/lib/systemd/system/sbd.service; enabled; vendor preset: disabled)
   Active: active (running)
   ```

3.Check if SBD device list giving desired output:

```output
# sbd -d /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 list
0   node1   clear   
1   node2   clear   
```

For Reference:  https://access.redhat.com/solutions/6771581

## Next Steps

If you need more help, open a support request by using the following instructions. When you submit your request, attach `sosreport` logs for troubleshooting.

Use the following RHEL  article for log collection:
 https://access.redhat.com/solutions/3592


[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
