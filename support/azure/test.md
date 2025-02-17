---
title:  Troubleshoot Suse Linux Enterprise Server (SLES) pacemaker cluster services and resources startup issues Azure
description: Provides troubleshooting guidance for issues related to cluster resources or services in SLES Pacemaker cluster
ms.reviewer: rnirek,divargas
ms.author: srsakthi
author: srsakthi
ms.topic: troubleshooting
ms.date: 01/24/2024
ms.service: azure-virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker clustering, and fencing
---

#  Troubleshoot issues related to cluster resources or services in Suse Linux Enterprise Server (SLES) Pacemaker Cluster Azure

**Applies to:** :heavy_check_mark: Linux VMs

This article lists the common causes of startup issues for SLES pacemaker cluster resources or services and offers guidance for identification of the cause and the resolution for the issues.


## Scenario 1: Issue with azure-events agent resource

### Symptom

The `crm status` output shows a failed resource actions error about Azure Events Monitor resource:

```output
'Failed Resource Actions:
* rsc_azure-events_monitor_10000 on node1 'error' (1): call=82, status='complete', exitreason='getInstanceInfo: Unable to get instance info', last-rc-change='2024-09-26 06:51:31 +10:00', queued=0ms, exec=94ms'
```

### Cause

The Azure platform host (physical server) that runs the cluster node experiences platform level host maintenance update. If the duration of this update exceeded the time required for the cluster resource to initiate a restart, it leads to the failure.

The following error logs are observed in `/var/log/messages` on the cluster node.

```output
python3[11159]: 2024-09-25T20:51:34.040196Z ERROR ExtHandler ExtHandler Error fetching the goal state: [ProtocolError] Error fetching goal state: [ResourceGoneError] [HTTP Failed] [410: Gone] b'<?xml version="1.0" encoding="utf-8"?>\n<Error xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">\n    <Code>ResourceNotAvailable</Code>\n    <Message>The resource requested is no longer available. Please refresh your cache.</Message>\n   <Details></Details>\n</Error>'
2024-09-26T06:51:34.040396+10:00 node1 python3[11159]: Traceback (most recent call last):
2024-09-26T06:51:34.040432+10:00 node1 python3[11159]:   File "/usr/lib/python3.6/site-packages/azurelinuxagent/common/protocol/wire.py", line 776, in update_goal_state
2024-09-26T06:51:34.040475+10:00 node1 python3[11159]:    self._goal_stateupdate(silent=silent)
2024-09-26T06:51:34.040507+10:00 CVCJLPPAP001 python3[11159]:   File "/usr/lib/python3.6/site-packages/azurelinuxagent/common/protocol/goal_state.py", line 147, in update
...
...
2024-09-26T06:51:34.040902+10:00 node1 python3[11159]:     raise ResourceGoneError(response_error)
2024-09-26T06:51:34.040949+10:00 node1 python3[11159]: azurelinuxagent.common.exception.ResourceGoneError: [ResourceGoneError] [HTTP Failed] [410: Gone] b'<?xml version="1.0" encoding="utf-8"?>\n<Error xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">\n   <Code>ResourceNotAvailable</Code>\n    <Message>The resource requested is no longer available. Please refresh your cache.</Message>\n   <Details></Details>\n</Error>'
```

The following error logs are observed in `/var/log/messages` on the cluster node.


```output
2024-09-26T06:51:30.997118+10:00 node1 azure-events: WARNING: Failed to reach the server: Gone
2024-09-26T06:51:31.005469+10:00 node1 azure-events: ERROR: getInstanceInfo: Unable to get instance info
2024-09-26T06:51:31.013735+10:00 node1 pacemaker-execd[10439]:  notice: rsc_azure-events_monitor_10000[2080672] error output [ ocf-exit-reason:getInstanceInfo: Unable to get instance info ]
2024-09-26T06:51:31.014026+10:00 node1 pacemaker-controld[10442]: notice: Result of monitor operation for rsc_azure-events on node1: error
```

```output
2024-09-26T06:51:33.562902+10:00 node1 python3[11159]: 2024-09-25T20:51:33.562638Z WARNING MonitorHandler ExtHandler Error in SendHostPluginHeartbeat: [ResourceGoneError] [HTTP Failed] [410: Gone] b'<?xml version="1.0" encoding="utf-8"?>\n<Error xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">\n   <Code>ResourceNotAvailable</Code>\n    <Message>The resource requested is no longer available. Please refresh your cache.</Message>\n   <Details></Details>\n</Error>' --- [NOTE: Will not log the same error for the next hour]
2024-09-26T06:51:34.040307+10:00 node1 python3[11159]: 2024-09-25T20:51:34.040196Z ERROR ExtHandler ExtHandler Error fetching the goal state: [ProtocolError] Error fetching goal state: [ResourceGoneError] [HTTP Failed] [410: Gone] b'<?xml version="1.0" encoding="utf-8"?>\n<Error xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">\n    <Code>ResourceNotAvailable</Code>\n    <Message>The resource requested is no longer available. Please refresh your cache.</Message>\n   <Details></Details>\n</Error>'
2024-09-26T06:51:34.040396+10:00 node1 python3[11159]: Traceback (most recent call last):
2024-09-26T06:51:34.040432+10:00 node1 python3[11159]:   File "/usr/lib/python3.6/site-packages/azurelinuxagent/common/protocol/wire.py", line 776, in update_goal_state
2024-09-26T06:51:34.040475+10:00 node1 python3[11159]:    self._goal_state.update(silent=silent)
...
...
2024-09-26T06:51:34.040902+10:00 node1 python3[11159]:     raise ResourceGoneError(response_error)
2024-09-26T06:51:34.040949+10:00 node1 python3[11159]: azurelinuxagent.common.exception.ResourceGoneError: [ResourceGoneError] [HTTP Failed] [410: Gone] b'<?xml version="1.0" encoding="utf-8"?>\n<Error xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">\n   <Code>ResourceNotAvailable</Code>\n    <Message>The resource requested is no longer available. Please refresh your cache.</Message>\n   <Details></Details>\n</Error>'
```

After the resource failed to restart three times, it reached a complete failure, requiring manual intervention by the administrator to resolve the issue and perform cleanup.

```output
pacemaker-schedulerd[8995]:  warning: Unexpected result (error: getInstanceInfo: Unable to get instance info) was recorded for monitor of rsc_azure-events:0 on node1 at Sep 26 06:51:31 2024 
pacemaker-schedulerd[8995]:  warning: cln_azure-events cannot run on node1 due to reaching migration threshold (clean up resource to allow again)
```

> [!NOTE]
   >If no relevant logs indicating host-level updates or connectivity issues are captured from the platform layer, configure [rtmon](https://www.suse.com/support/kb/doc/?id=000019863) to ensure OS records the necessary details to identify the root cause, even if the platform doesn't capture logs.

### Resolution

Make sure that the pacemaker is configured correctly for Azure scheduled events. For more information, see [Configure Pacemaker for Azure scheduled events](/azure/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#configure-pacemaker-for-azure-scheduled-events).

It's recommended to modify resource `rsc_azure-events` primitive configuration to incorporate 60-second delay before initiating the restart operation. This delay allows sufficient time for the Azure agents to finalize the host level maintenance tasks without triggering complete resource failure. For more information, see the following SUSE KB article:[rsc_azure-events resource fails with error: Unable to get instance info](https://www.suse.com/support/kb/doc/?id=000021356).

To do this, follow these steps:

1. Place the cluster in maintenance mode.

   ```bash
   sudo crm configure property maintenance-mode=true
   ```

2. Enter the interactive configuration mode.  

   ```bash
   sudo crm configure edit rsc_azure-events
   ```

3. Modify the `rsc_azure-events` parameters as mentioned in the following output.

   ```bash
   primitive rsc_azure-events azure-events \
        op monitor interval=10s timeout=240s \
        op start timeout=10s interval=0s start-delay=60s\
        op stop timeout=10s interval=0s \
        meta allow-unhealthy-nodes=true failure-timeout=120s
   ```
4. Save your changes and exit the editor.
5. Verify the changes.

    ```bash
    sudo crm config show
    ```
6. Remove the cluster from maintenance mode.

    ```bash
    sudo crm configure property maintenance-mode=false
    ``` 
## Scenario 2: SAP HANA DB resource failed to start

### Symptom 1 - SAP HANA DB resource failed with time-out error

The start operation of the SAP High-Performance Analytic Appliance database (HANA DB) cluster resource (for example: `rsc_SAPHANA_DB01`) failed with timeout error. However, it can be successfully started manually (outside the cluster control) while the cluster was in maintenance mode.

```output
pacemaker-execd[xxx]:  warning: rsc_SAPHANA_DB01_start_0 process (PID xxx) timed out
pacemaker-execd[xxx]:  warning: rsc_SAPHANA_DB01_start_0:xxx - timed out after 3600000ms
pacemaker-execd[xxx]:  notice: finished - rsc: rsc_SAPHANA_DB01 action:start call_id:25 pid:xxx exit-code:1 exec-time:3604053ms queue-time:0ms
pacemaker-controld[xxx]:  error: Result of start operation for rsc_SAPHANA_DB01 on xxx: Timed Out
```

### Cause

The HANA DB startup fails due to exceed the start timeout limit.

### Resolution

To resolve the issue, extend both the start and stop `timeout` parameters for the HANA DB resource `rsc_SAPHANA_DB01`, as recommended in the SUSE KB article [HANA DB resource failed to start](https://www.suse.com/support/kb/doc/?id=000020948).

**Example**

1. Place the cluster in maintenance mode.

   ```bash
   sudo crm configure property maintenance-mode=true
   ```
2. Clean up resources from previous failures if the cluster reports an error due to a failure to start, to prevent the cluster from restarting the HANA DB.

   ```bash
   sudo crm resource cleanup
   ```

3. Edit the cluster configuration to update the timeout parameter of the start and stop operations.
    
    ```bash
    sudo crm config edit
    ```

    Before:

   ```bash
    primitive rsc_SAPHANA_DB01 ocf:suse:SAPHana \
        op start interval=0 timeout=3600 \
        op stop interval=0 timeout= 3600 \	
   ```		

    After:

    ```bash
    primitive rsc_SAPHANA_DB01 ocf:suse:SAPHana \
        op start interval=0 timeout=7200 \
	    op stop interval=0 timeout=7200 \
    ```

4. Disable cluster maintenance mode.
    
    ```bash
    sudo crm configure property maintenance-mode=false
    ```
5. Verify the changes performed.

   ```bash
   sudo crm config show
   ```

### Symptom 2 - SAP HANA DB resource fails to start with `unknown error`

SAP HANA DB fails to start with `unknown error`.

Following is the output of `sudo crm status` when this issue occurs:

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
         rsc_SAPHana_P40_HDB00	(ocf::suse:SAPHana):	Stopped node-1 (Monitoring)
     Resource Group: g_ip_P40_HDB00
         rsc_ip_P40_HDB00	(ocf::heartbeat:IPaddr2):	Started node-1 
         rsc_nc_P40_HDB00	(ocf::heartbeat:azure-lb):	Started node-1 
     rsc_st_azure	(stonith:fence_azure_arm):	Started node-2 
    
    Failed Resource Actions:
    * rsc_SAPHana_P40_HDB00_monitor_61000 on node-1 'unknown error' (1): call=32, status=complete, exitreason='',
        last-rc-change='Fri Jun 10 00:33:41 2024', queued=0ms, exec=0ms
    * rsc_SAPHana_P40_HDB00_start_0 on node-2 'not running' (7): call=55, status=complete, exitreason='',
        last-rc-change='Fri Jun 10 00:33:41 2024', queued=0ms, exec=3093ms
```
### Cause

Pacemaker can't start SAP HANA resource when there are `SYN failures` between primary and secondary nodes.

Secondary cluster node is in `WAITING4PRIM` status.

In the `/var/log/messages`, you will see `SRHOOK=SFAIL` messages.

```output
2024-06-10T00:31:40.106622+02:00 node-1 SAPHana(rsc_SAPHana_P2H_HDB00)[55890]: INFO: RA: SRHOOK1=
2024-06-10T00:31:40.149443+02:00 node-1 SAPHana(rsc_SAPHana_P2H_HDB00)[55890]: INFO: RA: SRHOOK2=SFAIL
2024-06-10T00:31:40.155744+02:00 node-1 SAPHana(rsc_SAPHana_P2H_HDB00)[55890]: INFO: RA: SRHOOK3=SFAIL
```

When you run `sudo SAPHanaSR-showAttr`, you will see the following sync status of the primary and secondary DB nodes:

```bash
sudo SAPHanaSR-showAttr
```
```output 
 Global cib-time                 maintenance
 --------------------------------------------
 global Mon Jun 10 01:47:32 2024 false
  
 Hosts         clone_state lpa_fh9_lpt node_state op_mode   remoteHost
roles                            score site  srmode  sync_state version                vhost
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 node-1 UNDEFINED   10          online     logreplay node-2 0:P::::                          5     DC1 syncmem SFAIL      2.00.046.00.1581325702 node-1
 node-2 PROMOTED    1693237652  online     logreplay node-1 4:P:master1:master:worker:master 150   DC2 syncmem PRIM       2.00.046.00.1581325702 node-2 
```

### Workaround

SAP HANA resource can't start by pacemaker when there are `SYN failures` between primary and secondary cluster nodes. To mitigate this issue, manually enable `SYN` between the primary and secondary nodes.
 
>[!IMPORTANT]
> Steps 2,3 and 4 are to be performed using SAP administrator account as these steps involve using SAP System ID to stop, start, and re-enable replication manually.
  
1. Place the cluster in maintenance mode.
   
    ```bash
    sudo crm configure property maintenance-mode=true
    ```

2. Check SAP HANA DB and processes state.

     - Check the SAP related processes running in the node by running HANA Database (HBD) info on each node. SAP Admin should be able to confirm if the required process are running on both the nodes and the databases on both nodes remain synchronized.


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

     - If SAP DB and services aren't active on the node, reach out to your SAP administrator to review and troubleshoot the issue.

       ```bash
       sudo HDB stop
       ```
       or  

       ```bash
       sudo sapcontrol -nr <SAPInstanceNo.> -function Stop
       ```
      Replace `<SAPInstanceNo.>` with the instance number that needs to be stopped. 
     
    - Once the stop operation is completed, Start HANA DB in primary and then in secondary node.

       ```bash
       sudo HDB start
       ```
       or  

       ```bash
       sudo sapcontrol -nr <SAPInstanceNo.> -function Start
       ```
3. Usually stop and start operation of HANA DB should synchronize both nodes. If the database nodes are still not synchronized, the SAP administrator should troubleshoot the issue by reviewing SAP logs and ensuring the database nodes are properly synchronized.

    >[!NOTE]
    >The SAP administrator must determine which node should be designated as the primary and which as the secondary, ensuring no database data is lost in the process.

4. After enabling replication, check the system replication status using SAP system admin account. In this case, the user admin account is hn1adm.

      ```bash
      sudo su - hn1adm -c "python /usr/sap/HN1/HDB03/exe/python_support/systemReplicationStatus.py"
      ```

      ```output
      | Host   | Port  | Service Name | Volume ID | Site ID | Site Name  | Secondary | Secondary | Secondary | Secondary | Secondary     | Replication | Replication | Replication    |
      |        |       |              |           |         |            | Host      | Port      | Site ID   | Site Name | Active Status | Mode        | Status      | Status Details |
      | -----  | ----- | ------------ | --------- | ------- | ---------  | --------- | --------- | --------- | --------- | ------------- | ----------- | ----------- | -------------- |
      | node-1 | 30007 | xsengine     |         2 |       1 | node-1     | node-2     |     30007 |         2 | node-2     | YES           | SYNC        | ACTIVE      |                |
      | node-1 | 30001 | nameserver   |         1 |       1 | node-1     | node-2     |     30001 |         2 | node-2     | YES           | SYNC        | ACTIVE      |                |
      | node-1 | 30003 | indexserver  |         3 |       1 | node-1     | node-2     |     30003 |         2 | node-2     | YES           | SYNC        | ACTIVE      |                |

      status system replication site "2": ACTIVE
      overall system replication status: ACTIVE

      Local System Replication State
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      mode: PRIMARY
      site id: 1
      site name: node-1
      ```

   - **In the secondary node**, from the output check if mode is `SYNC`
      
      ```output
      this system is either not running or not primary system replication site

      Local System Replication State
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      mode: SYNC
      site id: 2
      site name: node-2
      active primary site: 1
      primary masters: node-1
      ```

5. The SAP HANA system replication can also be verified using following command.

      ```bash
      sudo SAPHanaSR-showAttr
      ```
      
      ```output 
      Global cib-time                 maintenance
      --------------------------------------------
      global Mon Jun 10 01:57:32 2024 false
  
      Hosts clone_state lpa_fh9_lpt node_state op_mode   remoteHost roles                         score site  srmode  sync_state version                vhost
      ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      node-1 PROMOTED   1693237652  online     logreplay node-2 4:P:master1:master:worker:master   150    DC1   syncmem PRIM       2.00.046.00.1581325702 node-1
      node-2 DEMOTED    10          online     logreplay node-1 4:P:master1:master:worker:master   100    DC2   syncmem SOK        2.00.046.00.1581325702 node-2 
      ```

6. Exit out of the SAP Admin account and remove the cluster out of maintenance-mode.

   ```bash
   sudo crm configure property maintenance-mode=false
   ```
7. Ensure the pacemaker cluster resources are running successfully.

## Next Steps

For more help, open a support request by using the following instructions. When you submit your request, attach [supportconfig](https://documentation.suse.com/smart/systems-management/html/supportconfig/index.html) and [hb_report](https://www.suse.com/support/kb/doc/?id=000019142) logs for troubleshooting.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
