---
title: Troubleshoot startup issues in a SUSE Pacemaker cluster
description: Provides troubleshooting guidance for Pacemaker services that don't start
ms.reviewer: rnirek,rmuneer,srsakthi
ms.topic: troubleshooting
ms.date: 07/24/2024
ms.service: azure-virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker clustering, and fencing
ms.author: rnirek
author: rnirek
---

# Troubleshoot startup issues in a SUSE Pacemaker cluster

**Applies to:** :heavy_check_mark: Linux VMs

This article lists the common causes of Pacemaker service startup issues and provides resolutions to fix them.

## Scenario 1: Pacemaker startup failure because of SysRq-triggered reboot

The Pacemaker service doesn't start if the last startup was triggered by a SysRq action. The Pacemaker service can start successfully after a normal restart. This issue is caused by a conflict between the STONITH Block Device (SBD) `msgwait` time and the fast restart time of these Azure virtual machines (VMs), as specified in the `/etc/sysconfig/sbd` file:

```output
## Type: yesno / integer
## Default: no
#
# Whether to delay after starting sbd on boot for "msgwait" seconds.
# This may be necessary if your cluster nodes reboot so fast that the # other nodes are still waiting in the fence acknowledgement phase.
# This is an occasional issue with virtual machines.
#
# This can also be enabled by being set to a specific delay value, in # seconds. Sometimes a longer delay than the default, "msgwait", is # needed, for example in the cases where it's considered to be safer to 
# wait longer than:
# corosync token timeout + consensus timeout + pcmk_delay_max + msgwait # # Be aware that the special value "1" means "yes" rather than "1s".
#
# Consider that you might have to adapt the startup-timeout accordingly # if the default isn't sufficient. (TimeoutStartSec for systemd) # # This option may be ignored at a later point, once Pacemaker handles 
# this case better.
SBD_DELAY_START=no
```
### Resolution for scenario 1

1. Put the cluster into maintenance-mode:

   ```bash
   sudo crm configure property maintenance-mode=true
   ```
2. Edit the `/etc/sysconfig/sbd` file to change the `SBD_DELAY_START` parameter to `yes`.

3. Remove the cluster from maintenance mode:

   ```bash
   sudo crm configure property maintenance-mode=false
   ```
4. Restart the Pacemaker and SDB services, or restart both nodes:

   ```bash
   sudo systemctl restart sbd
   sudo systemctl restart Pacemaker
   ```

## Scenario 2:  Pacemaker doesn't start and returns code 100 after node fencing

After the cluster node is fenced, the Pacemaker service exits without starting and returns an exit status code of **100**.

   ```bash
   systemctl status Pacemaker.service
   
   ● Pacemaker.service - Pacemaker High Availability Cluster Manager
      Loaded: loaded (/usr/lib/systemd/system/Pacemaker.service; enabled; vendor preset: disabled)
      Active: inactive (dead) since Wed 2020-05-13 23:38:21 UTC; 25s ago
        Docs: man:Pacemakerd
              https://clusterlabs.org/Pacemaker/doc/en-US/Pacemaker/1.1/html-single/Pacemaker_Explained/index.html
    Main PID: 1570 (code=exited, status=100)
   ```

### Cause for scenario 2

If a node tries to rejoin the cluster after it's fenced but before the `msgwait` time-out finishes, the Pacemaker service doesn't start. Instead, the service returns an exit status code of **100**. To resolve the issue, enable the `SBD_DELAY_START` setting, and specify an `msgwait` delay for the startup of sbd.service. This allows more time for the node to rejoin the cluster, and it makes sure that the node can rejoin without experiencing the `msgwait` conflict. 

Notice that if the `SBD_DELAY_START` setting is used, and the SBD `msgwait` value is very high, other potential issues might occur. For more information, see [Settings for long timeout in SBD_DELAY_START](https://www.suse.com/support/kb/doc/?id=000019356).

### Resolution A for scenario 2

1. Put the cluster into maintenance-mode:

   ```bash
   sudo crm configure property maintenance-mode=true
   ```

2. Edit the `/etc/sysconfig/sbd` file to change the `SBD_DELAY_START` parameter to `yes`.

3. Make a copy of `sbd.service`:

   ```bash
   cp /usr/lib/systemd/system/sbd.service /etc/systemd/system/sbd.service
   ```

4. Edit `/etc/systemd/system/sbd.service` to add the following lines in the `[Unit]` and `[Service]` section:

   ```bash
   [Unit]
   Before=corosync.service
   [Service]
   TimeoutSec=144
   ```

5. Remove the cluster from maintenance-mode:

   ```bash
   sudo crm configure property maintenance-mode=false
   ```

6. Restart the Pacemaker and SDB services, or restart both nodes:

   ```bash
   sudo systemctl restart sbd
   sudo systemctl restart Pacemaker
   ```

### Resolution B for scenario 2

Tweak the SDB device `msgwait` time-out setting to be shorter than the time that's required for the SBD fencing action to finish and the `sbd.service` to be restored after a restart. Edit the `watchdog` parameter to be 50 percent of new `msgwait` time-out value. This is a process of optimization that must be tuned on a system-by-system basis.

## Scenario 3: Issue occurs in azure-events agent resource

### Symptom for scenario 3

The `crm status` output shows a "failed resource actions" error that affects the Azure Events Monitor resource:

```output
'Failed Resource Actions:
* rsc_azure-events_monitor_10000 on node1 'error' (1): call=82, status='complete', exitreason='getInstanceInfo: Unable to get instance info', last-rc-change='2024-09-26 06:51:31 +10:00', queued=0ms, exec=94ms'
```

### Cause for scenario 3

The Azure platform host (physical server) that runs the cluster node receives a platform-level host maintenance update. If the duration of this update exceededs the time that's required for the cluster resource to initiate a restart, the resource actions fail.

The following error entries are logged in `/var/log/messages` on the cluster node:

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

The following error entries are logged in `/var/log/messages` on the cluster node:


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
2024-09-26T06:51:34.040432+10:00 node1 python3[11159]: File "/usr/lib/python3.6/site-packages/azurelinuxagent/common/protocol/wire.py", line 776, in update_goal_state
2024-09-26T06:51:34.040475+10:00 node1 python3[11159]: self._goal_state.update(silent=silent)
...
...
2024-09-26T06:51:34.040902+10:00 node1 python3[11159]: raise ResourceGoneError(response_error)
2024-09-26T06:51:34.040949+10:00 node1 python3[11159]: azurelinuxagent.common.exception.ResourceGoneError: [ResourceGoneError] [HTTP Failed] [410: Gone] b'<?xml version="1.0" encoding="utf-8"?>\n<Error xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">\n   <Code>ResourceNotAvailable</Code>\n    <Message>The resource requested is no longer available. Please refresh your cache.</Message>\n   <Details></Details>\n</Error>'
```

If the resource doesn't start three times, it fails completely. This requires manual intervention by the administrator to resolve the issue and perform cleanup:

```output
pacemaker-schedulerd[8995]:  warning: Unexpected result (error: getInstanceInfo: Unable to get instance info) was recorded for monitor of rsc_azure-events:0 on node1 at Sep 26 06:51:31 2024 
pacemaker-schedulerd[8995]:  warning: cln_azure-events cannot run on node1 due to reaching migration threshold (clean up resource to allow again)
```

> [!NOTE]
   >If no relevant log entries that indicate host-level updates or connectivity issues are captured from the platform layer, configure [rtmon](https://www.suse.com/support/kb/doc/?id=000019863) to make sure that the OS records the necessary details to identify the root cause, even if the platform doesn't capture logs.

### Resolution for scenario 3

Make sure that Pacemaker is configured correctly for Azure scheduled events. For more information, see [Configure Pacemaker for Azure scheduled events](/azure/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#configure-pacemaker-for-azure-scheduled-events).

We recommend that you modify the `rsc_azure-events` resource primitive configuration to incorporate a 60-second delay before the restart operation begins. This delay allows the Azure agents to finalize the host-level maintenance tasks without triggering complete resource failure. For more information, see the following SUSE KB article:[rsc_azure-events resource fails with error: Unable to get instance info](https://www.suse.com/support/kb/doc/?id=000021356).

To do this, follow these steps:

1. Put the cluster into maintenance mode:

   ```bash
   sudo crm configure property maintenance-mode=true
   ```

2. Enter the interactive configuration mode:  

   ```bash
   sudo crm configure edit rsc_azure-events
   ```

3. Modify the `rsc_azure-events` parameters, as shown in the following output:

   ```bash
   primitive rsc_azure-events azure-events \
        op monitor interval=10s timeout=240s \
        op start timeout=10s interval=0s start-delay=60s\
        op stop timeout=10s interval=0s \
        meta allow-unhealthy-nodes=true failure-timeout=120s
   ```
4. Save your changes, and exit the editor.
5. Verify the changes:

    ```bash
    sudo crm config show
    ```
6. Remove the cluster from maintenance mode:

    ```bash
    sudo crm configure property maintenance-mode=false
    ``` 
## Scenario 4: SAP HANA DB resource doesn't start

### Scenario 4, Symptom 1 - SAP HANA DB resource failed with time-out error

The start operation of the SAP High-Performance Analytic Appliance database (HANA DB) cluster resource (for example: `rsc_SAPHANA_DB01`) fails and returns a time-out error. However, HANA DB can be successfully started manually (outside the cluster control) while the cluster is in maintenance mode:

```output
pacemaker-execd[xxx]:  warning: rsc_SAPHANA_DB01_start_0 process (PID xxx) timed out
pacemaker-execd[xxx]:  warning: rsc_SAPHANA_DB01_start_0:xxx - timed out after 3600000ms
pacemaker-execd[xxx]:  notice: finished - rsc: rsc_SAPHANA_DB01 action:start call_id:25 pid:xxx exit-code:1 exec-time:3604053ms queue-time:0ms
pacemaker-controld[xxx]:  error: Result of start operation for rsc_SAPHANA_DB01 on xxx: Timed Out
```

### Cause for Scenario 4, Symptom 1

### Resolution for Scenario 4, Symptom 1

To resolve the issue, extend both the start and stop `timeout` parameters for the HANA DB resource, `rsc_SAPHANA_DB01`, as recommended in the SUSE KB article, [HANA DB resource failed to start](https://www.suse.com/support/kb/doc/?id=000020948).

**Example**

1. Put the cluster into maintenance mode:

   ```bash
   sudo crm configure property maintenance-mode=true
   ```
2. To prevent the cluster from restarting HANA DB, clean up the resources from previous failures if the cluster reports an error because of a failed startup:

   ```bash
   sudo crm resource cleanup
   ```

3. Edit the cluster configuration to update the `timeout` parameter of the start and stop operations:
    
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

4. Disable cluster maintenance mode:
    
    ```bash
    sudo crm configure property maintenance-mode=false
    ```
5. Verify that the changes were made:

   ```bash
   sudo crm config show
   ```

### Scenario 4, Symptom 2 - SAP HANA DB resource doesn't start and returns `unknown error`

SAP HANA DB doesn't start, and it returns an `unknown error` message.

The following text shows the `sudo crm status` output when this issue occurs:

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
### Cause for Scenario 4, Symptom 2 

Pacemaker can't start the SAP HANA resource if `SYN failures` exist between the primary and secondary nodes.

The secondary cluster node is in `WAITING4PRIM` status.

The `/var/log/messages` folder contains the following `SRHOOK=SFAIL` messages:

```output
2024-06-10T00:31:40.106622+02:00 node-1 SAPHana(rsc_SAPHana_P2H_HDB00)[55890]: INFO: RA: SRHOOK1=
2024-06-10T00:31:40.149443+02:00 node-1 SAPHana(rsc_SAPHana_P2H_HDB00)[55890]: INFO: RA: SRHOOK2=SFAIL
2024-06-10T00:31:40.155744+02:00 node-1 SAPHana(rsc_SAPHana_P2H_HDB00)[55890]: INFO: RA: SRHOOK3=SFAIL
```

When you run `sudo SAPHanaSR-showAttr`, the following sync status of the primary and secondary DB nodes is displayed:

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

### Workaround for Scenario 4, Symptom 2 

Pacemaker can't start the SAP HANA resource if `SYN failures` exist between the primary and secondary cluster nodes. To mitigate this issue, manually enable `SYN` between the primary and secondary nodes.
 
>[!IMPORTANT]
> Perform steps 2, 3, and 4 by using the SAP administrator account. This is because these steps use the SAP System ID to stop, start, and re-enable replication manually.
  
1. Put the cluster into maintenance mode:
   
    ```bash
    sudo crm configure property maintenance-mode=true
    ```

2. Check the SAP HANA DB and processes state:

     - Check the SAP-related processes that are running in the node. To do this, run HANA Database (HBD) info on every node. The SAP Admin should be able to confirm whether the required processes that are running on both the nodes and that the databases on both nodes remain synchronized.

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

     - If the SAP DB and services aren't active on the node, contact your SAP administrator to review and troubleshoot the issue:

       ```bash
       sudo HDB stop
       ```
       or  

       ```bash
       sudo sapcontrol -nr <SAPInstanceNo.> -function Stop
       ```

      Replace `<SAPInstanceNo.>` with the number of the instance that has to be stopped. 
     
    - After the stop operation is finished, start HANA DB in the primary node and then in the secondary node:

       ```bash
       sudo HDB start
       ```
       or  

       ```bash
       sudo sapcontrol -nr <SAPInstanceNo.> -function Start
       ```
3. Typically, the stop and start operations of HANA DB should synchronize both nodes. If the database nodes are still not synchronized, the SAP administrator should troubleshoot the issue by reviewing SAP logs to make sure that the database nodes are correctly synchronized.

    >[!NOTE]
    >The SAP administrator must determine which node should be designated as the primary and which as the secondary to make sure that no database data is lost in the process.

4. After you enable replication, check the system replication status by using SAP system admin account. In this case, the user admin account is `hn1adm`.

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

    In the secondary node, check the output to see if the **mode** is set to `SYNC`.
      
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

5. You can also verify the SAP HANA system replication by running the following command:

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

6. Exit the SAP Admin account, and remove the cluster from maintenance mode:

   ```bash
   sudo crm configure property maintenance-mode=false
   ```
7. Make sure that the Pacemaker cluster resources are running successfully.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
