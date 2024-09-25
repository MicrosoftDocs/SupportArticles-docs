---
title: Troubleshoot SBD issues in SUSE Pacemaker Cluster
description: Provides troubleshooting guidance if SBD services fail
ms.reviewer: rnirek
reviwer: rnirek
ms.author: jsenthil
author: rnirek
ms.topic: troubleshooting
ms.date: 09/24/2024
ms.service: azure-virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker clustering, and fencing
---

# Troubleshoot SBD issues in SUSE

**Applies to:** :heavy_check_mark: Linux VMs

This article lists the common issues for SBD in SLES Pacemaker Cluster and offers guidance for identification and resolution for the issues.

## How SBD works

The SBD (Stonith Block Device) device requires at least one more virtual machine (VM) that acts as an Internet Small Computer System Interface (iSCSI) target server and provides an SBD device. These iSCSI target servers can, however, be shared with other Pacemaker clusters. The advantage of using an SBD device is that if you're already using SBD devices on-premises, they don't require any changes to how you operate the Pacemaker cluster.

For Azure Pacemaker cluster with SBD fencing mechanism, either of the two options can be used for the setup. For more information on the two mechanisms, see:

1. [SBD with an iscsi target server](/azure/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#sbd-with-an-iscsi-target-server)

2. [SBD with an Azure shared disk](/azure/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#sbd-with-an-azure-shared-disk)

## How to diagnose the issue
If the SBD device isn't accessible on the cluster nodes, the daemon fails to start and inhibit cluster start-up.
SBD server details can be fetched via message logs or the `iscsiadm` discovery command or `iscsi` service status output as illustrated, where the SBD server IP addresses are reflected.

## Cause 1 : SBD service failed due to iscsi failure

Pacemaker service  not running and  SBD Service is in failed State on both cluster Nodes. 'iSCSI' services Use "IQN" for communication between Initiator and Target Nodes,failure to run services results in inaccessible SBD Disks, leading to SBD and pacemaker service failures.

```bash
sudo crm status
```
```output
ERROR: status: crm_mon (rc=102): Error: cluster is not available on this node
```
```bash
sudo systemctl status corosync
```
```output
corosync.service - Corosync Cluster Engine
  Loaded: loaded (/usr/lib/systemd/system/corosync.service; disabled; vendor preset: disabled)
  Active: active (running) since Thu 2024-08-01 04:49:15 UTC; 38s ago
 Process: 23972 ExecStop=/usr/share/corosync/corosync stop (code=exited, status=0/SUCCESS)
 Process: 24075 ExecStart=/usr/share/corosync/corosync start (code=exited, status=0/SUCCESS)
Main PID: 24094 (corosync)
   Tasks: 2 (limit: 4096)
  CGroup: /system.slice/corosync.service
          └─24094 corosync
 
Aug 01 04:49:15 nfs-0 corosync[24094]:   [TOTEM ] A new membership (10.0.0.6:32) was formed. Members joined: 2
Aug 01 04:49:15 nfs-0 corosync[24094]:   [CPG  ] downlist left_list: 0 received in state 2
Aug 01 04:49:15 nfs-0 corosync[24094]:   [VOTEQ ] Waiting for all cluster members. Current votes: 1 expected_votes: 2
Aug 01 04:49:15 nfs-0 corosync[24094]:   [QUORUM] This node is within the primary component and will provide service.
Aug 01 04:49:15 nfs-0 corosync[24094]:   [QUORUM] Members[2]: 1 2
Aug 01 04:49:15 nfs-0 corosync[24094]:   [MAIN ] Completed service synchronization, ready to provide service.
Aug 01 04:49:15 nfs-0 corosync[24075]: Starting Corosync Cluster Engine (corosync): [ OK ]
```
* Pacemaker service is in failed status due to dependency failure as SBD service is required for pacemaker to start.

```bash
sudo systemctl status pacemaker
```
```output
pacemaker.service - Pacemaker High Availability Cluster Manager
   Loaded: loaded (/usr/lib/systemd/system/pacemaker.service; enabled; vendor preset: disabled)
   Active: inactive (dead) since Thu 2024-08-01 04:56:39 UTC; 2min 39s ago
     Docs: man:pacemakerd
https://clusterlabs.org/pacemaker/doc/en-US/Pacemaker/1.1/html-single/Pacemaker_Explained/index.html

Aug 01 04:59:07 nfs-0 systemd[1]: Dependency failed for Pacemaker High Availability Cluster Manager.
Aug 01 04:59:07 nfs-0 systemd[1]: pacemaker.service: Job pacemaker.service/start failed with result 'dependency'.
```
```bash
sudo  systemctl list-dependencies pacemaker
```
```output
pacemaker.service
● ├─corosync.service
● ├─dbus.service
● ├─sbd.service
● ├─system.slice
● ├─resource-agents-deps.target
● └─sysinit.target
```
```bash
sudo systemctl status sbd
```
```output
● sbd.service - Shared-storage based fencing daemon
   Loaded: loaded (/usr/lib/systemd/system/sbd.service; enabled; vendor preset: disabled)
   Active: failed (Result: timeout) since Thu 2024-08-01 04:59:07 UTC; 3min 3s ago
     Docs: man:sbd(8)
  Process: 25251 ExecStart=/usr/sbin/sbd $SBD_OPTS -p //run/sbd.pid watch (code=killed, signal=TERM)
 
Aug 01 04:57:37 nfs-0 systemd[1]: Starting Shared-storage based fencing daemon...
Aug 01 04:57:37 nfs-0 sbd[25251]:  warning: open_any_device: Failed to open /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779. Trying any o...ithin 120s
Aug 01 04:59:07 nfs-0 systemd[1]: sbd.service: Start operation timed out. Terminating.
Aug 01 04:59:07 nfs-0 systemd[1]: Failed to start Shared-storage based fencing daemon.
Aug 01 04:59:07 nfs-0 systemd[1]: sbd.service: Unit entered failed state.
Aug 01 04:59:07 nfs-0 systemd[1]: sbd.service: Failed with result 'timeout'.
```
### Resolution

1. Ensure correct configuration of setup as mentioned in [SUSE - set up Pacemaker on SUSE Linux Enterprise Server in Azure ](/azure/sap/workloads/high-availability-guide-suse-pacemaker).

2. Ensure `iscsid` and `iscsi` service is enabled and running.

```  bash
sudo systemctl enable iscsi
```
```bash
sudo systemctl enable iscsid
```
```bash
sudo systemctl status iscsi 
```
```bash
sudo systemctl status iscsid
```
* The output should look like this:

```bash
sudo systemctl status  iscsi
```
```output
iscsi.service - Login and scanning of iSCSI devices
   Loaded: loaded (/usr/lib/systemd/system/iscsi.service; enabled; vendor preset: enabled)
   Active: active (exited) since Thu 2024-08-01 04:18:51 UTC; 31min ago
     Docs: man:iscsiadm(8)
           man:iscsid(8)
Main PID: 1823 (code=exited, status=0/SUCCESS)
    Tasks: 0 (limit: 4096)
   CGroup: /system.slice/iscsi.service
 
Aug 01 04:18:51 nfs-0 systemd[1]: Starting Login and scanning of iSCSI devices...
Aug 01 04:18:51 nfs-0 iscsiadm[1823]: Logging in to [iface: default, target: iqn.2006-04.nfs.local:nfs, portal: 10.0.0.17,3260]
Aug 01 04:18:51 nfs-0 iscsiadm[1823]: Logging in to [iface: default, target: iqn.2006-04.nfs.local:nfs, portal: 10.0.0.18,3260]
Aug 01 04:18:51 nfs-0 iscsiadm[1823]: Logging in to [iface: default, target: iqn.2006-04.nfs.local:nfs, portal: 10.0.0.19,3260]
Aug 01 04:18:51 nfs-0 systemd[1]: Started Login and scanning of iSCSI devices.
```
## Cause 2: Configurations Issues 

Incorrect SBD configurations like missing or incorrect SBD devices names, syntax errors etc. can cause SBD service to fail.

### Resolution 1
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
SBD_DEVICE="/dev/disk/by-id/scsi-xxxxxxxxxxxxxxxxxx;/dev/disk/by-id/scsi-xxxxxxxxxxxxxxxxx;/dev/disk/by-id/scsi-xxxxxxxxxxxxxxxxxx”
```
### Resolution 2
Validate the Stonith resource configuration using the command:

```bash
sudo crm configure show
```
```output
primitive stonith-sbd stonith:external/sbd \
params pcmk_delay_max=30s \
op monitor interval="600" timeout="15"
stonith-enabled=true \
stonith-timeout=144 \
```
## Cause 3: iscsi devices aren't available on Cluster Nodes

Executing `lscsi` or `lsblk` commands doesn't display SBD disks in the output:

```bash
sudo lsscsi
```
```output
[0:0:0:0]    disk    Msft    Virtual Disk     1.0   /dev/sda
[0:0:0:1]    disk    Msft    Virtual Disk     1.0   /dev/sdb
[1:0:0:0]    disk    Msft    Virtual Disk     1.0   /dev/sdc
[1:0:0:1]    disk    Msft    Virtual Disk     1.0   /dev/sdd
```
```bash
sudo lsblk
```
```output
NAME                MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                   8:0    0  100G  0 disk
├─sda1                 8:1    0   2M  0 part
├─sda2                 8:2    0 512M  0 part /boot/efi
├─sda3                 8:3    0   1G  0 part /boot
└─sda4                8:4    0 98.5G  0 part /
sdb                   8:16   0   14G  0 disk
└─sdb1                8:17   0   14G  0 part /mnt
sdc                   8:32   0  100G  0 disk
└─sdc1                8:33   0  100G  0 part
 └─vg--NW1--NFS-NW1 254:0    0  100G  0 lvm
sdd                   8:48   0  100G  0 disk
└─sdd1                8:49   0  100G  0 part
 └─vg--NW2--NFS-NW2 254:1    0  100G  0 lvm
```
### Resolution :
Perform the following checks:

1. Validate the initiator name on both Cluster nodes.

```bash
sudo cat /etc/iscsi/initiatorname.iscsi
```
```output
InitiatorName=iqn.2006-04.nfs-0.local:nfs-0
```
```bash
sudo cat /etc/iscsi/initiatorname.iscsi
```
```output
InitiatorName=iqn.2006-04.nfs-1.local:nfs-1
```
2. Try listing all SBD devices mentioned in SBD configuration file.

```bash
sudo grep SBD_DEVICE /etc/sysconfig/sbd
```
```output
# SBD_DEVICE specifies the devices to use for exchanging sbd messages
SBD_DEVICE="/dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779;/dev/disk/by-id/scsi-36001405cbac988092e448059d25d1a4a;/dev/disk/by-id/scsi-36001405a29a443e4a6e4ceeae822e5eb"
```
3. Based on the error provided, check if the SBD servers are up and accessible.

```bash
sudo /usr/sbin/sbd -d /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 list
```
```output
== disk /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 unreadable!
sbd failed; please check the logs.

```

4. To fix the error, perform these steps on both nodes of cluster to connect to the iscsi devices after ensuring that SBD servers are up and accessible.

`iqn.2006-04.nfs.local:nfs` is a target name listed when running the first command, `iscsiadm -m discovery`.


```bash
sudo iscsiadm -m discovery
```
```output
10.0.0.17:3260 via sendtargets
10.0.0.18:3260 via sendtargets
10.0.0.19:3260 via sendtargets
```
```bash
sudo iscsiadm -m discovery --type=st --portal=10.0.0.17:3260
```
```output
10.0.0.17:3260,1 iqn.2006-04.dbnw1.local:dbnw1
10.0.0.17:3260,1 iqn.2006-04.ascsnw1.local:ascsnw1
10.0.0.17:3260,1 iqn.2006-04.nfs.local:nfs
```
```bash
sudo iscsiadm -m node -T iqn.2006-04.nfs.local:nfs --login --portal=10.0.0.17:3260
```
```output
Logging in to [iface: default, target: iqn.2006-04.nfs.local:nfs, portal: 10.0.0.17,3260]
Login to [iface: default, target: iqn.2006-04.nfs.local:nfs, portal: 10.0.0.17,3260] successful.
```
```bash
sudo iscsiadm -m node -p 10.0.0.17:3260 -T iqn.2006-04.nfs.local:nfs --op=update --name=node.startup --value=automatic
```
```bash
sudo  lsscsi
```
```output
[0:0:0:0]    disk    Msft     Virtual Disk     1.0   /dev/sda
[0:0:0:1]    disk    Msft     Virtual Disk     1.0   /dev/sdb
[1:0:0:0]    disk    Msft     Virtual Disk     1.0   /dev/sdc
[1:0:0:1]    disk    Msft     Virtual Disk     1.0   /dev/sdd
[2:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sde
```
* Execute the same commands to connect to the rest of the two devices. Moreover execute same set of commands on the other cluster Node.

5. Once iscsi devices detected, command output should reflect SBD devices:
```bash
sudo lsscsi
```
```output
[0:0:0:0]    disk    Msft    Virtual Disk     1.0   /dev/sda
[0:0:0:1]    disk    Msft    Virtual Disk     1.0   /dev/sdb
[1:0:0:0]    disk    Msft    Virtual Disk     1.0   /dev/sdc
[1:0:0:1]    disk    Msft    Virtual Disk     1.0   /dev/sdd
[2:0:0:0]    disk    LIO-ORG sbdnfs           4.0   /dev/sde
[3:0:0:0]    disk    LIO-ORG sbdnfs           4.0   /dev/sdf
[4:0:0:0]    disk    LIO-ORG sbdnfs           4.0   /dev/sdg
```
```bash
sudo lsblk
```
```output
NAME                MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                   8:0    0  100G  0 disk
├─sda1                 8:1    0   2M  0 part
├─sda2                 8:2    0 512M  0 part /boot/efi
├─sda3                 8:3    0   1G  0 part /boot
└─sda4                8:4    0 98.5G  0 part /
sdb                   8:16   0   14G  0 disk
└─sdb1                8:17   0   14G  0 part /mnt
sdc                   8:32   0  100G  0 disk
└─sdc1                8:33   0  100G  0 part
 └─vg--NW1--NFS-NW1 254:0    0  100G  0 lvm
sdd                   8:48   0  100G  0 disk
└─sdd1                8:49   0  100G  0 part
 └─vg--NW2--NFS-NW2 254:1    0  100G  0 lvm
sde                   8:64   0   50M  0 disk
sdf                   8:80   0   50M  0 disk
sdg                   8:96   0   50M  0 disk
```
## Cause 4:  Node Fails to Rejoin Cluster Post-Fencing

One of the Nodes fails to join cluster after fencing. SBD is in a failed state and the other node is in pending state.

### Resolution 1
It's possible that the SBD slot isn't in clean state, hence the Node can't rejoin the cluster after fencing reboot.
Check the SBD status using the following commands (if not clean, the SBD output shows a reset).

```bash
sudo lsscsi
```
```output
[0:0:0:0]    disk    Msft    Virtual Disk     1.0   /dev/sda
[0:0:0:1]    disk    Msft    Virtual Disk     1.0   /dev/sdb
[1:0:0:0]    disk    Msft    Virtual Disk     1.0   /dev/sdc
[1:0:0:1]    disk    Msft    Virtual Disk     1.0   /dev/sdd
[2:0:0:0]    disk    LIO-ORG sbdnfs           4.0   /dev/sde
[3:0:0:0]    disk    LIO-ORG sbdnfs           4.0   /dev/sdf
[4:0:0:0]    disk    LIO-ORG sbdnfs           4.0   /dev/sdg
```
```bash
sudo ls -l /dev/disk/by-id/scsi-*
```
```bash
sudo sbd -d /dev/sde list
```
``` output
0       nfs-0   clear
1       nfs-1   reset  nfs-0
```

### Resolution 2:

Validate the `/etc/sysconfig/sbd` and check if the `SBD_STARTMODE` is set to `always` or `clean`:

```bash
sudo grep -i SBD_STARTMODE  /etc/sysconfig/sbd
```
```output
SBD_STARTMODE=clean
```
* `SBD_STARTMODE`  determines if Node rejoins or not.If set to `always`, then even if a node was previously fenced, it rejoins the cluster. If set to `clean`, then the node rejoins after cleaned state.

The action is an expected behavior. It detects a fencing type message in the SBD slot for the node and not allows the Node to join the cluster unless manually cleared.

* Syntaxes to be run on node that was previously fenced:

Example:
```bash
sudo sbd -d <SBD_DEVICE> message LOCAL clear
```
* You may also issue the command from any node in cluster by specifying the node name instead of `LOCAL`

Example:
```bash
sudo sbd -d <DEVICE_NAME> message <NODENAME> clear
```
* Node name is the node fenced and isn't able to join the cluster:
```bash
sudo sbd -d /dev/sde message nfs-1 clear
```

Once the node slot is cleared, you should be able to start Clustering services.
 
* If the service fails again, run the commands to fix the issue:
```bash
sudo iscsiadm -m node -u
```
```bash
sudo iscsiadm -m node -l
```
> [!NOTE]
> Replace `<SBD_DEVICE>`,`<DEVICE_NAME>` and `<NODENAME>` accordingly.

## Cause 5: SBD service fails to start after adding new SBD device
Getting error message `sbd failed; please check the logs` after creating / adding new SBD device into cluster.
- `Failed to start sbd.service: Operation refused`.
- `sbd -d ''` list showing output as a blank shell.

Check if you're getting errors while sending/testing messages by SBD devices.

```bash
sudo sbd -d  /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 message node1 test
```
```output
sbd failed; please check the logs.
```
From /var/log/messages:
 ```output
/var/log/messages 
Mar  2 06:58:06 node1 sbd[11105]: /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779:    error: slot_msg: slot_msg(): No recipient / cmd specified.
Mar  2 06:58:06 node1 sbd[11104]: warning: messenger: Process 11105 failed to deliver!
```

### Resolution
Whenever we're using SBD as a fencing device and enable it for pacemaker cluster, services should be managed under cluster control. Hence, you cannot start/stop it manually. While enabling and adding any new SBD device in cluster, you should restart the pacemaker cluster to take effect under cluster control.

1. Restart cluster services on all cluster nodes.

 ```bash 
sudo crm cluster stop 
```
```bash
sudo crm cluster start
```
2.Check if SBD service start successfully.

 ```bash
sudo systemctl status sbd.service 
```
```output
● sbd.service - Shared-storage based fencing daemon
   Loaded: loaded (/usr/lib/systemd/system/sbd.service; enabled; vendor preset: disabled)
   Active: active (running)
```
3.Check if SBD device list giving desired output:

 ```bash 
sudo sbd -d /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 list
```
```output
0   node1   clear   
1   node2   clear   
```
 ## Cause 6: SBD fails to start after SLES 12 to SLES 15 upgrade
 After update or upgrade of a SLES 12 system to SLES 15, iSCSI client information may not be present, causing a failure to connect to remote filesystems over iSCSI.

 ### Resoultion
In SLES 15, the deprecated targetcli-fb package was replaced with python3-targetcli-fb or python2-targetcli-fb, resetting systemd service to default (disabled/stopped), requiring manual re-enabling and starting of the targetcli service.
https://www.suse.com/support/kb/doc/?id=000020323

## Next Steps

For additional help, open a support request by using the following instructions. When you submit your request, attach `supportconfig` and `hb_report` logs for troubleshooting.
To get further information about data log collection in SUSE, see:
https://www.suse.com/support/kb/doc/?id=000019142

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
