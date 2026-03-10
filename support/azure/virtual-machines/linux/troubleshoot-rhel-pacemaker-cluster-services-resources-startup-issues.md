---
title: Troubleshoot RHEL Pacemaker Cluster Services and Resources Startup Issues in Azure
description: Provides troubleshooting guidance for issues related to cluster resources or services in RedHat Enterprise Linux (RHEL)) Pacemaker Cluster
ms.reviewer: rnirek,srsakthi
ms.author: rnirek
author: skarthikeyan7-msft 
ms.topic: troubleshooting
ms.date: 01/14/2026
ms.service: azure-virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker clustering, and fencing
---

# Troubleshoot startup issues for Pacemaker Cluster services and resources

**Applies to:** :heavy_check_mark: Linux VMs

This article discusses the most common causes of startup issues in RedHat Enterprise Linux (RHEL) Pacemaker Cluster resources or services, and also provides guidance to identify and resolve the issues.

## Scenario 1: Can't start cluster service because of quorum

### Symptom for scenario 1

- Cluster node doesn't join a cluster after a cluster restart.
- Nodes are reported as `UNCLEAN (offline)`.
- Current DC is reported as `NONE`.

  ```bash
  sudo pcs status
  ```
  ```output
  Cluster name: rhel-cluster
  Cluster Summary:
    * Stack: corosync (Pacemaker is running)
    * Current DC: vm-mce-hana02 (version 2.1.9-1.2.el9_6-49aab9983) - partition with quorum
    * Last updated: Wed Jan  7 09:17:50 2026
    * Last change:  Wed Jan  7 08:38:25 2026 by root via root on vm-mce-hana01
    * 2 nodes configured
    * 9 resource instances configured

  Node List:
    * Node vm-mce-hana01: UNCLEAN (offline)
    * Node vm-mce-hana02: UNCLEAN (offline)
  ```

- `sudo pcs quorum status` returns the following error message:

  ```bash
  sudo pcs quorum status
  ```
  
  ```output
  Error: Unable to get quorum status: Unable to start votequorum status tracking: CS_ERR_BAD_HANDLE
  ```
  
- Check for the error: Corosync quorum is not configured in `/var/log/messeges`:
  
  ```output
  Jan  7 09:20:50 vm-mce-hana01 pacemaker-controld[28982]: error: Corosync quorum is not configured
  Jan  7 09:21:20 vm-mce-hana01 pacemaker-controld[29026]: error: Corosync quorum is not configured
  ```

### Cause for scenario 1

The **VoteQuorum** service is a component of the corosync project. To prevent split-brain scenarios, this service can be optionally loaded into a corosync cluster's nodes. Every system in the cluster is given a certain number of votes to achieve this quorum. This makes sure that cluster actions can occur only if most votes are cast. Either every node or no node must have the service loaded. The outcomes are uncertain if the service is loaded into a subset of cluster nodes.

The following `/etc/corosync/corosync.conf` setting enables **VoteQuorum** service within corosync:

```output
quorum {
    provider: corosync_votequorum
    two_node: 1
}
```

**VoteQuorum** reads its configuration from `/etc/corosync/corosync.conf`. Some values can be changed at runtime and others are read only at corosync startup. It's important that those values are consistent across all nodes that are participating in the cluster. Otherwise, vote quorum behavior is unpredictable.

### Resolution for scenario 1

1. Before you make any changes, make sure that you have a backup or snapshot. For more information, see [Azure VM backup](/azure/backup/backup-azure-vms-introduction).

2. Check for missing quorum section in `/etc/corosync/corosync.conf`. Compare the existing `corosync.conf` with any backup that's available in `/etc/corosync/`.
   
3. Put the cluster into maintenance mode:

    ```bash
    sudo pcs property set maintenance-mode=true
    ```

4. Update the changes in `/etc/corosync/corosync.conf`.

    Example of a two-node cluster:

    ```bash
    sudo cat /etc/corosync/corosync.conf
    ```
    ```output
    totem {
      version: 2
      cluster_name: rhel-cluster
      transport: knet
      token: 30000
      crypto_cipher: aes256
      crypto_hash: sha256
      cluster_uuid: df29c619ef55405ab6dc9ba1364ea315
    }

    nodelist {
        node {
            ring0_addr: vm-mce-hana01
            name: vm-mce-hana01
            nodeid: 1
        }

        node {
            ring0_addr: vm-mce-hana02
            name: vm-mce-hana02
            nodeid: 2
        }
    }

    quorum {
        provider: corosync_votequorum
        two_node: 1
    }

    logging {
        to_logfile: yes
        logfile: /var/log/cluster/corosync.log
        to_syslog: yes
        timestamp: on
    }
    ```

5. Remove the cluster from maintenance mode.

    ```bash
    sudo pcs property set maintenance-mode=false
    ```

6. Sync the cluster:

    ```bash
    sudo pcs cluster sync
    ```

7. Reload corosync:

    ```bash
    sudo pcs cluster reload corosync
    ```

## Scenario 2: Issue in cluster VIP resource

### Symptom for scenario 2

A virtual IP resource (`IPaddr2` resource) didn't start or stop in Pacemaker.

The following error entries are logged in `/var/log/pacemaker/pacemaker.log`:

```output
Jan 03 13:46:30  IPaddr2(vip_HN1_00)[345260]:    ERROR: [findif] failed
Jan 03 13:46:30.641 vm-mce-hana01 pacemaker-execd     [2162] (log_op_output)    info: vip_HN1_00_monitor_10000[345260] error output [ ocf-exit-reason:[findif] failed ]
Jan 03 13:47:18.067 vm-mce-hana01 pacemaker-schedulerd[2164] (unpack_rsc_op_failure)    warning: Unexpected result (error: [findif] failed) was recorded for monitor of vip_HN1_00 on vm-mce-hana01 at Jan  3 13:46:20 2026 | exit-status=1 id=vip_HN1_00_last_failure_0
Jan 03 13:47:18  IPaddr2(vip_HN1_00)[347048]:    WARNING: [findif] failed
```

The error can also be observed while running `sudo pcs status`:

```bash
sudo pcs status
```
```output
Failed Resource Actions:
  * vip_HN1_00 10s-interval monitor on vm-mce-hana01 returned 'error' ([findif] failed) at Sat Jan  3 14:04:58 2026 after 37ms
```

### Cause for scenario 2

1. To choose which network adapter (NIC) to start the `IPAddr2` resource on, `IPaddr2` invokes the `findif()` function, as defined in `/usr/lib/ocf/resource.d/heartbeat/IPaddr2` that is contained in the `resource-agents` package.

2. The correct network adapter is determined by the options that are set on the `IPAddr2` resource, such as `ip` (required), `cidr_netmask`, and `broadcast`.

    For example:

    Check the `IPaddr2` settings:

    ```bash
    sudo pcs resource config vip_HN1_00
    ```
    ```output
    Resource: vip_HN1_00 (class=ocf provider=heartbeat type=IPaddr2)
      Attributes: vip_HN1_00-instance_attributes
        cidr_netmask=24
        ip=10.33.0.9
    Operations:
      monitor: vip_HN1_00-monitor-interval-10s
        interval=10s timeout=20s
      start: vip_HN1_00-start-interval-0s
        interval=0s timeout=20s
      stop: vip_HN1_00-stop-interval-0s
        interval=0s timeout=20s
    ```

3. Try to determine the `NIC` information manually. In this example, based on the IP address and netmask, we can successfully find `eth0` from the route table:

    ```bash
    sudo ip -o -f inet route list match 10.33.0.9/24 scope link
    ```
    ```output
    10.33.0.0/24 dev eth0 proto kernel src 10.33.0.5 metric 100 
    ```

4. In a situation in which `NIC (eth0)` is down, you can't manually find the `NIC` information, and that might cause `[findif]` to fail. Replace `10.33.0.9/24` and `eth0` as appropriate.

    ```bash
    sudo ip link set eth0 down
    ```
    ```bash
    sudo ip -o -f inet route list match 10.33.0.9/24 scope link 
    ```

### Resolution for scenario 2

If a route that matches the `VIP` isn't in the default routing table, you can specify the `NIC` name in the Pacemaker resource so that it can be configured to bypass the check:

1. Before you make any changes, make sure that you have a backup or snapshot. For more information, see [Azure VM backup](/azure/backup/backup-azure-vms-introduction).

2. Put the cluster into maintenance mode:
   
    ```bash
    sudo pcs property set maintenance-mode=true
    ```

3. Update the `NIC` resources:

    ```bash
    sudo pcs resource update vip_HN1_00 nic=eth0
    ```

4. Restart the `NIC `resources:

    ```bash
    sudo pcs resource restart vip_HN1_03
    ```
    ```output
    vip_HN1_03 successfully restarted
    ```

5. Remove the cluster from `maintenance-mode`:

    ```bash
    sudo pcs property set maintenance-mode=false
    ```

6. Verify the `IP` resource:

    ```bash
    sudo pcs resource config show vip_HN1_00
    ```
    ```output
    Resource: vip_HN1_00 (class=ocf provider=heartbeat type=IPaddr2)
      Attributes: vip_HN1_00-instance_attributes
        cidr_netmask=24
        ip=10.33.0.9
        nic=eth0
      Operations:
        monitor: vip_HN1_00-monitor-interval-10s
          interval=10s timeout=20s
        start: vip_HN1_00-start-interval-0s
          interval=0s timeout=20s
        stop: vip_HN1_00-stop-interval-0s
          interval=0s timeout=20s
    ```

For more information about this scenario, see the following Red Hat article: ["ERROR: [findif] failed" shown in Pacemaker'](https://access.redhat.com/solutions/2119711).

## Scenario 3: Issue in SAP HANA (High-performance Analytic Appliance)

### Scenario 3, Symptom 1: SAP HANA DB doesn't start and generates an unknown error

SAP HANA DB doesn't start, and it returns an `unknown error` error message.

1. In the `/var/log/messages` log section, an `SRHOOK()=SFAIL` entry is logged. This indicates that the cluster nodes are out of sync.
2. The secondary cluster node is in `WAITING4PRIM` status.

    ```bash
    sudo pcs status --full
    ```
    ```output
    * Node vm-mce-hana01 (1):
        + hana_XXX_clone_state              : PROMOTED  
        + hana_XXX_sync_state               : PRIM      
        + hana_XXX_roles                    : 4:P:master1:master:worker:master

    * Node vm-mce-hana02 (2):
        + hana_XXX_clone_state              : WAITING4PRIM  
        + hana_XX_sync_state                : SFAIL      
        + hana_XXX_roles                    : 4:S:master1:master:worker:slave
    ```

3. When you run `sudo pcs status`, the cluster status is shown as follows:

    ```bash
    sudo pcs status
    ```
    ```output
     * 2 nodes configured
     * 9 resource instances configured

    Node List:
      * Online: [ vm-mce-hana01 vm-mce-hana02 ]

    Full List of Resources:
      * rsc_st_azure        (stonith:fence_azure_arm):       Started vm-mce-hana01
      * Clone Set: health-azure-events-clone [health-azure-events]:
        * Started: [ vm-mce-hana01 vm-mce-hana02 ]
      * Resource Group: g_ip_HN1_00:
        * nc_HN1_00 (ocf:heartbeat:azure-lb):        Started vm-mce-hana02
        * vip_HN1_00        (ocf:heartbeat:IPaddr2):         Started vm-mce-hana02
      * Clone Set: SAPHanaTopology_HN1_00-clone [SAPHanaTopology_HN1_00]:
        * Started: [ vm-mce-hana01 vm-mce-hana02 ]
      * Clone Set: SAPHana_HN1_00-clone [SAPHana_HN1_00] (promotable):
        * Promoted: [ vm-mce-hana01 ]
        * Stopped: [ vm-mce-hana02 ]

    Failed Resource Actions:
      * SAPHana_HN1_00 start on vm-mce-hana02 returned 'not running' at Wed Jan  7 13:39:14 2026 after 739ms
    ```

### Cause for scenario 3, symptom 1

Pacemaker can't start the SAP HANA resource if there are `SYN` failures between the primary and secondary nodes. Given command shows the replication status of the SAP HANA database as `UNKNOWN` which confirms replication failed between the HANA DB.

```bash
  sudo su - hn1adm -c "python /usr/sap/HN1/HDB00/exe/python_support/systemReplicationStatus.py"
```
```output
  |Database |Host          |Port  |Service Name |Volume ID |Site ID |Site Name |Secondary     |Secondary |Secondary |Secondary |Secondary          |Replication |Replication |Replication    |Secondary    |
  |         |              |      |             |          |        |          |Host          |Port      |Site ID   |Site Name |Active Status      |Mode        |Status      |Status Details |Fully Synced |
  |-------- |------------- |----- |------------ |--------- |------- |--------- |------------- |--------- |--------- |--------- |------------------ |----------- |----------- |-------------- |------------ |
  |SYSTEMDB |vm-mce-hana01 |30001 |nameserver   |        1 |      1 |Site1     |vm-mce-hana02 |    30001 |        2 |Site2     |CONNECTION TIMEOUT |SYNC        |UNKNOWN     |               |       False |
  |HN1      |vm-mce-hana01 |30007 |xsengine     |        2 |      1 |Site1     |vm-mce-hana02 |    30007 |        2 |Site2     |CONNECTION TIMEOUT |SYNC        |UNKNOWN     |               |       False |
  |HN1      |vm-mce-hana01 |30003 |indexserver  |        3 |      1 |Site1     |vm-mce-hana02 |    30003 |        2 |Site2     |CONNECTION TIMEOUT |SYNC        |UNKNOWN     |               |       False |

  status system replication site "2": UNKNOWN
  overall system replication status: UNKNOWN

  Local System Replication State
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  mode: PRIMARY
  site id: 1
  site name: Site1
```

> [!Important]
> `SAPHanaSR-showAttr` is supported only up to RHEL 7, deprecated in RHEL 8.4+, and completely removed in RHEL 9. Therefore alternative commands should be used to find the replication status like `sudo pcs status --full` or 'crm_attribute'.

### Workaround for scenario 3, symptom 1

The SAP HANA resource can't be started by Pacemaker if there are `SYN` failures between the primary and secondary cluster nodes. To mitigate this issue, you must manually enable `SYN` between the primary and secondary nodes.

> [!Important]
> Steps 2, 3, and 4 must be performed by using a SAP administrator account. This is because these steps use a SAP System ID to stop, start, and re-enable replication manually.

1. Before you make any changes, make sure that you have a backup or snapshot. For more information, see [Azure VM backup](/azure/backup/backup-azure-vms-introduction).

2. Put the cluster into maintenance mode:

    ```bash
    sudo pcs property set maintenance-mode=true
    ```
    
3. Check the SAP HANA DB and processes state: 

  a. Verify that both the primary and secondary nodes are running the SAP database and related SAP processes. One should function as the primary node and the other as the secondary. This makes sure that the databases on both nodes remain synchronized.

  b. Switch to `<SID>adm` and run `HDB info` on each node to check the SAP-related processes that are running in the node. The SAP administrator should be able to confirm that the required process are running on both of the nodes.
      
      ```bash
      HDB info
      ```
      ```output
      USER          PID     PPID  %CPU        VSZ        RSS COMMAND
      hn1adm       5261     5260   0.0       8892       5376 -sh
      hn1adm      13183     5261   0.0       7516       4096  \_ /bin/sh /usr/sap/HN1/HDB00/HDB info
      hn1adm      13212    13183   0.0      10020       3712      \_ ps fx -U hn1adm -o user:8,pid:8,ppid:8,pcpu:5,vsz:10,rss:10,args
      hn1adm      12034        1   0.3      23900      14204 /usr/lib/systemd/systemd --user
      hn1adm      12036    12034   0.0     176000       8732  \_ (sd-pam)
      hn1adm       5219        1   0.0     566736      40900 hdbrsutil  --start --port 30003 --volume 3 --volumesuffix mnt00001/hdb00003.00003 --identifier 1767858538
      hn1adm       4764        1   0.0     566664      40956 hdbrsutil  --start --port 30001 --volume 1 --volumesuffix mnt00001/hdb00001 --identifier 1767858528
      hn1adm       4288        1   0.0       9308       3172 sapstart pf=/usr/sap/HN1/SYS/profile/HN1_HDB00_vm-mce-hana01
      hn1adm       4297     4288   0.2     455668      88620  \_ /usr/sap/HN1/HDB00/vm-mce-hana01/trace/hdb.sapHN1_HDB00 -d -nw -f /usr/sap/HN1/HDB00/vm-mce-hana01/daemon.ini pf=/usr/sap/HN1/SYS/profile/HN1_HDB00_vm-mce-hana01
      hn1adm       4324     4297  10.4    6460472    3496360      \_ hdbnameserver
      hn1adm       4999     4297   0.4     935604     181024      \_ hdbcompileserver
      hn1adm       5002     4297   0.4    1174076     195664      \_ hdbpreprocessor
      hn1adm       5044     4297  19.9    6972960    3707744      \_ hdbindexserver -port 30003
      hn1adm       5047     4297   2.8    4401136    1263592      \_ hdbxsengine -port 30007
      hn1adm       5689     4297   1.2    2237896     436604      \_ hdbwebdispatcher
      hn1adm       1482        1   0.0     500636      58040 /usr/sap/HN1/HDB00/exe/sapstartsrv pf=/usr/sap/HN1/SYS/profile/HN1_HDB00_vm-mce-hana01
      ```
    
  c. If the SAP DB and services aren't active on the node, we recommend that you contact your SAP administrator to review and stop the SAP DB services, first in the secondary node and then in the primary node:

      ```bash
      sudo HDB stop
      ```
      or:

      ```bash
      sudo sapcontrol -nr <SAPInstanceNo> -function Stop
      ```
    
  d. After the stop operation finishes, start HANA DB in the primary node and then in the secondary node. Modify `<SAPInstanceNo>` as appropriate.

      ```bash
      sudo HDB start
      ```
      or:
    
      ```bash
      sudo sapcontrol -nr <SAPInstanceNo> -function Start
      ```
4. If the database nodes are still not synchronized, the SAP administrator should troubleshoot the issue by reviewing the SAP logs to make sure that the database nodes are correctly synchronized.

    > [!NOTE]
    > The SAP administrator must determine which node should be designated as the primary and which as the secondary to make sure that no database data is lost in the process.

5. After you enable replication, check the system replication status by using the SAP system administrator account. In this situation, the user admin account is `hn1adm`.

   On the primary node, verify that the overall system replication status is `ACTIVE`.

   If the database nodes are still not synchronized, the SAP administrator should troubleshoot the issue by reviewing the SAP logs to make sure that the database nodes are correctly synchronized:

   ```bash
   sudo su - hn1adm -c "python /usr/sap/HN1/HDB00/exe/python_support/systemReplicationStatus.py"
   ```
   ```output
    |Database |Host          |Port  |Service Name |Volume ID |Site ID |Site Name |Secondary     |Secondary |Secondary |Secondary |Secondary     |Replication |Replication |Replication    |Secondary    |
    |         |              |      |             |          |        |          |Host          |Port      |Site ID   |Site Name |Active Status |Mode        |Status      |Status Details |Fully Synced |
    |-------- |------------- |----- |------------ |--------- |------- |--------- |------------- |--------- |--------- |--------- |------------- |----------- |----------- |-------------- |------------ |
    |SYSTEMDB |vm-mce-hana01 |30001 |nameserver   |        1 |      1 |Site1     |vm-mce-hana02 |    30001 |        2 |Site2     |YES           |SYNC        |ACTIVE      |               |        True |
    |HN1      |vm-mce-hana01 |30007 |xsengine     |        2 |      1 |Site1     |vm-mce-hana02 |    30007 |        2 |Site2     |YES           |SYNC        |ACTIVE      |               |        True |
    |HN1      |vm-mce-hana01 |30003 |indexserver  |        3 |      1 |Site1     |vm-mce-hana02 |    30003 |        2 |Site2     |YES           |SYNC        |ACTIVE      |               |        True |

    status system replication site "2": ACTIVE
    overall system replication status: ACTIVE

    Local System Replication State
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    mode: PRIMARY
    site id: 1
    site name: Site1
   ```
6. Exit the SAP Admin account, and then remove the cluster from maintenance mode:

   ```bash
   sudo pcs property set maintenance-mode=false
   ```

7. Make sure that the Pacemaker cluster resources are running successfully.

### Scenario 3, Symptom 2: SAP HANA doesn't start because of replication failure

The SAP HANA resource experiences startup failures, and its `hana_xxx_roles` attribute shows `1:N:master1::worker:`. The `N` status indicates that the resource is out of sync and running in standalone mode. The database resource is neither primary nor secondary on any node.

When you run the `sudo pcs status --full` command, the `node attributes` status is shown as follows:

  ```bash
  sudo pcs status --full
  ```
  ```output
    Node Attributes:
    * Node: vm-mce-hana01 (1):
      * azName                            : vm-mce-hana01
      * azure-events-az_curNodeState      : AVAILABLE 
      * hana_XXX_clone_state              : PROMOTED  
      * hana_XXX_op_mode                  : logreplay 
      * hana_XXX_remoteHost               : vm-mce-hana02
      * hana_XXX_roles                    : 4:P:master1:master:worker:master
      * hana_XXX_site                     : Site1     
      * hana_XXX_srah                     : -         
      * hana_XXX_srmode                   : sync      
      * hana_XXX_sync_state               : PRIM      
      * hana_XXX_version                  : 2.00.083.00
      * hana_XXX_vhost                    : vm-mce-hana01
      * lpa_XXX_lpt                       : 1767866244
      * master-SAPHana_HN1_00             : 150       
    * Node: vm-mce-hana02 (2):
      * azName                            : vm-mce-hana02
      * hana_XXX_clone_state              : UNDEFINED 
      * hana_XXX_op_mode                  : logreplay 
      * hana_XXX_remoteHost               : vm-mce-hana01
      * hana_XXX_roles                    : 4:N:master1:master:worker:master
      * hana_XXX_site                     : Site2     
      * hana_XXX_srah                     : -         
      * hana_XXX_srmode                   : sync      
      * hana_XXX_sync_state               : SOK       
      * hana_XXX_version                  : 2.00.083.00
      * hana_XXX_vhost                    : vm-mce-hana02
      * lpa_XXX_lpt                       : 30  
  ```

This Migration summary indicates that the SAP HANA resource (SAPHana_XXX_00) failed to start on both nodes (vm-mce-hana01 and vm-mce-hana02). The fail count is set to 1000000 (infinity). 

  ```bash
  sudo pcs status
  ```
  ```output
  Migration Summary:
    * Node: vm-mce-hana01 (1):
      * SAPHana_HN1_00: migration-threshold=5000 fail-count=1 last-failure='Thu Jan  8 07:56:30 2026'
    * Node: vm-mce-hana02 (2):
      * SAPHana_HN1_00: migration-threshold=5000 fail-count=1000000 last-failure='Thu Jan  8 07:48:34 2026'

  Failed Resource Actions:
    * SAPHana_HN1_00_monitor_59000 on vm-mce-hana01 'promoted (failed)' (9): call=41, status='complete', last-rc-change='Thu Jan  8 07:56:30 2026', queued=0ms, exec=0ms
    * SAPHana_HN1_00_start_0 on vm-mce-hana02 'not running' (7): call=38, status='complete', last-rc-change='Thu Jan  8 07:48:34 2026', queued=0ms, exec=745ms
  ```

### Cause for scenario 3, symptom 2

This issue frequently occurs if the database is modified (manually stopped or started, replication is paused, and so on) while the cluster is in maintenance mode.

### Resolution for scenario 3, symptom 2

> [!Note]
> Steps 1 through 5 should be performed by an SAP administrator.

1. Before you make any changes, make sure that you have a backup or snapshot. For more information, see [Azure VM backup](/azure/backup/backup-azure-vms-introduction).
  
2. Put the cluster into maintenance mode:

    ```bash
    sudo pcs property set maintenance-mode=true
    ```

3. Manually start the database outside the cluster on the primary node:

    ```bash
    sudo HDB start
    ```

4. Start replication on the primary node. Replace `<site id>` as appropriate.

    ```bash
    sudo hdbnsutil -sr_enable --name=<site id>
    ```

5. Initialize replication on secondary node. Replace `<primary node>`, `<Instance id>` and `<side id>` as appropriate.

    ```bash
    sudo hdbnsutil -sr_register --remoteHost=<primary node> --remoteInstance=<Instance id> --replicationMode=sync --name=<site id>
    ```

6. Manually start the database outside the cluster on the secondary node: 
 
    ```bash
    sudo HDB start
    ```

7. Verify that replications are running as expected. To do this, run the following command on both nodes: 
  
    ```bash
    sudo hdbnsutil -sr_state
    ```

8. Remove the cluster from maintenance mode.

    ```bash
    sudo pcs property set maintenance-mode=false
    ```

9. Clear the fail count of the SAP HANA resource. Replace `<SAPHana resource name>` with your SAP Pacemaker cluster setup.

    ```bash
    sudo pcs resource cleanup <SAPHana resource name>
    ```

For more information about this scenario, see the following Red Hat article: [SAPHana Resource Experiencing Start Failures with hana_xxx_roles Reporting N (Standalone)'](https://access.redhat.com/solutions/7062225).

### Scenario 3, Symptom 3: SAP HANA resource doesn't start because of hdbdaemon issues

SAP HANA Resource Start Failure with error message as shown:

```output
'FAIL: process hdbdaemon HDB Daemon not running'
```

The `sudo pcs status --full` command can also be used to view this error, as it resulted the SAP HANA Pacemaker cluster resources failover error.

```output
Failed Resource Actions:
  * SAPHana_XXX_00_monitor_0 on vm-mce-hana01 'error' (1): call=25, status='complete', last-rc-change='Thu Jan  2 08:01:54 2026', queued=0ms, exec=1604ms
```

### Cause for scenario 3, symptom 3

A review of the `/var/log/messages` log indicates that `hbddaemon` didn't start because of the following error:

```output
Jan  2 08:01:54 vm-mce-hana01 SAPHana(SAPHana_HXXX_00)[5296]: ERROR: ACT: SAP HANA: Instance HN1-HDB00 start failed: #01202.01.2026 08:01:54#012WaitforStarted#012FAIL: process hdbdaemon HDB Daemon not running
Jan  2 08:01:55 vm-mce-hana01 SAPHana(SAPHana_XXX_00)[5314]: INFO: RA ==== end action start_clone with rc=1 (0.162.3) (22s)====
Jan  2 08:01:55 vm-mce-hana01 SAPHana(SAPHana_XXX_00)[5320]: error output [ tput: No value for $TERM and no -T specified ]
Jan  2 08:01:55 vm-mce-hana01 SAPHana(SAPHana_XXX_00)[5324]: error output [ tput: No value for $TERM and no -T specified ]
Jan  2 08:01:55 vm-mce-hana01 SAPHana(SAPHana_XXX_00)[5328]: error output [ tput: No value for $TERM and no -T specified ]
Jan  2 08:01:55 vm-mce-hana01 pacemaker-attrd[2161]: error output [ Error performing operation: No such device or address ]
Jan  2 08:01:55 vm-mce-hana01 SAPHana(SAPHana_XXX_00)[5339]: INFO: RA ==== end action start_clone with rc=1 (0.162.3) (22s)====
Jan  2 08:01:55 vm-mce-hana01 pacemaker-controld[2163]: notice: Result of start operation for SAPHana_XXX_00 on vm-mce-hana01: error
Jan  2 08:01:55 vm-mce-hana01 pacemaker-controld[2163]: notice: vm-mce-hana01-SAPHana_XXX_00_start_0:33 [ tput: No value for $TERM and no -T specified\ntput: No value for $TERM and no -T specified\ntput: No value for $TERM and no -T specified\nError performing operation: No such device or address\n ]
Jan  2 08:01:55 vm-mce-hana01 pacemaker-attrd[2161]: notice: Setting last-failure-SAPHana_XXX_00#start_0[vm-mce-hana01] in instance_attributes: (unset) -> 1767340915
Jan  2 08:01:55 vm-mce-hana01 pacemaker-attrd[2161]: notice: Setting fail-count-SAPHana_XXX_00#start_0[vm-mce-hana01] in instance_attributes: (unset) -> INFINITY
```

### Resolution for scenario 3, symptom 3

See the following Red Hat article: [SAPHana Resource Start Failure with Error 'FAIL: process hdbdaemon HDB Daemon not running'](https://access.redhat.com/solutions/7058526).

## Scenario 4: Issue that affects the ASCS and ERS resources

### Symptom for scenario 4

ASCS and ERS instances can't start under cluster control. The `/var/log/messages` log indicates The following errors:

```output
Jan  7 23:29:16 vm-mce-hana01 SAPHN1_01[340480]: Unable to change to Directory /usr/sap/RH2/ERS01/work. (Error 2 No such file or directory) [ntservsserver.cpp 3845]
Jan  7 23:29:16 vm-mce-hana01 SAPHN1_00[340486]: Unable to change to Directory /usr/sap/Rh2/ASCS01/work. (Error 2 No such file or directory) [ntservsserver.cpp 3845]
```

### Cause for scenario 4

Because of incorrect `InstanceName` and `START_PROFILE` attributes, the SAP instances such as ASCS and ERS, didn't start under cluster control. 

### Resolution for scenario 4

> [!Note]
> This resolution is applicable if `InstanceName` and `START_PROFILE` are separate files.

1. Before you make any changes, make sure that you have a backup or snapshot. For more information, see [Azure VM backup](/azure/backup/backup-azure-vms-introduction).
  
2. Put the cluster into maintenance mode:

    ```bash
    sudo pcs property set maintenance-mode=true
    ```

3. Verify the `pf(profile)` path from the `/usr/sap/sapservices` file:

    ```bash
    sudo cat /usr/sap/sapservices
    ```
    ```output
    LD_LIBRARY_PATH=/usr/sap/HN1/ASCS01/exe:$LD_LIBRARY_PATH;export LD_LIBRARY_PATH;/usr/sap/RH2/ASCS00/exe/sapstartsrv pf=/usr/sap/HN1/SYS/profile/START_ASCS01_nodeci -D -u rh2adm
    LD_LIBRARY_PATH=/usr/sap/HN1/ERS01/exe:$LD_LIBRARY_PATH;export LD_LIBRARY_PATH;/usr/sap/RH2/ERS10/exe/sapstartsrv pf=/usr/sap/HN1/ERS01/profile/START_ERS01_nodersvi -D -u rh2adm
    ```

4. Correct the `InstanceName` and `START_PROFILE` attribute values in the `SAPInstance` cluster configuration resource agent. 

    **Example:**

    ```bash
    sudo pcs resource update ASCS_RH2_ASCS01 InstanceName=HN1_ASCS01_nodeci START_PROFILE=/usr/sap/HN1/SYS/profile/START_ASCS01_nodeci
    ```
    
    Replace `HN1_ASCS01_nodeci` and `/usr/sap/HN1/SYS/profile/START_ASCS01_nodeci` with the appropriate values.

    ```bash
    sudo pcs resource update ERS_HN1_ERS01 InstanceName=HN1_ERS01_nodersvi START_PROFILE=/usr/sap/HN1/ERS01/profile/START_ERS01_nodersvi
    ```
    Replace `HN1_ERS01_nodersvi` and `/usr/sap/HN1/ERS01/profile/START_ERS01_nodersvi` with the appropriate values.

5.  Remove the cluster from maintenance mode:

    ```bash
    sudo pcs property set maintenance-mode=false
    ```

## Scenario 5: Fenced node doesn't rejoin cluster

### Symptom for scenario 5

After the fencing operation is finished, the affected node typically doesn't rejoin the Pacemaker Cluster, and both the Pacemaker and Corosync services remain stopped unless they are manually started to restore the cluster online.

### Cause for scenario 5

After the node is fenced and restarted and has restarted its cluster services, it subsequently receives a message that states, `We were allegedly just fenced`. This causes it to shut down its Pacemaker and Corosync services and prevent the cluster from starting. `vm-mce-hana01` initiates a STONITH action against vm-mce-hana02. At `03:27:23`, when the network issue is resolved, vm-mce-hana02 rejoins the Corosync membership. Consequently, a new two-node membership is established, as shown in `/var/log/messages` for `vm-mce-hana01`:

```output
Feb 20 03:26:56 vm-mce-hana01 corosync[1722]:  [TOTEM ] A processor failed, forming new configuration.
Feb 20 03:27:23 vm-mce-hana01 corosync[1722]:  [TOTEM ] A new membership (1.116f4) was formed. Members left: 2
Feb 20 03:27:24 vm-mce-hana01 corosync[1722]:  [QUORUM] Members[1]: 1
...
Feb 20 03:27:24 vm-mce-hana01 pacemaker-schedulerd[1739]: warning: Cluster node vm-mce-hana02 will be fenced: peer is no longer part of the cluster
...
Feb 20 03:27:24 vm-mce-hana01 pacemaker-fenced[1736]: notice: Delaying 'reboot' action targeting vm-mce-hana02 using  for 20s
Feb 20 03:27:25 vm-mce-hana01 corosync[1722]:  [TOTEM ] A new membership (1.116f8) was formed. Members joined: 2
Feb 20 03:27:25 vm-mce-hana01 corosync[1722]:  [QUORUM] Members[2]: 1 2
Feb 20 03:27:25 vm-mce-hana01 corosync[1722]:  [MAIN  ] Completed service synchronization, ready to provide service.
```

vm-mce-hana01 received confirmation that vm-mce-hana02 was successfully restarted, as shown in `/var/log/messages` for vm-mce-hana02.

```output
Feb 20 03:27:46 vm-mce-hana01 pacemaker-fenced[1736]: notice: Operation 'reboot' [43895] (call 28 from pacemaker-controld.1740) targeting vm-mce-hana02 using xvm2 returned 0 (OK)
```

To fully complete the STONITH action, the system had to deliver the confirmation message to every node. Because vm-mce-hana02 rejoined the group at `03:27:25` and no new membership that excluded vm-mce-hana02 was yet formed because of the token and consensus timeouts not expiring, the confirmation message is delayed until vm-mce-hana02 restarts its cluster services after startup. Upon receiving the message, vm-mce-hana02 recognizes that it has been fenced and, consequently, shut down its services as shown:

`/var/log/messages` in vm-mce-hana01:
```output
Feb 20 03:29:02 vm-mce-hana01 corosync[1722]:  [TOTEM ] A processor failed, forming new configuration.
Feb 20 03:29:10 vm-mce-hana01 corosync[1722]:  [TOTEM ] A new membership (1.116fc) was formed. Members joined: 2 left: 2
Feb 20 03:29:10 vm-mce-hana01 corosync[1722]:  [QUORUM] Members[2]: 1 2
Feb 20 03:29:10 vm-mce-hana01 pacemaker-fenced[1736]: notice: Operation 'reboot' targeting vm-mce-hana02 by vm-mce-hana01 for pacemaker-controld.1740@vm-mce-hana01: OK
Feb 20 03:29:10 vm-mce-hana01 pacemaker-controld[1740]: notice: Peer vm-mce-hana02 was terminated (reboot) by vm-mce-hana01 on behalf of pacemaker-controld.1740: OK
...
Feb 20 03:29:11 vm-mce-hana01 corosync[1722]:  [CFG   ] Node 2 was shut down by sysadmin
Feb 20 03:29:11 vm-mce-hana01 corosync[1722]:  [TOTEM ] A new membership (1.11700) was formed. Members left: 2
Feb 20 03:29:11 vm-mce-hana01 corosync[1722]:  [QUORUM] Members[1]: 1
Feb 20 03:29:11 vm-mce-hana01 corosync[1722]:  [MAIN  ] Completed service synchronization, ready to provide service.
```

`/var/log/messages` in vm-mce-hana02:
```output
Feb 20 03:29:11 [1155] vm-mce-hana02 corosync notice  [TOTEM ] A new membership (1.116fc) was formed. Members joined: 1
Feb 20 03:29:11 [1155] vm-mce-hana02 corosync notice  [QUORUM] Members[2]: 1 2
Feb 20 03:29:09 vm-mce-hana02 pacemaker-controld  [1323] (tengine_stonith_notify)  crit: We were allegedly just fenced by vm-mce-hana01 for vm-mce-hana01!
```

### Resolution for scenario 5

Configure a startup delay for the Crosync service. This pause provides sufficient time for a new Closed Process Group (CPG) membership to form and exclude the fenced node so that the STONITH restart process can finish by making sure the completion message reaches all nodes in the membership.

To achieve this effect, run the following commands:

1. Put the cluster into maintenance mode:

    ```bash
    sudo pcs property set maintenance-mode=true
    ```
2. Create a systemd drop-in file on all the nodes in the cluster:

- Edit the Corosync file:
  ```bash 
   sudo systemctl edit corosync.service
  ```
- Add the following lines:
  ```config
  [Service]
  ExecStartPre=/bin/sleep 60
  ```
- After you save the file and exit the text editor, reload the systemd manager configuration:
  ```bash
  sudo systemctl daemon-reload
  ```
3. Remove the cluster from maintenance mode:
  ```bash
  sudo pcs property set maintenance-mode=false
  ```
For more information refer to [Fenced Node Fails to Rejoin Cluster Without Manual Intervention](https://access.redhat.com/solutions/5644441)

## Next steps

For additional help, open a support request by using the following instructions. When you submit your request, attach the [SOS report](https://access.redhat.com/solutions/3592) from all the nodes in the cluster for troubleshooting.

 

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
