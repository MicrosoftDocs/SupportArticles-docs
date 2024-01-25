---
title: Cluster service startup options
description: List all the available switches that can be used as startup parameters to start the Cluster service.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: eldenc, kaushika
ms.custom: sap:cluster-service-fails-to-start, csstroubleshoot
ms.subservice: high-availability
---
# Cluster service startup options

This article lists all the available switches that can be used as startup parameters to start the Cluster service.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 258078

## Summary

This is a list of all the available switches that can be used as startup parameters to start the Cluster service.

To do this, go to the properties of the service, put the appropriate switch in the Start Parameters box, and then click Start.

You can also use the switches when you start the Cluster service from the command line. For example:

```console
net start clussvc.exe / switch  
```

> [!NOTE]
> Include a dash (-) before the switch for Microsoft Windows 2000 Server and earlier versions.
>
> The debug switch has special startup parameters. See the [Debug](#debug) section later in this article for correct usage.

Windows Server 2003 includes abbreviations for each switch. This simplifies using Cluster service startup switches. For example, you can start the service with the `/FixQuorum` switch _or_ the `/FQ` switch.

Valid option switches include the following:

|Switch|Function|Windows 2003 Abbreviation|
|---|---|---|
| FixQuorum|Don't mount the quorum device, and quorum logging turned off.|FQ|
| NoQuorumLogging|Quorum logging turned off.|NQ|
| Debug|Displays events during the start of Cluster service. For special syntax, see the "Debug" section later in this article.||
| LogLevel N|Sets the log level for debug mode.||
| DebugResMon|The Cluster service waits for a debugger to be attached to all Resource Monitor processes at their start.|DR|
  
Windows 2000 and later only switches include the following.

|Switch|Function|Windows 2003 Abbreviation|
|---|---|---|
| ResetQuorumLog|Dynamically re-creates the quorum log and checkpoint files (this functionality is automatic in Microsoft Windows NT 4.0).|RQ|
| NoRepEvtLogging|No replication of Event Log entries.||
  
Windows Server 2003 and later only switches include the following.

|Switch|Function|Windows 2003 Abbreviation|
|---|---|---|
| ForceQuorum or \<N1,N2,...>|Force a majority node set with the node list N1, N2, and so forth. (Applicable only for Majority Node Set quorum.)|FO|
| NoGroupInfoEvtLogging|Don't log events to the event log related to group online and offline.|NG|
  
## Description of switches

The following is a description of some of the switches:

### Debug

_Function_: Cluster logging may not contain any helpful information in diagnosing Cluster service to start failures. This is because the Cluster service may fail prior to the Cluster.log starting. Starting the Cluster service with this switch displays the initialization of the Cluster service and can help you identify these early occurring problems.

_Requirements_: Use this switch for temporary diagnostic purposes only. If the Cluster service fails to start because of a logon error of the service account, or another system-related error, the service may not have a chance to run. As a result, a cluster.log file may not be created. This method runs the service outside the normal environment given by the Service Control Manager. To use this switch, you must be logged on locally with administrative rights and start the command from the command prompt. Don't use the debug switch for normal use or for any length of time. The service doesn't run as efficiently with the option set.

_Usage scenarios_: This switch must be used only when the Cluster service fails to start up. This switch will display on the screen the operation of the Cluster service as it tries to start. This switch can only be used when starting the service from the command prompt, and you must be in the folder where the Cluster service is installed. By default, this is %SystemRoot%\Cluster. This is also the only switch that you don't use with the net start command to start the service.

_Operation_: Open a command prompt, change to the %SystemRoot%\cluster folder, and then type the following `clussvc /debug [loglevel#] "`.

where **loglevel#** is one of the following.

|#|Description|
|---|---|
| 0|No logging takes place.|
| 1|Only errors are logged.|
| 2|Errors and warnings are logged.|
| 3|All events, including those not written to the event log, are logged.|

Alternatively, you can also use the set command to control the cluster log level when you use the debug switch. From the command prompt, type the following set clusterloglevel= **x** where **x** is one of the values that is shown in the previous table.

The Cluster service sends output to the window similar to what you would see in the cluster.log. Alternatively, you can also capture this information to a file by using the following command syntax:

`clussvc /debug > c:\debug.log`

When the Cluster service is running correctly, press CTRL+C to stop the service.

> [!NOTE]
> You can use the ClusterLogLevel environment variable to control the output level when you use the debug switch.

### FixQuorum

_Function_: Lets the cluster service start up despite problems with the quorum device. The only resources that will be brought online once the service is started is the Cluster IP Address and the Cluster Name. You can open Cluster Administrator and bring other resources online manually.

_Requirements_: This switch MUST be used only in diagnosis mode on a very temporary basis and not during normal operation. Only one node must be started up using this switch and a second node must not be attempted to be joined to the node started up using this switch. Typically, this switch is used alone.

_Usage scenarios:_ If the cluster service is unable to start up in the normal way because of the failure of the quorum resource, users can start up the cluster service in this mode and attempt to diagnose the failure.

_Operation:_ After the cluster service is started up, all resources including the quorum resource remain offline. Users can then manually try to bring the quorum resource online and monitor the cluster log entries as well as the new event log entries and attempt to diagnose any problems with the quorum resource. The syntax is as follows: `net start clussvc /fixquorum`.

### ResetQuorumLog

_Function_: If the quorum log and checkpoint file isn't found or is corrupt, this can be used to create files based on the information in the local node's %SystemRoot%\Cluster\CLUSDB registry hive. If the quorum log file is found to be in proper order, this switch has no effect.

_Requirements_: Typically, only one node is started up by using this switch, and this switch is used alone. It must be used only by experienced users who understand the consequences of using information that is potentially out of date, to create a new quorum log file.

_Usage scenarios_: This switch must be used only when the Cluster service fails to start up on a Windows 2000 or later machine because of a missing or corrupted quorum log (Quolog.log) and Chkxxx.tmp files. Windows NT 4.0 will automatically re-create these files if they don't exist. This functionality was added in Windows 2000 to give more control over the start of the Cluster service.

> [!NOTE]
> If the cluster is running Windows 2000 Service Pack 4 (SP4) and the hotfix 872970 has previously been installed, `/resetquorumlog` is no longer needed. The default behavior is to create a new log file at startup if the old one is missing or corrupt.

_Operation_: The Cluster service does an auto-reset of the quorum log file if it's found to be missing or corrupted by using the information in the currently loaded cluster hive by using the file %systemroot%\Cluster\CLUSDB. The syntax is as follows:

```console
net start clussvc /resetquorumlog
```

### DebugResMon

_Function_: Helps you to debug the resource monitor process and, therefore, the resource dynamic-link libraries (DLLs) that are loaded by the resource monitor. You can use any standard Windows-based debugger.

_Requirements_: Can only be used when the cluster service is started from the command prompt and when using the debug switch. There's no equivalent registry setting that can be used when Cluster service is run as a service. Debugger must be available for attaching to the resource monitor when it starts up. Typically, this switch is used alone.

_Usage scenarios_: Developers can use this switch to debug the resource monitor process and their custom resource DLLs. This option is extremely useful if a bug in a resource DLL causes the resource monitor process to quit unexpectedly soon after it's started up by the Cluster service and before users can manually attach a debugger to the resource monitor process.

_Operation_: Just before the resource monitor process is started up, the Cluster service process waits with a message (Waiting for debugger to connect to the resmon process **X**),where **X** is the Process ID (PID) of the resource monitor process. The Cluster service does this waiting for all resource monitor processes created by it. After the user attaches a debugger to the resource monitor process, and the resource monitor process starts up, the Cluster service continues with its initialization.

### NoRepEvtLogging

_Function_: The norepevtlogging switch prevents replication of those events recorded in the event log. This switch is useful in reducing the amount of information displayed in the command window by filtering out events already recorded in the event log. Event log replication is a feature that was added in Windows 2000.

_Usage scenarios_: This switch is used to prevent replication of the event logs. If there's a large number of event log entries, the Cluster service will replicate these, and log these to the cluster.log. This can cause the cluster.log to wrap quickly. The switch can also be used to start the Cluster service and log those events that aren't recorded in the event log to a local file, Debugnorep.log. The syntax is as follows:

```console
clussvc /debug /norepevtlogging > c:\debugnorep.log\
```

_Operation_: The norepevtlogging command can be set as a start parameter when starting the Cluster service from the Computer Management console.

The command-line syntax is:

```console
net start clussvc /norepevtlogging
```

This command prevents the node that was started with this switch from replicating its information to other nodes, but it will still receive information from other nodes that were started normally.

### NoQuorumLogging

_Function_: Turns off all logging of the cluster registry changes to the quorum disk. Registry check pointing doesn't affect other resources.

_Requirements_: This switch must be used only in diagnosis mode to diagnose problems with the quorum log file (Quolog.log) or the cluster hive checkpoint file (Chkxxx.tmp) in the \MSCS directory on the quorum drive. If one node is started up by using this switch, any other node must also be started up by using this switch. Typically, this switch is used on one node alone.

_Usage scenarios_: Use this switch when the quorum log file or checkpoint files become corrupted and you want to manually replace these files with backup copies.

_Operation_: The Cluster service completely bypasses the logging functionality in this case. When run in this mode, "partition-in-time" scenarios can occur. If this is the case, cluster node registry entries can fall out of synchronization, and new changes can be lost. The syntax is as follows: `net start clussvc /noquorumlogging`.

### ForceQuorum

_Function_: When you use a Majority Node Set (MNS) quorum model on a Windows Server 2003 cluster, in some cases a cluster must be allowed to continue to run even if it doesn't have quorum (majority). Consider the case of a geographically dispersed cluster with four nodes at the primary site and three nodes at the secondary site. While there are no failures, the cluster is a seven-node cluster where resources can be hosted on any node, on any site. If there's a communications failure between the sites or if the secondary site is taken offline (or fails), the primary site can continue because it will still have quorum. All resources will be re-hosted and brought online at the primary site.

In the event of a catastrophic failure of the primary site, however, the secondary site will lose quorum, and, therefore, all resources will be terminated at that site. One of the primary purposes for having a multi-site cluster is to survive a disaster at the primary site; however, the cluster software itself can't make a determination about the state of the primary site. The cluster software can't differentiate between a communications failure between the sites and a disaster at the primary site. That must be done by manual intervention. In other words, the secondary site can be forced to continue even though the Cluster service believes it doesn't have quorum. This is known as forcing quorum.

Because this mechanism is effectively breaking the semantics associated with the quorum replica set, it must only be done under controlled conditions. In the example above, if the secondary site and primary site lose communication and an administrator forces quorum at the secondary site, resources will be brought online at BOTH sites, thus allowing the potential for inconsistent data or data corruption in the cluster.

_Requirements_: Forcing quorum is a manual process that requires that you stop the Cluster service on ALL the remaining nodes. The Cluster service must be told which nodes should be considered as having quorum.

_Usage scenarios_: Special care must be taken if and when the primary site comes back because the nodes are configured as part of the cluster. While a cluster is running in the force quorum state, it's fully functional. For example, nodes can be added or removed from the cluster; new resources, groups, and so forth, can be defined.

> [!NOTE]
> The Cluster service on all nodes NOT in the force quorum node list must remain stopped until the force quorum information is removed. Failure to do so can lead to data inconsistencies OR data corruption.

_Operation_: Set up the Cluster service startup parameters on ALL remaining nodes in the cluster. This is done by starting up the Services control panel, selecting the Cluster service, and then entering the following in the **Start parameters** option:

```console
net start clussvc /forcequorum node_list
```

For example, if the secondary site contains Node5, Node6, and Node7, and you wanted to start the Cluster service and have those be the only nodes in the cluster, use the following command:

```console
net start clussvc /forcequorum /forcequorum node5,node6,node7
```

> [!NOTE]
> There should be no spaces in the key (except where there are spaces in the node names themselves).
