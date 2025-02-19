---
title: Troubleshoot SBD service failure in RHEL Pacemaker clusters
description: Provides troubleshooting guidance to an issue where the SBD service doesn't fail to start in a Red Hat Enterprise Server Pacemaker cluster.
ms.reviewer: rnirek, sentj, hsisodia, divargas, v-weizhu
ms.date: 10/12/2024
ms.service: azure-virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker clustering, and fencing
---
# Troubleshoot SBD service failure in RHEL Pacemaker clusters

**Applies to:** :heavy_check_mark: Linux VMs

This article outlines common scenarios where the STONITH Block Device (SBD) service fails to start in a Red Hat Enterprise Server (RHEL) Pacemaker cluster and provides guidance for identifying and resolving this issue.

## How SBD works

The SBD device requires at least one more virtual machine (VM) that acts as an Internet Small Computer System Interface (iSCSI) target server and provides an SBD device. These iSCSI target servers can also be shared with other Pacemaker clusters. The advantage of using an SBD device is that if you're already using SBD devices on-premises, they don't require any changes to how you operate the Pacemaker cluster.

To set up an Azure Pacemaker cluster with the SBD fencing mechanism, use either of the two options:

- [SBD with an iSCSI target server](/azure/sap/workloads/high-availability-guide-rhel-pacemaker#sbd-with-an-iscsi-target-server)

- [SBD with an Azure shared disk](/azure/sap/workloads/high-availability-guide-rhel-pacemaker#sbd-with-an-azure-shared-disk)


## Symptoms

When the SBD device isn't accessible on cluster nodes, the SBD daemon fails to start and prevents the Pacemaker cluster from starting up.

To get the SBD server details, use the following methods on cluster nodes:

- Check logs in the */var/log/messages* file.
- Check the `iscsiadm discovery` command output.
- Check the status of the iSCSI service that indicates the SBD server IP addresses.

## Scenario 1: The SBD service fails to start due to iSCSI service failures

iSCSI services use iSCSI Qualified Name (IQN) for communication between initiator and target nodes. If the iSCSI services fail, SBD disks become inaccessible. In this case, the SBD service can't start and the Pacemaker service doesn't run on cluster nodes.

The following examples show how to diagnose SBD and Pacemaker service failures:

1. Check the status of the Pacemaker cluster:

    ```bash
    sudo pcs status
    ```

    If the Pacemaker cluster doesn't run, you'll see the command output that resembles the following text:

    ```output
    Error: error running crm_mon, is pacemaker running?
      error: Could not connect to launcher: Connection refused
      crm_mon: Connection to cluster failed: Connection refused
    ```

2. Check the status of the Corosync service:

    ```bash
    sudo systemctl status corosync
    ```
    
    If the Corosync service is running, you'll see the command output that resembles the following text:

    ```output
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

3. Check the status of the Pacemaker service:

    ```bash
    sudo systemctl status pacemaker
    ```
    
    The SBD service is needed for the Pacemaker service to start. If the Pacemaker service fails to start due to dependency failures, you'll see the command output that resembles the following text:

    ```output
    ○ pacemaker.service - Pacemaker High Availability Cluster Manager
         Loaded: loaded (/usr/lib/systemd/system/pacemaker.service; enabled; preset: disabled)
         Active: inactive (dead) since Thu 2024-08-01 11:22:22 UTC; 2min 9s ago
           Docs: man:pacemakerd
    https://clusterlabs.org/pacemaker/doc/
    Aug 01 11:24:28 node1 systemd[1]: Dependency failed for Pacemaker High Availability Cluster Manager.
    Aug 01 11:24:28 node1 systemd[1]: pacemaker.service: Job pacemaker.service/start failed with result 'dependency'.
    ```

4. List the dependency services tree of the Pacemaker service:

    ``` bash
    sudo systemctl list-dependencies pacemaker
    ```
    
    If the Pacemaker service doesn't have the SBD service as a dependency, you'll see the command output that resembles the following text:
    
    ```output
    pacemaker.service
    ● ├─corosync.service
    ● ├─dbus-broker.service
    × ├─sbd.service
    ● ├─system.slice
    ● ├─resource-agents-deps.target
    ● └─sysinit.target
    ```

5. Check the status of the SBD service:

    ```bash
    sudo systemctl status sbd
    ```
    
    If the SBD service fails to run, you'll see the command output that resembles the following text:

    ```output
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
    Aug 01 11:22:27 node1 sbd[12794]:  warning: open_any_device: Failed to open /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779. Trying any other config>
    Aug 01 11:24:28 node1 sbd[12794]:    error: open_any_device: No devices were available at start-up within 120 seconds.
    Aug 01 11:24:28 node1 systemd[1]: sbd.service: Control process exited, code=exited, status=1/FAILURE
    Aug 01 11:24:28 node1 systemd[1]: sbd.service: Failed with result 'exit-code'.
    Aug 01 11:24:28 node1 systemd[1]: Failed to start Shared-storage based fencing daemon.
    ```

### Resolution: Ensure both iscsid and iscsi services are enabled and running

To resolve this issue, follow these steps:
 
1. Ensure you set up correct configuration as described in [RHEL - Set up Pacemaker on Red Hat Enterprise Linux in Azure ](/azure/sap/workloads/high-availability-guide-rhel-pacemaker)

2. Enable both `iscsid` and `iscsi` services:


    ``` bash
    sudo systemctl enable iscsi
    ```

    ```bash
    sudo systemctl enable iscsid
    ```
3. Verify the status of the `iscsid` and `iscsi` services:

    ```bash
    sudo systemctl status iscsi 
    ```

    ```bash
    sudo systemctl status iscsid
    ```

    If the services are enabled and running, you'll see the command output that resembles the following text:
  
    ```output
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

## Scenario 2: The SBD service fails to start due to SBD configuration issues

The SBD service fails to start due to the following issues:

- Missing SBD configurations.
- Incorrect SBD configurations such as incorrect SBD devices names or syntax errors.

### Resolution: Ensure the correct SBD configuration

1. Validate the SBD configuration exists:

    ```bash
    sudo pcs stonith config sbd
    ```
    If the SBD configuration exists, you'll see the command output that resembles the following text:
    
    ```output
    Resource: sbd (class=stonith type=fence_sbd)
      Attributes: sbd-instance_attributes
        devices=/dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779,/dev/disk/by-id/scsi-36001405cbac988092e448059d25d1a4a,/dev/disk/by-
            id/scsi-36001405a29a443e4a6e4ceeae822e5eb
      Operations:
        monitor: sbd-monitor-interval-600
          interval=600
          timeout=15
    ```

2. Validate and ensure the SBD configuration file */etc/sysconfig/sbd* has the following recommended parameters and the correct SBD devices:

    ```output
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

## Scenario 3: iSCSI devices aren't available on cluster nodes

To validate if iSCSI devices are available on cluster nodes, run the following `lsscsi` or `lsblk` command. If iSCSI devices aren't available, SBD disks won't be displayed in the command output.

```bash
sudo lsscsi
```

```output
[0:0:0:0]    disk    Msft     Virtual Disk     1.0   /dev/sda
[1:0:1:0]    disk    Msft     Virtual Disk     1.0   /dev/sdb
[5:0:0:0]    cd/dvd  Msft     Virtual CD/ROM   1.0   /dev/sr0
```

```bash
sudo lsblk
```

```output
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

### Resolution: Enable automatic login to iSCSI target servers

1. Validate initiator names on all cluster nodes:

    ```bash
    sudo  cat /etc/iscsi/initiatorname.iscsi
    ```
    
    ```output
    InitiatorName=iqn.2006-04.nfs-0.local:nfs-0
    ```

    ```bash 
    sudo  cat /etc/iscsi/initiatorname.iscsi
    ```
    
    ```output
    InitiatorName=iqn.2006-04.nfs-1.local:nfs-1
    ```

2. List all SBD devices in the SBD configuration file.

    ```bash
    sudo grep SBD_DEVICE /etc/sysconfig/sbd
    ```
    
    ```output
    # SBD_DEVICE specifies the devices to use for exchanging sbd messages
    SBD_DEVICE="/dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779;/dev/disk/by-id/scsi-36001405cbac988092e448059d25d1a4a;/dev/disk/by-id/scsi-36001405a29a443e4a6e4ceeae822e5eb"
    ```

3. Check if the SBD devices are running and accessible. If the SBD services aren't running and accessible, you'll see the error message "sbd failed; please check the logs."

    ```bash
    sudo  /usr/sbin/sbd -d /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 list
    ```
    
    ```output
    == disk /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 unreadable!
    sbd failed; please check the logs.
    ```

    ```bash
    sudo /usr/sbin/sbd -d /dev/disk/by-id/scsi-36001405cbac988092e448059d25d1a4a list
    ```
    
    ```output
    == disk /dev/disk/by-id/scsi-36001405cbac988092e448059d25d1a4a unreadable!
    sbd failed; please check the logs.
    ```

    ```bash
    sudo /usr/sbin/sbd -d /dev/disk/by-id/scsi-36001405a29a443e4a6e4ceeae822e5eb list
    ```
    
    ```output
    == disk /dev/disk/by-id/scsi-36001405a29a443e4a6e4ceeae822e5eb unreadable!
    sbd failed; please check the logs.
    ```

4. Enable the automatic login to iSCSI target servers.

    1. Perform a `iscsiadm` discovery on a cluster node:
    
        ```bash
        sudo iscsiadm -m discovery
        ```
        The command output shows the IP addresses of all iSCSI target servers and the default port 3260:
    
        ```output
        10.0.0.17:3260 via sendtargets
        10.0.0.18:3260 via sendtargets
        10.0.0.19:3260 via sendtargets
        ```
    2. Discovery the iSCSI target server at a given IP address:

        ```bash
        sudo iscsiadm -m discovery --type=st --portal=10.0.0.17:3260
        ```

        The command output shows a target name such as `iqn.2006-04.nfs.local:nfs`:
        
        ```output
        10.0.0.17:3260,1 iqn.2006-04.dbnw1.local:dbnw1
        10.0.0.17:3260,1 iqn.2006-04.ascsnw1.local:ascsnw1
        10.0.0.17:3260,1 iqn.2006-04.nfs.local:nfs
        ```
    3. Sign into the iSCSI device:
    
        ```bash
        sudo iscsiadm -m node -T iqn.2006-04.nfs.local:nfs --login --portal=10.0.0.17:3260
        ```
        
        ```output
        Logging in to [iface: default, target: iqn.2006-04.nfs.local:nfs, portal: 10.0.0.17,3260]
        Login to [iface: default, target: iqn.2006-04.nfs.local:nfs, portal: 10.0.0.17,3260] successful.
        ```
    4. Enable automatic login to the iSCSI device:

        ```bash
        sudo iscsiadm -m node -p 10.0.0.17:3260 -T iqn.2006-04.nfs.local:nfs --op=update --name=node.startup --value=automatic
        ```
    5. Validate if the iSCSI device is available:

        ```bash
        sudo lsscsi
        ```
        
        ```output
        [0:0:0:0]    disk    Msft     Virtual Disk     1.0   /dev/sda
        [1:0:1:0]    disk    Msft     Virtual Disk     1.0   /dev/sdb
        [5:0:0:0]    cd/dvd  Msft     Virtual CD/ROM   1.0   /dev/sr0
        [6:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sdc
        ```

    6. Repeat step b-e to ensure other iSCSI devices are available.
    7. Repeat step a-f on another cluster node to ensure that all iSCSI devices on another cluster node are available.


Once the iSCSI devices are available, the `lsscsi` or `lsblk` command output should display SBD disks.

```bash
sudo lsscsi
```

```output
[0:0:0:0]    disk    Msft     Virtual Disk     1.0   /dev/sda
[1:0:1:0]    disk    Msft     Virtual Disk     1.0   /dev/sdb
[5:0:0:0]    cd/dvd  Msft     Virtual CD/ROM   1.0   /dev/sr0
[6:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sdc
[7:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sdd
[8:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sde
```

```bash
sudo lsblk
```

```output
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

## Scenario 4: The node fails to rejoin the cluster after being fenced

If the SBD slot isn't in a clean state, the node will fail to rejoin the cluster after being fenced. In this case, the SBD device on the node is in a failed state and another node is in a pending state.

To validate the state of the SBD slot, run the following commands:


```bash
sudo lsscsi
```

```output
[0:0:0:0]    disk    Msft     Virtual Disk     1.0   /dev/sda
[1:0:1:0]    disk    Msft     Virtual Disk     1.0   /dev/sdb
[5:0:0:0]    cd/dvd  Msft     Virtual CD/ROM   1.0   /dev/sr0
[6:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sdc
[7:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sdd
[8:0:0:0]    disk    LIO-ORG  sbdnfs           4.0   /dev/sde
```

```bash
sudo sbd -d /dev/sdc list
```

```output
0       node1   clear
1       node2   reset   node1
```

```bash
sudo sbd -d /dev/sdd list
```

```output
0       node1   clear
1       node2   reset   node1
```

```bash
sudo  sbd -d /dev/sde list
```

```output
0       node1   clear
1       node2   reset   node1
```

### Resolution: Clear the SBD slot

1. Validate if the `SBD_STARTMODE` parameter is set to `always` or `clean` in the SBD configuration file */etc/sysconfig/sbd*:

    ```bash
    sudo grep -i SBD_STARTMODE  /etc/sysconfig/sbd
    ```
    
    ```output
    SBD_STARTMODE=clean
    ```
    
    The `SBD_STARTMODE` parameter determines whether a node rejoins or not. If it's set to `always`, even if the node was previously fenced, it rejoins the cluster. If it's set to `clean`, the node rejoins the cluster after the SBD slot is cleared. This is an expected behavior. It detects a fencing type message in the SBD slot for the node and not allows the node to rejoin the cluster unless the SBD slot is manually cleared.

2. Clear the SBD slot on the node that was previously fenced and wasn't able to rejoin the cluster:

    ```bash
    sudo sbd -d <SBD_DEVICE> message LOCAL clear
    ```
    
    If you know the node name, you can clear the SBD slot using the following command:
    
    ```bash
    sudo sbd -d <DEVICE_NAME> message <NODENAME> clear
    ```
    
    > [!NOTE]
    > Replace `<SBD_DEVICE>`,`<DEVICE_NAME>` and `<NODENAME>` accordingly.
    
    For example, the command could be the following one:
    
    ```bash
    sudo sbd -d /dev/sdc message node2 clear
    ```

3. Once the SBD slot is cleared, start the cluster service.

    If the cluster service fails again, run the following commands to fix the issue:
    
    ```bash
    sudo iscsiadm -m node -u
    ```
    
    ```bash
    sudo iscsiadm -m node -l
    ```

## Scenario 5: The SBD service fails to start after you add a new SBD device

After you add a new SBD device to the cluster, you see the following symptoms:

- When you check the SBD service status by running the `sudo systemctl status sbd` command, you get the error messages "sbd failed; please check the logs" and "Failed to start sbd.service: Operation refused."

- When you send a test message to a node by a SBD device, you also get the same error message: 

    ```bash
    sudo sbd -d  /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 message node1 test
    ```
    
    ```output
    sbd failed; please check the logs.
    ```

    In the */var/log/messages* file, you'll also find the following logs:
    
    ```output
    Mar  2 06:58:06 node1 sbd[11105]: /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779:    error: slot_msg: slot_msg(): No recipient / cmd specified.
    Mar  2 06:58:06 node1 sbd[11104]: warning: messenger: Process 11105 failed to deliver!
    ```

- When you run the `sbd -d list` command, a blank output is displayed. For more information, see [SBD device list showing blank output](https://access.redhat.com/solutions/6771581).

### Resolution: Restart the Pacemaker cluster

When you use SBD as a fencing device and enable it for a Pacemaker cluster, services should be managed under cluster control. Therefore, you can't start or stop it manually. After adding any new SBD device to the Pacemaker cluster, you should restart the Pacemaker cluster to make the SBD device take effect under cluster control.

1. Stop and restart the cluster services on all cluster nodes.

    ```bash 
    sudo pcs cluster stop --all
    ```
    
    ```bash
    sudo pcs cluster start --all
    ```

2. Check if the SBD service starts successfully.

    ```bash
    sudo systemctl status sbd.service 
    ```
    
    ```output
    ● sbd.service - Shared-storage based fencing daemon
       Loaded: loaded (/usr/lib/systemd/system/sbd.service; enabled; vendor preset: disabled)
       Active: active (running)
    ```

Once the SBD service is running, the `sbd -d list` command won't show a blank output:

```bash
sudo sbd -d /dev/disk/by-id/scsi-360014056eadbecfeca042d4a66b9d779 list
```

```output
0   node1   clear   
1   node2   clear   
```

## Next steps

If your issue isn't resolved, collect system logs from Red Hat systems, generate an sos report, and then contact support. For more information, see [What is an sos report and how to create one in Red Hat Enterprise Linux?](https://access.redhat.com/solutions/3592)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
