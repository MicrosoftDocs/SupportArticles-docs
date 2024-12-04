---
title: Troubleshoot SBD service failure in SUSE Pacemaker clusters
description: Provides troubleshooting guidance if SBD services fail
ms.reviewer: rnirek
ms.author: hsisodia
author: rnirek
ms.topic: troubleshooting
ms.date: 10/23/2024
ms.service: azure-virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker clustering, and fencing
---

# Troubleshoot SBD service failure in SUSE Pacemaker clusters

**Applies to:** :heavy_check_mark: Linux VMs

This article outlines common scenarios where the STONITH Block Device (SBD) service doesn't start in a SUSE Enterprise Linux Pacemaker cluster. This article also provides guidance for identifying and resolving this issue.

## How SBD works

An SBD device requires at least one additional virtual machine (VM) that acts as an Internet Small Computer System Interface (iSCSI) target server and provides an SBD device. These iSCSI target servers can also be shared with other Pacemaker clusters. The advantage to using an SBD is that, if you're already using them on-premises, SBD devices don't require you to change how you operate the Pacemaker cluster.

For a Microsoft Azure Pacemaker cluster that has SBD storage protection, you can use either of the following options for the setup. For more information about these mechanisms, see:

- [SBD with an iscsi target server](/azure/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#sbd-with-an-iscsi-target-server)
- [SBD with an Azure shared disk](/azure/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#sbd-with-an-azure-shared-disk)

## How to diagnose the issue

The following example demonstrates how to determine that the cluster startup issue is caused by the SBD service failure.

1. Check the status of the cluster:

    ```bash
    sudo crm status
    ```
    ```output
    ERROR: status: crm_mon (rc=102): Error: cluster is not available on this node
    ```
2. Check whether the Pacemaker service starts. The following example output indicates that the Pacemaker service failed because one or more dependent services are not functioning:

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
3. Check the dependency services tree of the Pacemaker service:

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
4. Check the status of each service. In the following example, you can see that all dependency services, such as Corosync, are active, but the SBD service is not running: 

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

5. Check the SBD service status. In this example, the service doesn't start, and it returns a `Failed to start Shared-storage based fencing daemon` error message: 

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
## Cause 1 : SBD service failed because of iSCSI failure

The Pacemaker service is not running, and the SBD service is in a failed state on both cluster nodes. The iSCSI services use the iSCSI Qualified Name (IQN) for communication between the initiator and target nodes. SBD disks can become inaccessible if services are not run. This, in turn, causes the SBD and Pacemaker services to fail.

### Resolution

1. Make sure that the setup is correctly configured as documented in [SUSE - set up Pacemaker on SUSE Linux Enterprise Server in Azure ](/azure/sap/workloads/high-availability-guide-suse-pacemaker).
2. Put the cluster into maintenance mode:
   ```bash
   sudo crm configure property maintenance-mode=true
   ```
3. Make sure that the `iscsid` and `iscsi` services are enabled:
   ```  bash
   sudo systemctl enable iscsi
   ```
   ```bash
   sudo systemctl enable iscsid
   ```
4. Verify that the of `iscsid` and `iscsi` services are running:
   ```bash
   sudo systemctl status iscsi
   ```
   ```bash
   sudo systemctl status iscsid
   ```
   If the services are working, the output should resemble the following:  
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
5. Remove the cluster from maintenance mode:
   ```bash
   sudo crm configure property maintenance-mode=false
   ```
## Cause 2: Configurations issues 

Incorrect SBD configurations that have, for example, missing or incorrectly named SBD devices or syntax errors can cause the SBD service to fail.

### Resolution 1
Verify that the SBD configuration file, `/etc/sysconfig/sbd`, contains the recommended parameter and the correct SBD devices:

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
Verify the STONITH resource configuration by running the following command:

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

## Cause 3: iSCSI devices aren't available on cluster nodes

When you run the `lscsi` or `lsblk` command, SBD disks are not displayed in the output:

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
### Resolution

Perform the following checks:

1. Verify the initiator name on both cluster nodes:

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
2. Try listing all SBD devices that are mentioned in SBD configuration file:

    ```bash
    sudo grep SBD_DEVICE /etc/sysconfig/sbd
    ```
    ```output
    # SBD_DEVICE specifies the devices to use for exchanging sbd messages
    SBD_DEVICE="/dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779;/dev/disk/by-id/scsi-36001405cbac988092e448059d25d1a4a;/dev/disk/by-id/scsi-36001405a29a443e4a6e4ceeae822e5eb"
    ```
3. Based on the error message that's provided, check whether the SBD servers are running and accessible:

    ```bash
    sudo /usr/sbin/sbd -d /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 list
    ```
    ```output
    == disk /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 unreadable!
    sbd failed; please check the logs.
    ```

4. To fix the error, run the following steps on both nodes of the cluster to connect to the iSCSI devices after you make sure that SBD servers are running and accessible. In the following example, `iqn.2006-04.nfs.local:nfs` is the target name that's listed when you run the first command, `iscsiadm -m discovery`:

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
    Run the same commands to connect to the rest of the devices. Also, run the same set of commands on the other node in the cluster.

5. After iSCSI devices are detected, the command output should reflect the SBD devices:

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
## Cause 4: Node doesn't rejoin cluster after fencing

One of the nodes doesn't rejoin the cluster after the fencing process finishes. SBD is in a failed state, and the other node is in a pending state.

### Resolution 1

It's possible that the SBD slot isn't in a clean state. Therefore, the node can't rejoin the cluster after a fencing restart. Check the SBD status by running the following commands. If the SBD slot is not clean, the SBD status shows `reset`:

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

### Resolution 2

Verify the `/etc/sysconfig/sbd` configuration file, and check whether the `SBD_STARTMODE` parameter is set to `always` or `clean`:

```bash
sudo grep -i SBD_STARTMODE  /etc/sysconfig/sbd
```
```output
SBD_STARTMODE=clean
```
The `SBD_STARTMODE` parameter determines whether a node can rejoin the cluster. If it's set to `always`, the node will rejoin the cluster even if it was previously fenced. If the parameter is set to `clean`, the node will rejoin only after it's brought to a clean state.

This behavior is expected. SBD detects a fencing message in the slot for the node, and prevents it from joining the cluster until the issue is manually cleared.

To clear the node slot, follow these steps:

1.  Clear the fencing message for the local node:

    ```bash
    sudo sbd -d <SBD_DEVICE> message LOCAL clear
    ```
    You can also run the command from any node in the cluster by specifying the node name instead of `LOCAL`:
    
    ```bash
    sudo sbd -d <DEVICE_NAME> message <NODENAME> clear
    ```
    The node name that you specified should be the node fenced and can't join the cluster:
    ```bash
    sudo sbd -d /dev/sde message nfs-1 clear
    ```
    
3. After the node slot is cleared, you should be able to start the Clustering service. If the service fails again, run the following commands to fix the issue:

    ```bash
    sudo iscsiadm -m node -u
    ```
    ```bash
    sudo iscsiadm -m node -l
    ```

> [!NOTE]
> In these commands, replace `<SBD_DEVICE>`,`<DEVICE_NAME>`, and `<NODENAME>` with the actual values per the cluster setup.

## Cause 5: SBD service doesn't start after you add new SBD device

After you create an SBD device or add one to a cluster, you receive an `sbd failed; please check the logs` error message.

Check whether you're receiving error messages when you send messages to SBD devices:

```bash
sudo sbd -d  /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 message node1 test
```
If you reach this issue, you will see the following error:

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
When you use SBD as a fencing device and enable it for a Pacemaker cluster, services must be managed under cluster control. Therefore, you can't start or stop them manually. Additionally, when you enable an SBD device or add it to the cluster, you should restart the Pacemaker cluster in order for the changes to take effect under cluster control:

1. Restart cluster services on all cluster nodes:

     ```bash 
    sudo crm cluster stop
    sudo crm cluster start
    ```

2. Check whether the SBD service start successfully:

     ```bash
    sudo systemctl status sbd.service 
    ```
    
    ```output
    ● sbd.service - Shared-storage based fencing daemon
       Loaded: loaded (/usr/lib/systemd/system/sbd.service; enabled; vendor preset: disabled)
       Active: active (running)
    ```
3. Check whether the SBD device list provides the desired output:

     ```bash 
    sudo sbd -d /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 list
    ```
    ```output
    0   node1   clear   
    1   node2   clear   
    ```
## Cause 6: SBD doesn't start after SLES 12 to SLES 15 upgrade
After you upgrade an SLES 12 system to SLES 15, iSCSI client information might not exist. This condition causes connections to remote file systems over iSCSI to fail.

### Resolution
In SLES 15, the deprecated `targetcli-fb` package was replaced with `python3-targetcli-fb` or `python2-targetcli-fb`. This causes system service information to be reset to the default value (disabled/stopped). To resolve the issue, you must manually enable and start the `targetcli` service. For more information, see [SBD Failure After SLES15 Upgrade](https://www.suse.com/support/kb/doc/?id=000020323).

## Next steps
For additional help, open a support request by using the following instructions. When you submit your request, attach [supportconfig](https://documentation.suse.com/smart/systems-management/html/supportconfig/index.html) and [hb_report](https://www.suse.com/support/kb/doc/?id=000019142) logs for troubleshooting.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
