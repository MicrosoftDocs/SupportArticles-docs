---
title: Troubleshoot RHEL pacemaker cluster services and resources startup issues Azure
description: Provides troubleshooting guidance for issues related to cluster resources or services in RHEL(RedHat Enterprise Linux) Pacemaker cluster
ms.reviewer: rnirek,srsakthi
ms.author: skarthikeyan
author: skarthikeyan
ms.topic: troubleshooting
ms.date: 01/22/2025
ms.service: azure-virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker clustering, and fencing
---

# Troubleshoot startup issues for Pacemaker Cluster services and resources

**Applies to:** :heavy_check_mark: Linux VMs

This article outlines the most common causes of RedHat Enterprise Linux (RHEL) pacemaker cluster resources or services startup problems along with guidance on how to identify and resolve them.

## Scenario 1: Unable to start cluster service due to quorum

###  Symptom of scenario 1

- Cluster node fails to join cluster after cluster restart.
- Nodes are reported as `UNCLEAN (offline)`
- Current DC shows as `NONE`

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

- `sudo pcs quorum status` results in following error:

```bash
sudo pcs quorum status
```
```output
Error: Unable to get quorum status: Unable to start votequorum status tracking: CS_ERR_BAD_HANDLE
Check for the error: Corosync quorum is not configured in /var/log/messeges:
Jun 16 11:17:53 node-0 pacemaker-controld[509433]: error: Corosync quorum is not configured
```

### Cause of scenario 1

The **VoteQuorum** service is a component of the corosync project. To prevent split-brain scenarios, this service can be optionally loaded into a corosync cluster's nodes. Each system in the cluster is given a certain number of votes to achieve this quorum. Ensuring that cluster actions can only occur when the majority of votes are cast. Either every node must have the service loaded, or none at all. The outcomes are uncertain if it loaded into a subset of cluster nodes.

The following `/etc/corosync/corosync.conf` extract will enable **VoteQuorum** service within corosync:

```output
       quorum {
           provider: corosync_votequorum
       }
```

**VoteQuorum** reads its configuration from `/etc/corosync/corosync.conf`. Some values can be changed at runtime and others are only read at corosync startup. It's important that those values are consistent across all the nodes participating in the cluster or vote quorum behavior are unpredictable.

### Resolution of scenario 1

1. As a precaution takes a full backup or snapshot before making any changes. Refer this document to know more about [Azure VM backup](/azure/backup/backup-azure-vms-introduction).

2. Check for missing quorum stanza in `/etc/corosync/corosync.conf`. Compare the existing `corosync.conf` with any of the available backup present under `/etc/corosync/`.
   
3. Put the cluster under maintenance-mode.

```bash
sudo pcs property set maintenance-mode=true
```

4. Update the changes in `/etc/corosync/corosync.conf`.

Example for two node cluster:

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

5. Put the cluster out of maintenance-mode.

```bash
sudo pcs property set maintenance-mode=false
```

6. Sync the cluster:

```bash
sudo pcs cluster sync
```

7. Reload corosync.

```bash
sudo pcs cluster reload corosync
```

## Scenario 2: Issue with cluster VIP resource

### Symptom of scenario 2

Virtual IP resource (`IPaddr2` resource) failed to start or stop in pacemaker.
The messages can be identified under `/var/log/pacemaker.log` as shown:

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

### Cause of scenario 2

1. To choose which network interface to launch the `IPAddr2` resource on, `IPaddr2` invokes the `findif()` function as defined in `/usr/lib/ocf/resource.d/heartbeat/IPaddr2` (belongs to the `resource-agents` package).

2. The correct `NIC`(Network Interface Card) is determined by options set on the `IPAddr2` resource, such as `ip` (required), `cidr_netmask`, and `broadcast`.

*For example:*

Check the `IPaddr2` settings,

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

3. Try to determine `NIC` information manually. In this example, based on the ip address and netmask, we can successfully find `ens6` from route table.

```bash
sudo ip -o -f inet route list match 172.17.10.10/24 scope link
```
```output
172.17.10.0/24 dev ens6 proto kernel src 172.17.10.7 
```

4. In case if the `NIC (ens6)` is down, we couldn't manually find the `NIC` information, and that might lead to `[findif]` failed:

```bash
sudo ip link set ens6 down
```
```bash
sudo ip -o -f inet route list match 172.17.10.10/24 scope link 
```
> [!Note]
> Replace `172.17.10.10/24` and `ens6` accordingly.

### Resolution of scenario 2

If route that matches the `VIP` isn't in the default routing table, then one can specify the `NIC` name in pacemaker resource, so that it can be configured bypassing the check:

1. As a precaution takes a full backup or snapshot before making any changes. Refer this document to know more about [Azure VM backup](/azure/backup/backup-azure-vms-introduction).

2. Put the cluster under maintenance-mode.
   
```bash
sudo pcs property set maintenance-mode=true
```

3. Update the `NIC` resources are shown:

```bash
sudo pcs resource update vip_HN1_03 nic=ens6
```

4. Restart the `NIC `resources.

```bash
sudo pcs resource restart vip_HN1_03
```
```output
vip_HN1_03 successfully restarted
```

5. Put the cluster out of `maintenance-mode`.

```bash
sudo pcs property set maintenance-mode=false
```

6. Verify the `IP` resource as shown:

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

For more information about this scenario, you can see the following Red Hat article: ["ERROR: [findif] failed" shown in Pacemaker'](https://access.redhat.com/solutions/2119711).

## Scenario 3: Issue with SAP HANA(High-performance Analytic Appliance)

### Scenario 3 Symptom 1: SAP HANA DB fails to start with unknown error

SAP HANA DB fails to start with `unknown error`.

1. From the `/var/log/messages`, we can see `SRHOOK=SFAIL` indicating the cluster nodes are out of sync.
2. Secondary cluster node is in `WAITING4PRIM` status.

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

3. The cluster's status is shown as follows when we execute `sudo pcs status`:

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

#### Cause 1

Pacemaker can't start SAP HANA resource when there are `SYN` failures between primary and secondary nodes.

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

#### Resolution 1

SAP HANA resource can't be start by pacemaker when there are `SYN` failures between primary and secondary cluster nodes. To mitigate this issue, we must manually enable `SYN` between the primary and secondary nodes.

> [!Important]
> Steps 2,3 & 4 are to be performed using SAP administrator account as these steps involve using SAP System ID to stop, start and re-enable replication manually.

1. As a precaution takes a full backup or snapshot before making any changes. Refer this document to know more about [Azure VM backup](/azure/backup/backup-azure-vms-introduction).

2. Put the cluster under maintenance-mode.

    ```bash
    sudo pcs property set maintenance-mode=true
    ```
    
3. Check SAP HANA DB and processes state. 

   a. Verify that both the primary and secondary nodes are running the SAP database and related SAP processes, with one functioning as the primary and the other as the secondary, ensuring that the databases on both nodes remain synchronized.

   b. Run `HDB info` on each node to check the SAP related processes running in the node. SAP Admin should be able to confirm if the required process are running on both of the nodes.
      
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
    
   c. If SAP DB and services aren't active on the node, it is advised to reach out to your SAP admin to review and stop the SAP DB services in secondary node first and then in primary node.

    ```bash
    sudo HDB stop
    ```
    or
    ```bash
    sudo sapcontrol -nr <SAPInstanceNo> -function stop
    ```
    
   d. Once stop operation is completed, Start HANA DB in primary and then in secondary node.

    ```bash
    sudo HDB start
    ```
    or
   
    ```bash
    sudo sapcontrol -nr <SAPInstanceNo> -function start
    ```
> [!Note]
> Modify `<SAPInstanceNo>` accordingly.

4. If the database nodes are still not synchronized, the SAP administrator should troubleshoot the issue by reviewing SAP logs and ensuring the database nodes are properly synchronized.

> [!Caution]
> The SAP administrator must determine which node should be designated as the primary and which as the secondary, ensuring no database data is lost in the process.

5. After enabling replication, check the system replication status using SAP system admin account. In this case, the user admin account is `hn1adm`.

   From the primary node, check if overall system replication status: `ACTIVE`.
   If the database nodes are still not synchronized, the SAP administrator should troubleshoot the issue by reviewing SAP logs and ensuring the database nodes are properly synchronized.

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

6. The SAP HANA system replication can also be verified using following command:

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

7. Exit out of the SAP Admin account and remove the cluster out of maintenance-mode.

   ```bash
   sudo pcs property set maintenance-mode=false
   ```

8. Ensure the pacemaker cluster resources are running successfully.


### Scenario 3 Symptom 2: SAP HANA failing to start due to replication failure

SAP HANA Resource Reporting N (Standalone) mode experiences start failures with `hana_xxx_roles`.
The cluster node's database resource is a primary or secondary. Standalone node mode with `hana_xxx_roles` reporting **N**.
The `node attributes` status is shown as follows when we execute `sudo pcs status --full`:

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

The Migration summary reporting `INF` fail-count with failed SAP HANA resource action reporting start failures due to "not running".
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

#### Cause 2

- This issue frequently occurs when the database is modified (manually stopped, started, replication paused, etc.) while the cluster is in maintenance mode.

#### Resolution 2

> [!Note]
> These steps ( 1 to 5 ) should be performed by SAP admin.

1. As a precaution takes a full backup or snapshot before making any changes. Refer this document to know more about [Azure VM backup](/azure/backup/backup-azure-vms-introduction).
  
2. Put the cluster under maintenance-mode.

```bash
sudo pcs property set maintenance-mode=true
```

3. Manually start the database outside the cluster on primary node. 

```bash
sudo HDB start
```

4. Initialize replication on primary node. 

```bash
sudo hdbnsutil -sr_enable --name=<site id>
```
> [!Note]
> Replace `<site id>` accordingly.

5. Initialize replication on secondary node. 

```bash
sudo hdbnsutil -sr_register --remoteHost=<primary node> --remoteInstance=<Instance ##> --replicationMode=syncmem --name=<site id>
```
> [!Note]
> Replace `<primary node>`, `<Instance ##>` and `<side id>` accordingly.

6. Manually start database outside the cluster on the secondary node. 
 
```bash
sudo HDB start
```

7. Confirm replications are running as expected by running the following on both nodes. 
 
```bash
sudo hdbnsutil -sr_state
```

8. Remove the cluster out of maintenance-mode.

```bash
sudo pcs property set maintenance-mode=false
```

9. Clear out fail count of SAP HANA resource. 

```bash
sudo pcs resource cleanup <SAPHana resource name>
```
> [!Note]
> Replace `<SAPHana resource name>` as per your SAP Pacemaker cluster setup.

For more information about this scenario, you can see the following Red Hat article: [SAPHana Resource Experiencing Start Failures with hana_xxx_roles Reporting N (Standalone)'](https://access.redhat.com/solutions/7062225).

### Scenario 3 Symptom 3: SAP HANA resource failing to start due to hdbdaemon issues

SAP HANA Resource Start Failure with error message as shown:

```output
'FAIL: process hdbdaemon HDB Daemon not running'
```

The `sudo pcs status --full` command can also be used to view this error, as it also resulted the SAP HANA Pacemaker cluster resources failover error.

```output
Failed Resource Actions:
  * SAPHana_XXX_00_start_0 on node-0 'error' (1): call=44, status='complete', exitreason='', last-rc-change='2024-07-07 06:15:45 -08:00', queued=0ms, exec=51659ms
```

#### Cause 3

Upon reviewing `/var/log/messages` it was observed that `hbddaemon` failed to start due to the following error:

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

#### Resolution 3

As shown in the output, there are no traces found other than why the 'hbddaemon' failed to start. After evaluating the provided output in the '/var/log/messages' log file, SAP vendor support should further study the application logs to understand why the SAP application failed to start.

For more information about this scenario, you can see the following Red Hat article: [SAPHana Resource Start Failure with Error 'FAIL: process hdbdaemon HDB Daemon not running'](https://access.redhat.com/solutions/7058526).

## Scenario 4: Issue with ASCS and ERS resource.

### Symptom of scenario 4

ASCS and ERS instances aren't able to start under cluster control. The following errors can be seen from `/var/log/messages`.

```output
Jun  9 23:29:16 nodeci SAPRh2_10[340480]: Unable to change to Directory /usr/sap/RH2/ERS10/work. (Error 2 No such file or directory) [ntservsserver.cpp 3845]
Jun  9 23:29:16 nodeci SAPRH2_00[340486]: Unable to change to Directory /usr/sap/Rh2/ASCS00/work. (Error 2 No such file or directory) [ntservsserver.cpp 3845]
```

### Cause of scenario 4

Due to incorrect `InstanceName` and `START_PROFILE`, attributes SAP instance (ASCS & ERS) failed to start under cluster control.

### Resolution of scenario 4

> [!Note]
> This resolution is applicable when your `InstanceName` and `START_PROFILE` are individual.

1. As a precaution takes a full backup or snapshot before making any changes. Refer this document to know more about [Azure VM backup](/azure/backup/backup-azure-vms-introduction).
  
2. Put the cluster under maintenance-mode.

```bash
sudo pcs property set maintenance-mode=true
```

3. Verify the `pf(profile)` path from `/usr/sap/sapservices` file:

```bash
sudo cat /usr/sap/sapservices
```
```output
LD_LIBRARY_PATH=/usr/sap/RH2/ASCS00/exe:$LD_LIBRARY_PATH;export LD_LIBRARY_PATH;/usr/sap/RH2/ASCS00/exe/sapstartsrv pf=/usr/sap/RH2/SYS/profile/START_ASCS00_nodeci -D -u rh2adm
LD_LIBRARY_PATH=/usr/sap/RH2/ERS10/exe:$LD_LIBRARY_PATH;export LD_LIBRARY_PATH;/usr/sap/RH2/ERS10/exe/sapstartsrv pf=/usr/sap/RH2/ERS10/profile/START_ERS10_nodersvi -D -u rh2adm
```

4. Correct the `InstanceName` and `START_PROFILE` attribute values in a cluster configuration resource agent `SAPInstance`. 

**Example:**

```bash
sudo pcs resource update ASCS_RH2_ASCS00 InstanceName=RH2_ASCS00_nodeci START_PROFILE=/usr/sap/RH2/SYS/profile/START_ASCS00_nodeci
```
> [!Note]
> Replace `RH2_ASCS00_nodeci` and `/usr/sap/RH2/SYS/profile/START_ASCS00_nodeci` accordingly.

```bash
sudo pcs resource update ERS_RH2_ERS10 InstanceName=RH2_ERS10_nodersvi START_PROFILE=/usr/sap/RH2/ERS10/profile/START_ERS10_nodersvi
```
> [!Note]
> Replace `RH2_ERS10_nodersvi` and `/usr/sap/RH2/ERS10/profile/START_ERS10_nodersvi` accordingly.

5.  Put the cluster out of maintenance-mode.

```bash
sudo pcs property set maintenance-mode=false
```

## Next Steps

For further help, open a support request by using the following instructions. When you submit your request, attach [SOS report](https://access.redhat.com/solutions/3592) from all the nodes in the cluster for troubleshooting.



[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
