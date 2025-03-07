---
title: Troubleshoot RHEL Pacemaker Cluster Services and Resources Startup Issues in Azure
description: Provides troubleshooting guidance for issues related to cluster resources or services in RedHat Enterprise Linux (RHEL)) Pacemaker Cluster
ms.reviewer: rnirek,srsakthi
ms.author: rnirek
author: skarthikeyan7-msft 
ms.topic: troubleshooting
ms.date: 02/24/2025
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
  Cluster name: my_cluster
  Status of pacemakerd: 'Pacemaker is running' (last updated 2024-06-25 16:34:49 -04:00)
  Cluster Summary:
  * Stack: corosync
  * **Current DC: NONE**
  * Last updated: Tue Jun 25 14:34:49 2024
  * Last change:  Tue Jun 25 14:29:51 2024 by root via cibadmin on node-0
  * 2 nodes configured
  * 9 resource instances configured

  Node List:
  * **Node node-0: UNCLEAN (offline)**
  * **Node node-1: UNCLEAN (offline)**
  ```

- `sudo pcs quorum status` returns the following error message:

  ```bash
  sudo pcs quorum status
  ```
  ```output
  Error: Unable to get quorum status: Unable to start votequorum status tracking: CS_ERR_BAD_HANDLE
  Check for the error: Corosync quorum is not configured in /var/log/messeges:
  Jun 16 11:17:53 node-0 pacemaker-controld[509433]: error: Corosync quorum is not configured
  ```

### Cause for scenario 1

The **VoteQuorum** service is a component of the corosync project. To prevent split-brain scenarios, this service can be optionally loaded into a corosync cluster's nodes. Every system in the cluster is given a certain number of votes to achieve this quorum. This makes sure that cluster actions can occur only if most votes are cast. Either every node or no node must have the service loaded. The outcomes are uncertain if the service is loaded into a subset of cluster nodes.

The following `/etc/corosync/corosync.conf` setting enables **VoteQuorum** service within corosync:

```output
quorum {
    provider: corosync_votequorum
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
    cluster_name: my_cluster
    transport: knet
    token: 30000
    crypto_cipher: aes256
    crypto_hash: sha256
    cluster_uuid: afd62fe2045b43b9a102de76fdf4659a
    }
    nodelist {
    node {
        ring0_addr: node-0
        name: node-0
        nodeid: 1
    }

    node {
        ring0_addr: node-1
        name: node-1
        nodeid: 2
    }
    }

    **quorum {
    provider: corosync_votequorum
    two_node: 1
    }**

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

The following error entries are logged in `/var/log/pacemaker.log`:

```output
25167 IPaddr2(VIP)[16985]:    2024/09/07_15:44:19 ERROR: Unable to find nic or netmask.
25168 IPaddr2(VIP)[16985]:    2024/09/07_15:44:19 ERROR: [findif] failed
```

The error can also be observed while running `sudo pcs status`:

```bash
sudo pcs status
```
```output
vip_HN1_03_start_0 on node-1 'unknown error' (1): call=30, status=complete, exit-reason='[findif] failed', last-rc-change='Thu Jan 07 17:25:52 2025', queued=0ms, exec=57ms
```

### Cause for scenario 2

1. To choose which network adapter (NIC) to start the `IPAddr2` resource on, `IPaddr2` invokes the `findif()` function, as defined in `/usr/lib/ocf/resource.d/heartbeat/IPaddr2` that is contained in the `resource-agents` package.

2. The correct network adapter is determined by the options that are set on the `IPAddr2` resource, such as `ip` (required), `cidr_netmask`, and `broadcast`.

    For example:

    Check the `IPaddr2` settings:

    ```bash
    sudo pcs resource show vip_HN1_03
    ```
    ```output
    Resource: vip_HN1_03 (class=ocf provider=heartbeat type=IPaddr2)
    Attributes: ip=172.17.10.10 cidr_netmask=24 nic=ens6
    Operations: start interval=0s timeout=20s (vip_HN1_03-start-timeout-20s)
                stop interval=0s timeout=20s (vip_HN1_03-stop-timeout-20s)
                monitor interval=10s timeout=20s (vip_HN1_03-monitor-interval-10s)
    ```

3. Try to determine the `NIC` information manually. In this example, based on the IP address and netmask, we can successfully find `ens6` from the route table:

    ```bash
    sudo ip -o -f inet route list match 172.17.10.10/24 scope link
    ```
    ```output
    172.17.10.0/24 dev ens6 proto kernel src 172.17.10.7 
    ```

4. In a situation in which `NIC (ens6)` is down, you can't manually find the `NIC` information, and that might cause `[findif]` to fail. Replace `172.17.10.10/24` and `ens6` as appropriate.

    ```bash
    sudo ip link set ens6 down
    ```
    ```bash
    sudo ip -o -f inet route list match 172.17.10.10/24 scope link 
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
    sudo pcs resource update vip_HN1_03 nic=ens6
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
    sudo pcs resource show vip_HN1_03
    ```
    ```output
    Warning: This command is deprecated and will be removed. Please use 'pcs resource config' instead.
    Resource: vip_HN1_03 (class=ocf provider=heartbeat type=IPaddr2)
      Attributes: cidr_netmask=32 ip=172.17.223.36 nic=vlan10
      Meta Attrs: resource-stickiness=INFINITY
      Operations: monitor interval=10s timeout=20s (vip_HN1_03-monitor-interval-10s)
                  start interval=0s timeout=20s (vip_HN1_03-start-interval-0s)
                  stop interval=0s timeout=20s (vip_HN1_03-stop-interval-0s)
    ```

For more information about this scenario, see the following Red Hat article: ["ERROR: [findif] failed" shown in Pacemaker'](https://access.redhat.com/solutions/2119711).

## Scenario 3: Issue in SAP HANA (High-performance Analytic Appliance)

### Scenario 3, Symptom 1: SAP HANA DB doesn't start and generates an unknown error

SAP HANA DB doesn't start, and it returns an `unknown error` error message.

1. In the `/var/log/messages` log section, an `SRHOOK=SFAIL` entry is logged. This indicates that the cluster nodes are out of sync.
2. The secondary cluster node is in `WAITING4PRIM` status.

    ```bash
    sudo pcs status --full
    ```
    ```output
    * Node node-0 (1):
        + hana_XXX_clone_state              : PROMOTED  
        + hana_XXX_sync_state               : PRIM      
        + hana_XXX_roles                    : 2:P:master1:master:worker:slave

    * Node node-1 (2):
        + hana_XXX_clone_state              : WAITING4PRIM  
        + hana_XX_sync_state                : SFAIL      
        + hana_XXX_roles                    : 2:S:master1:master:worker:slave
    ```

3. When you run `sudo pcs status`, the cluster status is shown as follows:

    ```bash
    sudo pcs status
    ```
    ```output
    2 nodes configured
    8 resources configured

    Online: [ node-0 node-1 ]

    Full list of resources:

      rsc_st_azure	(stonith:fence_azure_arm):	Started node-1
      Clone Set: cln_SAPHanaTopology [rsc_SAPHanaTopology]
          Started: [ node-0 node-1 ]
      Master/Slave Set: msl_SAPHana [rsc_SAPHana]
          Master: [ node-1 ]
          Slave:  [ node-0 ]
      Resource Group: g_ip_HN1_HBD00
          vip_HN1_HBD00	(ocf::heartbeat:IPaddr2):	Started node-0 
          nc_HN1_HBD00	(ocf::heartbeat:azure-lb):	Started node-0 

            
    Failed Resource Actions:
    * rsc_SAPHana_monitor_61000 on node-0 'unknown error' (1): call=32, status=complete, exitreason='',
        last-rc-change='Sat May 22 09:29:20 2021', queued=0ms, exec=0ms
    * rsc_SAPHana_start_0 on node-1 'not running' (7): call=55, status=complete, exitreason='',
        last-rc-change='Sat May 22 09:36:32 2021', queued=0ms, exec=3093ms
    ```

### Cause for scenario 3, symptom 1

Pacemaker can't start the SAP HANA resource if there are `SYN` failures between the primary and secondary nodes:

```bash
sudo SAPHanaSR-showAttr
```
```output
Global cib-time                 maintenance
--------------------------------------------
global Fri Aug 23 11:47:32 2024 false

Hosts	clone_state	lpa_fh9_lpt	node_state	op_mode	        remoteHost  	  roles		            score	 site   srmode	sync_state	version         vhost
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
node-0	DEMOTED		10		online		logreplay	node-1 	4:S:master1:master:worker:master	5	SITEA	syncmem	SOK	2.00.046.00.1581325702	node-0
node-1	PROMOTED	1693237652	online		logreplay	node-0 	4:P:master1:master:worker:master	150	SITEA	syncmem	PRIM	2.00.046.00.1581325702	node-1
```

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

   b. Run `HDB info` on each node to check the SAP-related processes that are running in the node. The SAP administrator should be able to confirm that the required process are running on both of the nodes.
      
      ```bash
      HDB info
      ```
      ```output
      USER        PID   PPID %CPU    VSZ   RSS COMMAND
      a00adm     5183   5178  0.0  87684  1804 sshd: a00adm@pts/0
      a00adm     5184   5183  0.0  14808  3624  \_ -sh
      a00adm     5994   5184  0.0  13200  1824      \_ /bin/sh /usr/sap/A00/HDB00/HDB info
      a00adm     6019   5994  0.0  26668  1356          \_ ps fx -U a00adm -o user,pid,ppid,pcpu,vsz,rss,args
      a00adm     5369      1  0.0  20932  1644 sapstart pf=/usr/sap/A00/SYS/profile/A00_HDB00_node-0
      a00adm     5377   5369  1.8 582944 292720  \_ /usr/sap/A00/HDB00/node-0/trace/hdb.sapA00_HDB00 -d -nw -f /usr/sap/A00/HDB00/node-0/daemon.ini pf=/usr/sap/A00/SYS/profile/A00_HDB00_node-0
      a00adm     5394   5377  9.3 3930388 1146444      \_ hdbnameserver
      a00adm     5548   5377 21.3 2943472 529672      \_ hdbcompileserver
      a00adm     5550   5377  4.4 2838792 465664      \_ hdbpreprocessor
      a00adm     5571   5377 91.6 7151116 4019640      \_ hdbindexserver
      a00adm     5573   5377 21.8 4323488 1203128      \_ hdbxsengine
      a00adm     5905   5377 18.9 3182120 710680      \_ hdbwebdispatcher
      a00adm     2104      1  0.0 428748 27760 /usr/sap/A00/HDB00/exe/sapstartsrv pf=/usr/sap/A00/SYS/profile/A00_HDB00_node-0 -D -u a00adm
      a00adm     2004      1  0.0  31844  2352 /usr/lib/systemd/systemd --user
      a00adm     2008   2004  0.0  63796  2620  \_ (sd-pam)
      ```
    
   c. If the SAP DB and services aren't active on the node, we recommend that you contact your SAP administrator to review and stop the SAP DB services, first in the secondary node and then in the primary node:

      ```bash
      sudo HDB stop
      ```
      or:

      ```bash
      sudo sapcontrol -nr <SAPInstanceNo> -function stop
      ```
    
   d. After the stop operation finishes, start HANA DB in the primary node and then in the secondary node. Modify `<SAPInstanceNo>` as appropriate.

      ```bash
      sudo HDB start
      ```
      or:
    
      ```bash
      sudo sapcontrol -nr <SAPInstanceNo> -function start
      ```
4. If the database nodes are still not synchronized, the SAP administrator should troubleshoot the issue by reviewing the SAP logs to make sure that the database nodes are correctly synchronized.

    > [!NOTE]
    > The SAP administrator must determine which node should be designated as the primary and which as the secondary to make sure that no database data is lost in the process.

5. After you enable replication, check the system replication status by using the SAP system administrator account. In this situation, the user admin account is `hn1adm`.

   On the primary node, verify that the overall system replication status is `ACTIVE`.

   If the database nodes are still not synchronized, the SAP administrator should troubleshoot the issue by reviewing the SAP logs to make sure that the database nodes are correctly synchronized:

   ```bash
   sudo su - hn1adm -c "python /usr/sap/HN1/HDB03/exe/python_support/systemReplicationStatus.py"
   ```
   ```output
   | Host   | Port  | Service Name | Volume ID | Site ID | Site Name | Secondary | Secondary | Secondary | Secondary | Secondary     | Replication | Replication | Replication    |
   |        |       |              |           |         |           | Host      | Port      | Site ID   | Site Name | Active Status | Mode        | Status      | Status Details | 
   | ------ | ----- | ------------ | --------- | ------- | --------- | --------- | --------- | --------- | --------- | ------------- | ----------- | ----------- | -------------- |
   | node-0 | 30007 | xsengine     |         2 |       1 | node-0    | sapn2     |     30007 |         2 | node-1     | YES          | SYNC        | ACTIVE      |                |
   | node-0 | 30001 | nameserver   |         1 |       1 | node-0    | sapn2     |     30001 |         2 | node-1     | YES          | SYNC        | ACTIVE      |                |
   | node-0 | 30003 | indexserver  |         3 |       1 | node-0    | sapn2     |     30003 |         2 | node-1     | YES          | SYNC        | ACTIVE      |                |

   status system replication site "2": ACTIVE
   overall system replication status: ACTIVE

   Local System Replication State
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     mode: PRIMARY
     site id: 1
     site name: node-0
   ```

6. Verify the SAP HANA system replication status again by running the following command:

   ```bash
   sudo SAPHanaSR-showAttr
   ```
   ```output
   Global cib-time                 maintenance
   --------------------------------------------
   global Mon Oct 14 10:25:51 2024 false
  
   Hosts	clone_state	lpa_fh9_lpt	node_state	op_mode	        remoteHost  	  roles		            score	 site   srmode	sync_state	version         vhost
   ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   node-0	DEMOTED		10		online		logreplay	node-1 	4:S:master1:master:worker:master	5	SITEA	syncmem	SOK	2.00.046.00.1581325702	node-0
   node-1	PROMOTED	1693237652	online		logreplay	node-0 	4:P:master1:master:worker:master	150	SITEA	syncmem	PRIM	2.00.046.00.1581325702	node-1
   ```

7. Exit the SAP Admin account, and then remove the cluster from maintenance mode:

   ```bash
   sudo pcs property set maintenance-mode=false
   ```

8. Make sure that the Pacemaker cluster resources are running successfully.

### Scenario 3, Symptom 2: SAP HANA doesn't start because of replication failure

The SAP HANA resource experiences startup failures, and its `hana_xxx_roles` attribute shows `1:N:master1::worker:`. The `N` status indicates that the resource is out of sync and running in standalone mode. The database resource is neither primary nor secondary on any node.

When you run the `sudo pcs status --full` command, the `node attributes` status is shown as follows:

  ```bash
  sudo pcs status --full
  ```
  ```output
  Node Attributes:
    * Node: node-0 (1):
      * hana_XXX_clone_state            : UNDEFINED
      * hana_XXX_op_mode			          : logreplay
      * hana_XXX_remoteHost             : node-1
      * hana_XXX_roles                  : 1:N:master1::worker:
      * hana_XXX_site                   : SITE1    
      * hana_XXX_srah                   : -        
      * hana_XXX_srmode                 : sync     
      * hana_XXX_version                : 2.00.079.00
      * hana_XXX_vhost                  : node-0
      * lpa_XXX_lpt                     : 10       
    * Node: node-1 (2):
      * hana_XXX_clone_state            : UNDEFINED
      * hana_XXX_op_mode                : logreplay
      * hana_XXX_remoteHost             : node-0
      * hana_XXX_roles                  : 4:N:master1:master:worker:master
      * hana_XXX_site                   : SITE2
      * hana_XXX_sra                    : -        
      * hana_XXX_srah                   : -        
      * hana_XXX_srmode                 : sync     
      * hana_XXX_sync_state		          : PRIM     
      * hana_XXX_version			          : 2.00.079.00
      * hana_XXX_vhost				          : node-1
      * lpa_XXX_lpt				              : 1733552029
      * master-SAPHana_XXX_00		        : 150
  ```

This Migration summary indicates that the SAP HANA resource (SAPHana_XXX_00) failed to start on both nodes (node-0 and node-1). The fail count is set to 1000000 (infinity). 

  ```bash
  sudo pcs status
  ```
  ```output
  Migration Summary:
    * Node: node-0 (1):
      * SAPHana_XXX_00: migration-threshold=1000000 fail-count=1000000 last-failure='Sat Dec  7 15:17:16 2024'
    * Node: node-1 (2):
      * SAPHana_XXX_00: migration-threshold=1000000 fail-count=1000000 last-failure='Sat Dec  7 15:48:57 2024'

  Failed Resource Actions:
    * SAPHana_XXX_00_start_0 on node-1 'not running' (7): call=74, status='complete', last-rc-change='Sat Dec  7 15:17:14 2024', queued=0ms, exec=1715ms
    * SAPHana_XXX_00_start_0 on node-0 'not running' (7): call=30, status='complete', last-rc-change='Sat Dec  7 15:49:12 2024', queued=0ms, exec=1680ms
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

5. Initialize replication on secondary node. Replace `<primary node>`, `<Instance ##>` and `<side id>` as appropriate.

    ```bash
    sudo hdbnsutil -sr_register --remoteHost=<primary node> --remoteInstance=<Instance ##> --replicationMode=syncmem --name=<site id>
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

The `sudo pcs status --full` command can also be used to view this error, as it also resulted the SAP HANA Pacemaker cluster resources failover error.

```output
Failed Resource Actions:
  * SAPHana_XXX_00_start_0 on node-0 'error' (1): call=44, status='complete', exitreason='', last-rc-change='2024-07-07 06:15:45 -08:00', queued=0ms, exec=51659ms
```

### Cause for scenario 3, symptom 3

A review of the `/var/log/messages` log indicates that `hbddaemon` didn't start because of the following error:

```output
Jun  7 02:25:09 node-0 SAPHana(SAPHana_XXX_00)[12336]: ERROR: ACT: SAPHana Instance ECR-HDB00 start failed: #01201.03.2024 02:25:09#012WaitforStarted#012FAIL: process hdbdaemon HDB Daemon not running
Jun  7 02:25:09 node-0 SAPHana(SAPHana_XXX_00)[12336]: INFO: RA ==== end action start_clone with rc=1 (0.154.0) (25s)====
Jun  7 02:25:09 node-0 pacemaker-execd[8567]: notice: SAPHana_XXX_00_start_0[12336] error output [ tput: No value for $TERM and no -T specified ]
Jun  7 02:25:09 node-0 pacemaker-execd[8567]: notice: SAPHana_XXX_00_start_0[12336] error output [ tput: No value for $TERM and no -T specified ]
Jun  7 02:25:09 node-0 pacemaker-execd[8567]: notice: SAPHana_XXX_00_start_0[12336] error output [ tput: No value for $TERM and no -T specified ]
Jun  7 02:25:09 node-0 pacemaker-execd[8567]: notice: SAPHana_XXX_00_start_0[12336] error output [ Error performing operation: No such device or address ]
Jun  7 02:25:09 node-0 pacemaker-controld[8570]: notice: Result of start operation for SAPHana_XXX_00 on node-0: error
Jun  7 02:25:09 node-0 pacemaker-controld[8570]: notice: node-0-SAPHana_XXX_00_start_0:33 [ tput: No value for $TERM and no -T specified\ntput: No value for $TERM and no -T specified\ntput: No value for $TERM and no -T specified\nError performing operation: No such device or address\n ]
Jun  7 02:25:09 node-0 pacemaker-attrd[8568]: notice: Setting fail-count-SAPHana_XXX_00#start_0[node-0]: (unset) -> INFINITY
Jun  7 02:25:09 node-0 pacemaker-attrd[8568]: notice: Setting last-failure-SAPHana_XXX_00#start_0[node-0]: (unset) -> 1709288709
```

### Resolution for scenario 3, symptom 3

See the following Red Hat article: [SAPHana Resource Start Failure with Error 'FAIL: process hdbdaemon HDB Daemon not running'](https://access.redhat.com/solutions/7058526).

## Scenario 4: Issue that affects the ASCS and ERS resources

### Symptom for scenario 4

ASCS and ERS instances can't start under cluster control. The `/var/log/messages` log indicates The following errors:

```output
Jun  9 23:29:16 nodeci SAPRh2_10[340480]: Unable to change to Directory /usr/sap/RH2/ERS10/work. (Error 2 No such file or directory) [ntservsserver.cpp 3845]
Jun  9 23:29:16 nodeci SAPRH2_00[340486]: Unable to change to Directory /usr/sap/Rh2/ASCS00/work. (Error 2 No such file or directory) [ntservsserver.cpp 3845]
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
    LD_LIBRARY_PATH=/usr/sap/RH2/ASCS00/exe:$LD_LIBRARY_PATH;export LD_LIBRARY_PATH;/usr/sap/RH2/ASCS00/exe/sapstartsrv pf=/usr/sap/RH2/SYS/profile/START_ASCS00_nodeci -D -u rh2adm
    LD_LIBRARY_PATH=/usr/sap/RH2/ERS10/exe:$LD_LIBRARY_PATH;export LD_LIBRARY_PATH;/usr/sap/RH2/ERS10/exe/sapstartsrv pf=/usr/sap/RH2/ERS10/profile/START_ERS10_nodersvi -D -u rh2adm
    ```

4. Correct the `InstanceName` and `START_PROFILE` attribute values in the `SAPInstance` cluster configuration resource agent. 

    **Example:**

    ```bash
    sudo pcs resource update ASCS_RH2_ASCS00 InstanceName=RH2_ASCS00_nodeci START_PROFILE=/usr/sap/RH2/SYS/profile/START_ASCS00_nodeci
    ```
    
    Replace `RH2_ASCS00_nodeci` and `/usr/sap/RH2/SYS/profile/START_ASCS00_nodeci` with the appropriate values.

    ```bash
    sudo pcs resource update ERS_RH2_ERS10 InstanceName=RH2_ERS10_nodersvi START_PROFILE=/usr/sap/RH2/ERS10/profile/START_ERS10_nodersvi
    ```
    Replace `RH2_ERS10_nodersvi` and `/usr/sap/RH2/ERS10/profile/START_ERS10_nodersvi` with the appropriate values.

5.  Remove the cluster from maintenance mode:

    ```bash
    sudo pcs property set maintenance-mode=false
    ```

## Scenario 5: Fenced node doesn't rejoin cluster

### Symptom for scenario 5

After the fencing operation is finished, the affected node typically doesn't rejoin the Pacemaker Cluster, and both the Pacemaker and Corosync services remain stopped unless they are manually started to restore the cluster online.

### Cause for scenario 5

After the node is fenced and restarted and has restarted its cluster services, it subsequently receives a message that states, `We were allegedly just fenced`. This causes it to shut down its Pacemaker and Corosync services and prevent the cluster from starting. Node1 initiates a STONITH action against node2. At `03:27:23`, when the network issue is resolved, node2 rejoins the Corosync membership. Consequently, a new two-node membership is established, as shown in `/var/log/messages` for node1:

```output
Feb 20 03:26:56 node1 corosync[1722]:  [TOTEM ] A processor failed, forming new configuration.
Feb 20 03:27:23 node1 corosync[1722]:  [TOTEM ] A new membership (1.116f4) was formed. Members left: 2
Feb 20 03:27:24 node1 corosync[1722]:  [QUORUM] Members[1]: 1
...
Feb 20 03:27:24 node1 pacemaker-schedulerd[1739]: warning: Cluster node node2 will be fenced: peer is no longer part of the cluster
...
Feb 20 03:27:24 node1 pacemaker-fenced[1736]: notice: Delaying 'reboot' action targeting node2 using  for 20s
Feb 20 03:27:25 node1 corosync[1722]:  [TOTEM ] A new membership (1.116f8) was formed. Members joined: 2
Feb 20 03:27:25 node1 corosync[1722]:  [QUORUM] Members[2]: 1 2
Feb 20 03:27:25 node1 corosync[1722]:  [MAIN  ] Completed service synchronization, ready to provide service.
```

Node1 received confirmation that node2 was successfully restarted, as shown in `/var/log/messages` for node2.

```output
Feb 20 03:27:46 node1 pacemaker-fenced[1736]: notice: Operation 'reboot' [43895] (call 28 from pacemaker-controld.1740) targeting node2 using xvm2 returned 0 (OK)
```

To fully complete the STONITH action, the system had to deliver the confirmation message to every node. Because node2 rejoined the group at `03:27:25` and no new membership that excluded node2 was yet formed because of the token and consensus timeouts not expiring, the confirmation message is delayed until node2 restarts its cluster services after startup. Upon receiving the message, node2 recognizes that it has been fenced and, consequently, shut down its services as shown:

`/var/log/messages` in node1:
```output
Feb 20 03:29:02 node1 corosync[1722]:  [TOTEM ] A processor failed, forming new configuration.
Feb 20 03:29:10 node1 corosync[1722]:  [TOTEM ] A new membership (1.116fc) was formed. Members joined: 2 left: 2
Feb 20 03:29:10 node1 corosync[1722]:  [QUORUM] Members[2]: 1 2
Feb 20 03:29:10 node1 pacemaker-fenced[1736]: notice: Operation 'reboot' targeting node2 by node1 for pacemaker-controld.1740@node1: OK
Feb 20 03:29:10 node1 pacemaker-controld[1740]: notice: Peer node2 was terminated (reboot) by node1 on behalf of pacemaker-controld.1740: OK
...
Feb 20 03:29:11 node1 corosync[1722]:  [CFG   ] Node 2 was shut down by sysadmin
Feb 20 03:29:11 node1 corosync[1722]:  [TOTEM ] A new membership (1.11700) was formed. Members left: 2
Feb 20 03:29:11 node1 corosync[1722]:  [QUORUM] Members[1]: 1
Feb 20 03:29:11 node1 corosync[1722]:  [MAIN  ] Completed service synchronization, ready to provide service.
```

`/var/log/messages` in node2:
```output
Feb 20 03:29:11 [1155] node2 corosync notice  [TOTEM ] A new membership (1.116fc) was formed. Members joined: 1
Feb 20 03:29:11 [1155] node2 corosync notice  [QUORUM] Members[2]: 1 2
Feb 20 03:29:09 node2 pacemaker-controld  [1323] (tengine_stonith_notify)  crit: We were allegedly just fenced by node1 for node1!
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

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
