---
title: Troubleshoot RHEL(RedHat Enterprise Linux) pacemaker cluster services and resources startup issues Azure
description: Provides troubleshooting guidance for issues related to cluster resources or services in RHEL(RedHat Enterprise Linux) Pacemaker cluster
ms.reviewer: rnirek,srsakthi
ms.author: skarthikeyan
author: skarthikeyan
ms.topic: troubleshooting
ms.date: 10/16/2024
ms.service: azure-virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker clustering, and fencing
---

# Troubleshoot issues related to cluster resources or services in RHEL(RedHat Enterprise Linux) Pacemaker Cluster Azure

**Applies to:** :heavy_check_mark: Linux VMs

This article describes the most typical reasons of startup issues for RHEL pacemaker cluster resources or services and guidance for determining the cause and resolving the issues.

## Scenario 1: Unable to start cluster service due to quorum

### Symptom 1

- Cluster node fails to join cluster after cluster restart.
- Nodes are reported as `UNCLEAN (offline)`
- Current DC shows as `NONE`

```bash
sudo pcs status
```
```output
Cluster name: my_cluster
Status of pacemakerd: 'Pacemaker is running' (last updated 2023-06-27 12:34:49 -04:00)
Cluster Summary:
* Stack: corosync
* **Current DC: NONE**
* Last updated: Tue Jun 27 12:34:49 2023
* Last change:  Tue Jun 27 12:29:51 2023 by root via cibadmin on rhel9a
* 2 nodes configured
* 9 resource instances configured

Node List:
* **Node rhel9a: UNCLEAN (offline)**
* **Node rhel9b: UNCLEAN (offline)**
```

- `sudo pcs quorum status` results in following error:

```bash
sudo pcs quorum status
```
```output
Error: Unable to get quorum status: Unable to start votequorum status tracking: CS_ERR_BAD_HANDLE
Check for the error: Corosync quorum is not configured in /var/log/messeges:
Jun 16 11:17:53 rhel9a pacemaker-controld[509433]: error: Corosync quorum is not configured
```

### Cause

The **votequorum** service is part of the corosync project. This service can be optionally loaded into the nodes of a corosync cluster to avoid split-brain situations. It's accomplished by allocating number of votes to every system in the cluster. Guaranteeing that cluster actions may only take place when a most of the votes are present. The service must be loaded into all nodes or none. If it loaded into a subset of cluster nodes, the results are unpredictable.

The following corosync.conf extract will enables **votequorum** service within corosync:

```output
       quorum {
           provider: corosync_votequorum
       }
```

**Votequorum** reads its configuration from corosync.conf. Some values can be changed at runtime and others are only read at corosync startup. It's important that those values are consistent across all the nodes participating in the cluster or votequorum behavior are unpredictable.

### Resolution

1. Check for missing quorum stanza in `/etc/corosync/corosync.conf`. Compare the existing `corosync.conf` with any of the available backup present under `/etc/corosync/`.

2. Put the cluster under maintenance-mode.

```bash
sudo pcs property set maintenance-mode=true
```

3. Update the changes in `/etc/corosync/corosync.conf`.

Example for two node cluster:

```bash
sudo cat /etc/corosync/corosync.conf
```
```output
totem {
version: 2
cluster_name: my_cluster
transport: knet
crypto_cipher: aes256
crypto_hash: sha256
cluster_uuid: afd62fe2045b43b9a102de76fdf4659a
}
nodelist {
node {
    ring0_addr: rhel9a
    name: rhel9a
    nodeid: 1
}

node {
    ring0_addr: rhel9b
    name: rhel9b
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

4. Put the cluster out of maintenance-mode.

```bash
sudo pcs property set maintenance-mode=false
```

5. Sync the cluster:

```bash
sudo pcs cluster sync
```

6. Reload corosync.

```bash
sudo pcs cluster reload corosync
```

## Scenario 2:  Issue with VIP resource

### Symptom 1

Virtual IP (`IPaddr2` resource) failed to start/stop in pacemaker.
The messages can be observed under `/var/log/pacemaker.log` as shown:

```output
14168 IPaddr2(VIP)[12083]:    2016/01/07_09:44:19 ERROR: Unable to find nic or netmask.
14169 IPaddr2(VIP)[12083]:    2016/01/07_09:44:19 ERROR: [findif] failed
```
The error can also be observed while running `sudo pcs status`:

```bash
sudo pcs status
```
```output
myip_start_0 on cluster0.heartbeat.example.com 'unknown error' (1): call=20, status=complete, exit-reason='[findif] failed', last-rc-change='Mon Jan 11 13:24:32 2016', queued=0ms, exec=39ms
```

### Cause

IPaddr2 call `findif()` function as specified in `/usr/lib/ocf/resource.d/heartbeat/IPaddr2` (belongs to resource-agents package)  to determine which network interface to start the `IPAddr2` resource on.

The correct `NIC(Network Interface Card)` will be determined by the options set on the IPAddr2 resource: `ip` (required), `cidr_netmask`, and `broadcast`.

*For example:*

Check the `IPaddr2` settings,

```bash
sudo pcs resource show myip
```
```output
Resource: myip (class=ocf provider=heartbeat type=IPaddr2)
Attributes: ip=192.168.111.222 cidr_netmask=24 
Operations: start interval=0s timeout=20s (myip-start-timeout-20s)
            stop interval=0s timeout=20s (myip-stop-timeout-20s)
            monitor interval=10s timeout=20s (myip-monitor-interval-10s)
```

Try to determine `NIC` information manually. In this example, based on the ip address and netmask, we can successfully find `ens6` from route table.

```bash
sudo ip -o -f inet route list match 192.168.111.222/24 scope link
```
```output
192.168.111.0/24 dev ens6  proto kernel  src 192.168.111.195 
```

In case if the `NIC (ens6)` is down, we couldn't manually find the `NIC` information, and that might lead to `[findif]` failed:

```bash
sudo ip link set ens6 down
```
```bash
sudo ip -o -f inet route list match 192.168.111.222/24 scope link 
```
> [!Note]
> Replace `192.168.111.222/24` and `ens6` accordingly.

### Resolution

If the route that matches the VIP isn't in the default routing table, then one can specify the `NIC` name in pacemaker resource, so that it can be configured bypassing the check:

1. Put the cluster under maintenance-mode.
   
```bash
sudo pcs property set maintenance-mode=true
```

2. Update the NIC resources are shown:

```bash
sudo pcs resource update ip-172.17.223.36 nic=vlan10
```

3. Restart the NIC resources.

```bash
sudo pcs resource restart ip-172.17.223.36
```
```output
ip-172.17.223.36 successfully restarted
```

4. Put the cluster out of maintenance-mode.

```bash
sudo pcs property set maintenance-mode=false
```

5. Verify the IP resource as shown:

```bash
sudo pcs resource show ip-172.17.223.36
```
```output
Warning: This command is deprecated and will be removed. Please use 'pcs resource config' instead.
 Resource: ip-172.17.223.36 (class=ocf provider=heartbeat type=IPaddr2)
  Attributes: cidr_netmask=32 ip=172.17.223.36 nic=vlan10
  Meta Attrs: resource-stickiness=INFINITY
  Operations: monitor interval=10s timeout=20s (ip-172.17.223.36-monitor-interval-10s)
              start interval=0s timeout=20s (ip-172.17.223.36-start-interval-0s)
              stop interval=0s timeout=20s (ip-172.17.223.36-stop-interval-0s)
```
> [!Note]
> Replace `ip-172.17.223.36` accordingly.

## Scenario 3:  Issue with SAP HANA(High-performance ANalytic Appliance)

### Symptom 1

SAP HANA DB fails to start with `'unknown error'`

a. From the `/var/log/messages`, we can see `SRHOOK=SFAIL` indicating the cluster nodes are out of sync.
b. Secondary cluster node is in `WAITING4PRIM` status.
c. When you run `sudo pcs status` the status of the cluster will be shown as following:

```bash
sudo pcs status
```
```output
    2 nodes configured
    8 resources configured
    
    Node node-1: 
    Node node-2: 
    
    Active resources:
    
     Clone Set: cln_SAPHanaTopology [rsc_SAPHanaTopology]
         rsc_SAPHanaTopology	(ocf::suse:SAPHanaTopology):	Started node-1 
         rsc_SAPHanaTopology	(ocf::suse:SAPHanaTopology):	Started node-2 
     Master/Slave Set: msl_SAPHana [rsc_SAPHana]
         rsc_SAPHana	(ocf::suse:SAPHana):	Slave node-1 
     Resource Group: g_ip_P40_HDB00
         rsc_ip_P40_HDB00	(ocf::heartbeat:IPaddr2):	Started node-1 
         rsc_nc_P40_HDB00	(ocf::heartbeat:azure-lb):	Started node-1 
     rsc_st_azure	(stonith:fence_azure_arm):	Started node-2 
            
    Failed Resource Actions:
    * rsc_SAPHana_monitor_61000 on node-1 'unknown error' (1): call=32, status=complete, exitreason='',
        last-rc-change='Sat May 22 09:29:20 2021', queued=0ms, exec=0ms
    * rsc_SAPHana_start_0 on node-2 'not running' (7): call=55, status=complete, exitreason='',
        last-rc-change='Sat May 22 09:36:32 2021', queued=0ms, exec=3093ms
```

### Cause

Pacemaker can't start SAP HANA resource when there are `SYN` failures between primary and secondary nodes.

```bash
sudo SAPHanaSR-showAttr
```
```output  
 Global cib-time                 maintenance
 --------------------------------------------
 global Mon Aug 28 11:47:32 2023 false
  
 Hosts         clone_state lpa_fh9_lpt node_state op_mode   remoteHost    roles                            score site  srmode  sync_state version                vhost
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 node-1 UNDEFINED   10          online     logreplay node-2 0:P::::                          5     SITEA syncmem SFAIL      2.00.046.00.1581325702 node-1
 node-2 PROMOTED    1693237652  online     logreplay node-1 4:P:master1:master:worker:master 150   SITEA syncmem PRIM       2.00.046.00.1581325702 node-2
```

### Resolution

SAP HANA resource can't be start by pacemaker when there are `SYN` failures between primary and secondary cluster nodes. To mitigate this issue, we must manually enable `SYN` between the primary and secondary nodes.

> [!Important]
> Steps 2,3 & 4 are to be performed using SAP administrator account as these steps involve using SAP System ID to stop, start and re-enable replication manually.

1. Put the cluster under maintenance-mode.

    ```bash
    sudo pcs property set maintenance-mode=true
    ```
    
2. Check SAP HANA DB and processes state. 

   a. Validate primary and secondary nodes are running SAP database and related SAP processes. Even though one node is designated as a secondary and one node is a primary, both nodes actually run a database. Primary database is continuously synchronized to the secondary database. In order to check if nodes can synchronize properly, we need to make sure that both nodes are correctly running the expected SAP DB(DataBase) and processes.

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
    a00adm     5369      1  0.0  20932  1644 sapstart pf=/usr/sap/A00/SYS/profile/A00_HDB00_node1
    a00adm     5377   5369  1.8 582944 292720  \_ /usr/sap/A00/HDB00/node1/trace/hdb.sapA00_HDB00 -d -nw -f /usr/sap/A00/HDB00/node1/daemon.ini pf=/usr/sap/A00/SYS/profile/A00_HDB00_node1
    a00adm     5394   5377  9.3 3930388 1146444      \_ hdbnameserver
    a00adm     5548   5377 21.3 2943472 529672      \_ hdbcompileserver
    a00adm     5550   5377  4.4 2838792 465664      \_ hdbpreprocessor
    a00adm     5571   5377 91.6 7151116 4019640      \_ hdbindexserver
    a00adm     5573   5377 21.8 4323488 1203128      \_ hdbxsengine
    a00adm     5905   5377 18.9 3182120 710680      \_ hdbwebdispatcher
    a00adm     2104      1  0.0 428748 27760 /usr/sap/A00/HDB00/exe/sapstartsrv pf=/usr/sap/A00/SYS/profile/A00_HDB00_node1 -D -u a00adm
    a00adm     2004      1  0.0  31844  2352 /usr/lib/systemd/systemd --user
    a00adm     2008   2004  0.0  63796  2620  \_ (sd-pam)
    ```
    
   c. If SAP DB and services aren't active on the node, ask SAP admin to Stop HANA DB in secondary node first and then in the primary node. 

    ```bash
    HDB stop
    ```
    or
    ```bash
    sapcontrol -nr <SAPInstanceNo> -function stop
    ```
    
   d. Once the stop operation is completed, Start HANA DB in primary and then in secondary node.

    ```bash
    HDB start
    ```
    or
   
    ```bash
    sapcontrol -nr <SAPInstanceNo> -function start
    ```
> [!Note]
> Modify `<SAPInstanceNo>` accordingly.

3. Usually stop and start operation of SAP HANA DB should synchronize both nodes. If we're still not seeing the synchronization, then we have to disable and re-enable replication between the nodes. SAP Administrator should be able to perform this step of disabling SAP HANA system replication and then enabling the replication.
   
> [!Caution]
> When reconfiguring replication on an existing SAP cluster, it's imperative that the database/node with the most accurate and up-to-date data is designated as the **primary**. A wrong execution of this process might result in an outdated or "empty" database being overwritten with the most recent database, leading to loss of data and a need to restore from any existing backup.

4. After enabling replication, check the system replication status as `HANA SID` account by calling the `systemReplicationStatus.py` SAP Python script. The SAP binaries are typically available as shown: 

   ```output
   /hana/shared/A00/HDB00/exe/python_support
   ```

   From the primary node, check if overall system replication status: `ACTIVE`.
   If you're seeing a different message, then most likely there are other issues between primary and secondary, which needs to be sorted from SAP end.

   ```bash
   sudo python /hana/shared/A00/HDB00/exe/python_support/systemReplicationStatus.py
   ```
   ```output
   | Host  | Port  | Service Name | Volume ID | Site ID | Site Name | Secondary | Secondary | Secondary | Secondary | Secondary     | Replication | Replication | Replication    |
   |       |       |              |           |         |           | Host      | Port      | Site ID   | Site Name | Active Status | Mode        | Status      | Status Details | 
   | ----- | ----- | ------------ | --------- | ------- | --------- | --------- | --------- | --------- | --------- | ------------- | ----------- | ----------- | -------------- |
   | node1 | 30007 | xsengine     |         2 |       1 | node1     | sapn2     |     30007 |         2 | node2     | YES           | SYNC        | ACTIVE      |                |
   | node1 | 30001 | nameserver   |         1 |       1 | node1     | sapn2     |     30001 |         2 | node2     | YES           | SYNC        | ACTIVE      |                |
   | node1 | 30003 | indexserver  |         3 |       1 | node1     | sapn2     |     30003 |         2 | node2     | YES           | SYNC        | ACTIVE      |                |

   status system replication site "2": ACTIVE
   overall system replication status: ACTIVE

   Local System Replication State
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     mode: PRIMARY
     site id: 1
     site name: node1
   ```

5. You can also check the failover process by running SAPHanaSR-showAttr command in primary VM(Virtual Machine). If the SYN issue is resolved, then the output of this command shows Primary in Promoted mode and Secondary in Demoted mode. Once you see the primary and secondary nodes in Promoted and Demoted mode respectively, remove the cluster out of maintenance-mode, this action allows pacemaker to start SAP HANA DB.

   ```bash
   sudo pcs property set maintenance-mode=false
   ```

### Symptom 2

SAP HANA Resource Experiencing Start Failures with `hana_xxx_roles` Reporting N (Standalone) mode.
Database resource is not a primary or secondary on either node. With `hana_xxx_roles` reporting **N** for Standalone node mode.

```output
Node Attributes:
  * Node: Node1 (1):
    * hana_xxx_clone_state              : UNDEFINED 
    * hana_xxx_op_mode                  : logreplay 
    * hana_xxx_remoteHost               : Node.remote.host.name
    * hana_xxx_roles                    : 1:N:master1::worker:           <<<<<
    * hana_xxx_site                     : sap_site  
    * hana_xxx_srah                     : -         
    * hana_xxx_srmode                   : syncmem   
    * hana_xxx_sync_state               : SFAIL     
    * hana_xxx_version                  : 2.00.067.03
    * hana_xxx_vhost                    : sap.vhost.name
    * lpa_xxx_lpt                       : 10        
  * Node: Node2 (2):
    * hana_xxx_clone_state              : DEMOTED   
    * hana_xxx_op_mode                  : logreplay 
    * hana_xxx_remoteHost               : Node.remote.host.name
    * hana_xxx_roles                    : 4:N:master1:master:worker:master           <<<<<
    * hana_xxx_site                     : sap_site  
    * hana_xxx_srah                     : -         
    * hana_xxx_srmode                   : syncmem   
    * hana_xxx_version                  : 2.00.067.03
    * hana_xxx_vhost                    : sap.vhost.name
    * lpa_xxx_lpt                       : 1711641128
```

With migration summary reporting `INF` fail-count with failed SAP HANA resource action reporting start failures due to "not running".

```output
Migration Summary:
  * Node: Node1 (1):
    * SAPHana_Resource: migration-threshold=5000 fail-count=1000000 last-failure='Thu Mar 28 09:39:07 2024'
  * Node: Node2 (2):
    * SAPHana_Resource: migration-threshold=5000 fail-count=1000000 last-failure='Thu Mar 28 09:23:06 2024'

Failed Resource Actions:
  * SAPHana_Resource_start_0 on Node1 'not running' (7): call=97, status='complete', last-rc-change='Thu Mar 28 09:39:06 2024', queued=0ms, exec=1014ms
  * SAPHana_Resource_start_0 on Node2 'not running' (7): call=27, status='complete', last-rc-change='Thu Mar 28 09:23:05 2024', queued=0ms, exec=1024ms
```

### Cause

- Each database node in a standalone node attempts to function alone rather than interacting with one another.
- Commonly seen this issue occur when the database is altered (database manually stopped, started, replication paused, etc.,) while the cluster is in maintenance mode.
- Run `sudo pcs status --full` and check under Node Attributes for `hana_xxx_roles` and confirm it's reporting `#:N:X:X:X:X` instead of `#:P:X:X:X:X`.

### Resolution

> [!Note]
> These steps ( 1 to 5 ) should be performed by SAP admin.

1. Put the cluster under maintenance-mode.

```bash
sudo pcs property set maintenance-mode=true
```

2. Manually start the database outside the cluster on primary node. 

```bash
sudo HDB start
```

3. Initialize replication on primary node. 

```bash
sudo hdbnsutil -sr_enable --name=<site id>
```
> [!Note]
> Replace `<site id>` accordingly.

4. Initialize replication on secondary node. 

```bash
sudo hdbnsutil -sr_register --remoteHost=<primary node> --remoteInstance=<Instance ##> --replicationMode=syncmem --name=<site id>
```
> [!Note]
> Replace `<primary node>`, `<Instance ##>` and `<side id>` accordingly.

5. Manually start database outside the cluster on the secondary node. 
 
```bash
sudo HDB start
```

6. Confirm replications are running as expected by running the following on both nodes. 
 
```bash
sudo hdbnsutil -sr_state
```

7. Remove the cluster out of maintenance-mode.

```bash
sudo pcs property set maintenance-mode=false
```

8. Clear out fail count of SAP HANA resource. 

```bash
sudo pcs resource cleanup <SAPHana resource name>
```
> [!Note]
> Replace `<SAPHana resource name>` as per your SAP Pacemaker cluster setup.

### Symptom 3

SAP HANA Resource Start Failure with error message as shown:

```output
'FAIL: process hdbdaemon HDB Daemon not running'
```

The `sudo pcs status --full` command can also be used to view this, as it also resulted the SAP HANA Pacemaker cluster resources failover error.

```output
Failed Resource Actions:
  * SAPHana_ECR_00_start_0 on Node1 'error' (1): call=44, status='complete', exitreason='', last-rc-change='2024-03-01 02:27:33 -08:00', queued=0ms, exec=23727ms
```

### Cause

After reviewing `/var/log/messages` it was observed that `hbddaemon` failed to start due to the following error:

```output
Mar  1 02:25:09 Node1 SAPHana(SAPHana_ECR_00)[12336]: ERROR: ACT: SAPHana Instance ECR-HDB00 start failed: #01201.03.2024 02:25:09#012WaitforStarted#012FAIL: process hdbdaemon HDB Daemon not running
Mar  1 02:25:09 Node1 SAPHana(SAPHana_ECR_00)[12336]: INFO: RA ==== end action start_clone with rc=1 (0.154.0) (25s)====
Mar  1 02:25:09 Node1 pacemaker-execd[8567]: notice: SAPHana_ECR_00_start_0[12336] error output [ tput: No value for $TERM and no -T specified ]
Mar  1 02:25:09 Node1 pacemaker-execd[8567]: notice: SAPHana_ECR_00_start_0[12336] error output [ tput: No value for $TERM and no -T specified ]
Mar  1 02:25:09 Node1 pacemaker-execd[8567]: notice: SAPHana_ECR_00_start_0[12336] error output [ tput: No value for $TERM and no -T specified ]
Mar  1 02:25:09 Node1 pacemaker-execd[8567]: notice: SAPHana_ECR_00_start_0[12336] error output [ Error performing operation: No such device or address ]
Mar  1 02:25:09 Node1 pacemaker-controld[8570]: notice: Result of start operation for SAPHana_ECR_00 on Node1: error
Mar  1 02:25:09 Node1 pacemaker-controld[8570]: notice: Node1-SAPHana_ECR_00_start_0:33 [ tput: No value for $TERM and no -T specified\ntput: No value for $TERM and no -T specified\ntput: No value for $TERM and no -T specified\nError performing operation: No such device or address\n ]
Mar  1 02:25:09 Node1 pacemaker-attrd[8568]: notice: Setting fail-count-SAPHana_ECR_00#start_0[Node1]: (unset) -> INFINITY
Mar  1 02:25:09 Node1 pacemaker-attrd[8568]: notice: Setting last-failure-SAPHana_ECR_00#start_0[Node1]: (unset) -> 1709288709
```

### Resolution

As shown in the above output, there are no traces found other than why the 'hbddaemon' failed to start. After reviewing the provided output in the '/var/log/messages' log file, it is recommended that SAP vendor support investigate the application logs further to determine why the SAP application failed to start.

For additional refrence please refer to this RedHat Article [SAPHana Resource Start Failure with Error 'FAIL: process hdbdaemon HDB Daemon not running'](https://access.redhat.com/solutions/7058526).

## Scenario 4: Issue with ASCS and ERS resource.

### Symptom 1
ASCS and ERS instances aren't able to start under cluster control. The following errors can be seen from `/var/log/messages`.

```output
Apr  6 23:29:16 nodeci SAPRh2_10[340480]: Unable to change to Directory /usr/sap/RH2/ERS10/work. (Error 2 No such file or directory) [ntservsserver.cpp 3845]
Apr  6 23:29:16 nodeci SAPRH2_00[340486]: Unable to change to Directory /usr/sap/Rh2/ASCS00/work. (Error 2 No such file or directory) [ntservsserver.cpp 3845]
```

### Cause

Due to incorrect `InstanceName` and `START_PROFILE` attributes SAP instance (ASCS & ERS) not start under cluster control.

### Resolution

> [!Note]
> This resolution is applicable when your `InstanceName` and `START_PROFILE` are individual.

1. Put the cluster under maintenance-mode.

```bash
sudo pcs property set maintenance-mode=true
```

2. Verify the `pf(profile)` path from `/usr/sap/sapservices` file:

```bash
sudo cat /usr/sap/sapservices
```
```output
LD_LIBRARY_PATH=/usr/sap/RH2/ASCS00/exe:$LD_LIBRARY_PATH;export LD_LIBRARY_PATH;/usr/sap/RH2/ASCS00/exe/sapstartsrv pf=/usr/sap/RH2/SYS/profile/START_ASCS00_nodeci -D -u rh2adm
LD_LIBRARY_PATH=/usr/sap/RH2/ERS10/exe:$LD_LIBRARY_PATH;export LD_LIBRARY_PATH;/usr/sap/RH2/ERS10/exe/sapstartsrv pf=/usr/sap/RH2/ERS10/profile/START_ERS10_nodersvi -D -u rh2adm
```

3. Correct the `InstanceName` and `START_PROFILE` attribute values in a cluster configuration resource agent SAPInstance 

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

4.  Put the cluster out of maintenance-mode.

```bash
sudo pcs property set maintenance-mode=false
```

## Next Steps

For further help, open a support request by using the following instructions. When you submit your request, attach [sosreport](https://access.redhat.com/solutions/3592) from all the nodes in the cluster for troubleshooting.



[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
