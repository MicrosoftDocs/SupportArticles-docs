---
title: Troubleshoot replication error 8461
description: This article describes the symptoms, cause, and resolution steps for cases when Active Directory replication fails with error 8461.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, justintu, v-jesits
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Troubleshooting AD Replication error 8461

This article describes symptoms, cause, and resolution steps for cases in which AD Replication is delayed and generates Win32 error 8461:  
> The replication operation was preempted.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2981628

## Symptoms

The specific symptoms are as follows:  

- Symptom 1:

    DCDIAG reports that the Active Directory Replications test has failed with error status (8461): The replication operation was preempted.

    Sample error text from DCDIAG resembles the following:  

    > Testing server: \<site>\<DC name>  
         Starting test: Replications  
             * Replications Check  
    >
    > REPLICATION LATENCY WARNING  
             [Replications Check,\<DC name>] This replication path was preempted by higher priority work.  
             From \<source DC> to \<destination DC>  
             Naming Context: DC=\<DN path>  
             The replication generated an error (8461):  
             The replication operation was preempted.  
             Replication of new changes along this path will be delayed.  
             Progress is occurring normally on this path.  

- Symptom 2:

  REPADMIN.EXE reports that the last replication attempt was delayed for a normal reason, result 8461 (0x210d).

  `REPADMIN` commands that commonly cite the 8461 status include but aren't limited to:

  - `REPADMIN /REPLSUM`
  - `REPADMIN /SHOWREPL`
  - `REPADMIN /SHOWREPS`
  - `REPADMIN /SYNCALL`

- Symptom 3:

    `Repadmin /rehost` fails and generates status code 8461.

- Symptom 4:  

    `Repadmin /queue` output reveals one or more tasks that have the status of "PREEMPTED."

    > [12142] Enqueued 2011-11-26 06:05:55 at priority 40  
    SYNC FROM SOURCE  
    NC dc=west,dc=contoso,dc=com  
    DSA Boulder\BoulderDC DC DSA object GUID *\<GUID>*  
    DSA transport addr *\<GUID>*._msdcs.contoso.com  
    ASYNCHRONOUS_OPERATION NEVER_COMPLETED NEVER_NOTIFY PREEMPTED

- Symptom 5:

    The "replicate now" command in Active Directory Sites and Services (DSSITE.MSC) fails and generates the following error message:  
    > The replication operation was preempted.

    Dialog title: Replicate Now  
    Message text: The following error occurred during the attempt to synchronize naming context \<DNS name of directory partition> from domain controller \<source DC>  
    to domain controller \<destination DC>:  
    The replication operation was preempted.

- Symptom 6:

    Events in the Directory Services event log cite the error status 8461.

    |Event Source and Event ID|Message|
    |---|---|
    |NTDS Replication 1839|The following number of operations is waiting in the replication queue. The oldest operation has been waiting since the following time. Time: \<date> \<time> Number of waiting operations: \<value> This condition can occur if the overall replication workload on this domain controller is too large or the replication interval is too small.|
    |NTDS Replication 2094|Performance warning: replication was delayed while applying changes to the following object. If this message occurs frequently, it indicates that the replication is occurring slowly and that the server may have difficulty keeping up with changes.|

    > Source: NTDS Replication  
    Event ID 1839  
    Type: Warning  
    Description:  
    The following number of operations is waiting  
    in the replication queue. The oldest operation has  
    been waiting since the following time.  
    Time:  
    Number of waiting operations:  
    This condition can occur if the overall  
    replication workload on this domain controller is  
    too large or the replication interval is too small.

    > [!Note]  
    > Event 1580 is also logged when long-running replication tasks complete if verbose replication diagnostics logging has been set to a value of 0x1 or greater.

    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\NTDS\Diagnostics]
    "5 Replication Events"=dword:00000001

    |Event Source and Event ID| Event String |
    |---|---|
    |NTDS Replication 1580|A long-running Active Directory Domain Services inbound replication task has finished with the following parameters.<br/><br/>Elapsed time (minutes):<br/>84<br/><br/>Operation:<br/>Synchronize Replica<br/><br/>Options:<br/>0x21000051<br/><br/>Parameter 1:<br/>DC=Contoso,DC=com<br/><br/>Parameter 2:<br/>\<source DCs ntds settings object object guid><br/><br/>Parameter 3: <br/><br/>Parameter 4: <br/><br/>A long-running replication task may also occur when a system has been unavailable or a directory partition has been unavailable for an extended period of time. A long-running replication task may indicate a large number of updates, or a number of complex updates occurring at the source directory service. Performing these updates during non-critical times may prevent replication delays.<br/><br/>A long running replication task is normal in the case of adding a new directory partition to Active Directory Domain Services. This can occur because of a new installation, global catalog promotion, or a connection generated by the Knowledge Consistency Checker (KCC).<br/><br/>Additional Data<br/><br/>Error value:<br/><br/>The operation completed successfully.|

## Cause

This replication status is returned when there are higher priority replication tasks in the destination DCs inbound queue.  It doesn't indicate a failure condition; the replication task isn't cancelled, instead, the task is put into a holding pattern until the higher priority work is completed.  It's normal to see this message returned periodically in larger environments, and it's important to note that the condition is transient.

While this issue is common and transient, some other AD replication problems can cause a backlog in the queue. If this occurs, you might start seeing replication tasks being preempted frequently. Frequent logging of event 2094 "Performance warning" (sample event are shown in the "Symptoms" and "Resolution" sections) is another indication that troubleshooting may be needed.

**Investigate those problems**  
Explanation of `repadmin /queue` and replication priority

**Analyze queue output over time to determine whether tasks are being processed**  
Explanation of `repadmin /showrepl /verbose`

|Active Directory replication has been preempted.|The progress of inbound replication was interrupted by a higher priority replication request, such as a request generated manually with the `repadmin /sync` command.|Wait for replication to complete. This informational message indicates normal operation.|
|---|---|---|
  
### Replication Load

- Too many partners
- Too frequent of object and attribute updates
- Frequent updates combined with inter-site change notification that results in a high rate of redundant change notifications
- Small replication schedule window

#### Performance-based issue

- Disk and or memory performance
- Network performance

## Resolution

This status does not indicate a failure condition.  This is a temporary issue in many cases and there are no resolution steps required.

If the status 8461 never clears, there is a lot of work to do to determine the correct path to take. This issue requires advanced knowledge of multiple troubleshooting tools. It may be necessary to seek the help of Microsoft Support to assist with the data analysis process.

You will have to determine the cause before you implement any steps to resolve an underlying problem. The cause of the replication status 8461 can occur in any of the following scenarios:

- Transient condition
- Replication load

  - Consistent Load
  - Temporary Load
- Performance issue

  - OS Performance
  - Disk Performance
  - Network Performance  

Determine whether this is only a transient condition. Document the time that manual replication is initiated, and find the corresponding tasks in the `repadmin /queue` output.  Sometime later, run `repadmin /queue`, and determine whether the manually initiated tasks are still present.

If replication tasks are queued.  Look at the currently running task, and investigate.

Use event log data, repadmin output, and performance monitor to help isolate the cause of the problem. Determine how quickly updates are being processed and what rate of change.

### Replication Load

#### Consistent

The domain controller has too many replication partners or under too great a replication load. Symptoms of an overloaded DC would be:

- A replication queue that never clears even though replication tasks are processed in a timely fashion

    > [!Note]  
    > You can use `repadmin /queue` over time and correlate this with performance data to identify this scenario.
- Frequent occurrence of replication status 8461
- Resolution: Reduce inbound connections (balance connections amongst hub-site DCs (ADLB.exe is useful here), add new DCs and rebalance the connections, deploy RODC in spoke sites, and decrease excessive replication of changes.

### Excessive replication

Attributes that are frequently updated.  Identify attribute updates using verbose replication event log events (or using `repadmin /showchanges`) and then correlate with `repadmin /showobjmeta` for several objects on the destination DC.  Look at the attribute identified in the event and look for a high version number, or get multiple logs for the same object throughout the day and see if the version number increases frequently.

### Temporary

- Bulk changes infrequently
- After hosting a partition for the first time or during a rehost

### Performance-based issue

Common symptoms for performance induced queue buildup include

Event ID 2094

> Event Type: Warning  
Event Source: NTDS Replication  
Event Category: Replication  
Event ID: 2094  
Description:  
Performance warning: replication was delayed  
while applying changes to the following object. If this  
message occurs frequently, it indicates that the  
replication is occurring slowly and that the server may  
have difficulty keeping up with changes.  
Object DN: CN=JUSTINTU,OU=Workstations,DC=contoso,DC=com  
Object GUID: *\<GUID>*  
Partition DN: DC=contoso,DC=com  
Server: *\<GUID>*._msdcs.contoso.com  
Elapsed Time (secs): 13  
User Action:  
A common reason for seeing this delay is that this object is especially large, either in the size of its values, or in the number of values. You should first consider whether the application can be changed to reduce the amount of data stored on the object, or the number of values.If this is a large group or distribution list, you might consider raising the forest version to Windows Server 2003, since this will enable replication to work more efficiently. You should evaluate whether the server platform provides sufficient performance in terms of memory and processing power. Finally, you may want to consider tuning the Active Directory database by moving the database and logs to separate disk partitions.  
>
> If you wish to change the warning limit, the registry key is included below. A value of zero will disable the check.  
>
> Additional Data Warning Limit (secs): 10 Limit Registry Key: System\CurrentControlSet\Services\NTDS\Parameters\Replicator maximum wait for update object (secs)

Determine whether changes that are applied to the database are occurring slowly by using performance monitoring and `repadmin /queue` output.  Correlate AD Replication counters with base OS performance counters (Disk, Memory, Network, and CPU).

DC

Disk

Network

> Queue contains 55 items.  
Current task began executing at *\<DateTime>*.  
Task has been executing for 508 minutes, 53 seconds.  
[6485] Enqueued 2011-11-26 01:55:33 at priority 590  
SYNC FROM SOURCE NC DC=corp,DC=contoso,DC=com  
DC Houston\5thWardDC  
DC object GUID *\<GUID>*  
DC transport addr *\<GUID>*._msdcs.contoso.com  
FORCE  
[12142] Enqueued *\<DateTime>* at priority 40  
SYNC FROM SOURCE NC dc=west,dc=contoso,dc=com  
DC Boulder\BoulderDC  
DC object GUID *\<GUID>*  
DC transport addr *\<GUID>*._msdcs.contoso.com  
ASYNCHRONOUS_OPERATION NEVER_COMPLETED NEVER_NOTIFY PREEMPTED

## More information

### Slow AD Replication troubleshooting

This issue requires advanced knowledge of multiple troubleshooting tools. It may be necessary to seek the help of Microsoft Support to assist with the data analysis process.

### Terminology:  Slow vs. latent

In slow AD replication, changes are committed to the Active Directory database slowly or replication tasks take a long time to process.

Common causes include:  

- DC / OS performance problems

  - Resource depletion
  - Disk bottleneck
- AD database problems

  - Logical or physical corruption
  - Object or attribute issues
- DC load issues

  - Handling too many clients
  - Replication storm

    - High rate of change to objects and attributes
    - Full partition syncs

In latent AD replication, the DC is not notified about changes for a long time:

Common causes include:  

- AD Topology Configuration (schedule, site links, replication schedule, disconnected topology)  

This document and data collection strategy is meant to be used for troubleshooting Slow AD Replication.  

### Symptoms of slow AD Replication

Data collection  

Repadmin Data  

Use `Repadmin /queue` to document the queued replication tasks.  Monitor the queue to see if there is a delay in processing replication tasks.  Log all `repadmin /queue` output to the same text file so you have good historical data.

```console
Repadmin /queue DCName >DCNameReplQueue.txt  
Choice /d y /t 300  
Repadmin /queue DCName >>DCNameReplQueue.txt  
Choice /d y /t 300  
Repadmin /queue DCName >>DCNameReplQueue.txt  
Choice /d y /t 900  
Repadmin /queue DCName >>DCNameReplQueue.txt  
Choice /d y /t 900  
Repadmin /queue DCName >>DCNameReplQueue.txt  
Choice /d y /t 1800  
Repadmin /queue DCName >>DCNameReplQueue.txt
```

Review the output to see whether replication tasks are processed in a timely manner. The top of the file contains the currently running task and the length of time it has been running. If the same task is always at the top of the output, you can use verbose output of `repadmin /showrepl` to monitor the progress.

Repadmin changes

`Repadmin /showrepl`

Use `Repadmin /showrepl` and the `/verbose` option to monitor the last replication status and the number of changes that remain to be replicated.

```console
Repadmin /showrepl /verbose DCNameDomainDN  

Repadmin /showrepl /verbose 5thwardCorpDC dc=corp,dc=contoso,dc=com
```

To limit the output so that only the desired Source DC is displayed, use the following:

```console
Repadmin /showrepl /verbose DCNameDomainDN SourceDcDSAObjectGUID

Repadmin /showrepl /verbose 5thwardCorpDC <GUID> dc=corp,dc=contoso,dc=com
```

`Repadmin /showutdvec`  

Use `Repadmin /showutdvec` on the source and destination DC to determine replication delta.

```console
repadmin /showutdvec DCName DomainDN

repadmin /showutdvec LiverpoolDC1 dc=north,dc=fabrikam,dc=com
```

Obtain `Repadmin /showutdvec /latency` from the source and destination DC for the partition in question.

In the output, document the following:

1. From source DCs showutdvec:
   USN # next to Source DCName
2. From destination DCs showutdvec
   USN# next to SOURCE DCNanme  

Source DC  

> Dallas\2008DC1 @ USN 451265 @ Time *\<DateTime>*  
Dallas\SourceDC @ USN 1126541 @ Time *\<DateTime>*  
Houston\2012DC3 @ USN 469842 @ Time *\<DateTime>*  
66a1b264-80b8-44f8-8356-9ebcd7a34f15 @ USN 32811 @ Time  *\<DateTime>*  
Dallas\2012DC2 @ USN 460219 @ Time   *\<DateTime>*  
Dallas\DestinationDC @ USN 1353465 @ Time  *\<DateTime>*  
Dallas\2003DC1 @ USN 15556 @ Time *\<DateTime>*

Destination DC  

> Dallas\2008DC1 @ USN 451265 @ Time *\<DateTime>*  
Dallas\SourceDC @ USN 801224 @ Time *\<DateTime>*  
Houston\2012DC3 @ USN 469842 @ Time *\<DateTime>*  
66a1b264-80b8-44f8-8356-9ebcd7a34f15 @ USN 32811 @ Time *\<DateTime>*  
Dallas\2012DC2 @ USN 460219 @ Time  *\<DateTime>*  
Dallas\DestinationDC @ USN 1359087 @ Time  *\<DateTime>*  
Dallas\2003DC1 @ USN 15556 @ Time *\<DateTime>*

Source DC  

SourceDC @ USN 1126541

Destination DC  

SourceDC @ USN 801224

1126541-801224 = 325317  

The destination DC is 325,317 USNs behind.  

> [!Note]
> You can also get the Source DCs **highestcommitedUSN** from the Source DC by using this command:

```console
repadmin /showattr SourceDC . /atts:highestcommittedusn DN: 1> highestCommittedUSN: 1126541
```

Performance Data  

Create a new User Defined Data Collector set in Performance Monitor that uses the AD Diagnostics template.  

The steps here detail how to set up a good set of baseline DC performance counters.  You will need to modify some of the settings, such as duration and sample interval to fit your specific scenario.  

How to Create a User Defined Data Collection Set  

1. Open Server Manager  on a Full version of Windows Server 2008 or a later version.
2. Expand Diagnostics  > Performance  > Data Collector Sets.
3. Right-click User Defined  and select New  > Data Collector Set.  
4. Type in a name such as _AD DS Diagnostics_, and leave the default selection of Create from a template (Recommended)  selected. Then, select Next.  
5. Select Active Directory Diagnostics from the list of templates and then select Next  and follow the Wizard prompts (making any changes you think are necessary).
6. Right-click the new User Defined data collector set and view the Properties.
7. To change the run time, modify the Overall Duration  settings in the Stop Condition  tab, and then click OK  to apply the changes.

Options to consider:

- Overall Duration -you can have the data collector stop after collecting for a set amount of time
- Limits -you can have the data collect stop after a time or size threshold is reached (with the option to have it automatically restart)

  Setting limits is advantageous when you want to limit the log size.  

  - Restart the data collector set at limits
  - Duration
  - Maximum Size

    :::image type="content" source="media/adrepl-troubleshoot-replication-error-8461/set-overall-duration-option.png" alt-text="Screenshot of the AD DS Diagnostics Properties window with the Maximum Size set to 100 MB.":::

View Performance Counter Properties for the User Defined Data Collector Set  

1. Select your new User Defined data collector set.
2. Right-click Performance Counter, and then select Properties.  

Here you have the options of changing the Sample interval and adding or removing additional counters.

For this scenario, the default-sampling interval of 3 seconds should be sufficient. However, for much longer sampling times, 3 seconds is too frequent an interval.

:::image type="content" source="media/adrepl-troubleshoot-replication-error-8461/sample-interval-setting.png" alt-text="Screenshot of the Performance Counter Properties window with 3 seconds set for the interval.":::

All recommended counters are included in the default AD Diagnostic's collector set with three exceptions:

- Database ==>Instances(lsass/NTDSA)\ *
- LogicalDisk(*)\\\*

    For LogicalDisk: all instances are not required - System drive and drives where database and logs are stored should be included at minimumSecurity System-Wide Statistics\\*
- Security System-Wide Statistics\\*  

To add the AD DS database counters to the User Defined Data Collection Set  

1. In _Performance Counter Properties_, select Add.  
2. Expand _Database ==>Instances_  (all counters should be highlighted).
3. Under Instances of selected object, select lsass/NTDSA  
4. Select Add,  and then click OK.

    :::image type="content" source="media/adrepl-troubleshoot-replication-error-8461/add-isass-ntdsa.png" alt-text="Screenshot of selected lsass/NTDSA under Instances of selected object.":::  

5. Add the LogicalDisk and Security System-Wide Statistics objects also.  

    :::image type="content" source="media/adrepl-troubleshoot-replication-error-8461/add-logicaldisk-security-wide-statistics-objects.png" alt-text="Screenshot of the Performance Counter Properties window with the LogicalDisk and Security System-Wide Statistics objects selected.":::

After the settings are configured to your liking, you can run the new data collector set directly from Server Manager or export it and deploy it to specific servers.

When you are ready to begin collecting performance data, start your newly defined Collection Set:

To start your newly defined Data Collection Set from the MMC:  

1. In the Performance Monitor mmc, navigate to Performance / Data Collector Sets / User Defined
2. Right-click the new collection set _AD DS Diagnostics_  and select Start.  
3. You can verify that it has started by selecting User Defined
 _AD DS Diagnostics_  should have a status of Running  

After testing is complete, stop the AD DS Diagnostics Collection Set:

1. In the Performance Monitor mmc, navigate to Performance / Data Collector Sets / User Defined.
2. Right-click the new collection set _AD DS Diagnostics_, and select Stop. You can verify that it has stopped by selecting User Defined.

_AD DS Diagnostics_  should go from a status of Running  to Compiling  and finally Stopped  _Please note that the MMC is not great about refreshing its view. So, if it seems to be stuck in Running or Compiling after you clickStop, try refreshing the screen._  

The compiled report is viewable under **Performance / Reports / User Defined / AD DS Diagnostics**  

The default path in Windows Explorer is here: _%systemdrive%\PerfLogs\Admin\AD DS Diagnostics_  

_Command-Line instructions:  Gather AD Diagnostics from the command line:_  

To START a collection of data from the command-line issue this command from an elevated command prompt: `logman start "user defined\AD DS Diagnostics" -ets`  
To STOP the collection of data before the default 5 minutes, issue this command: (get at least one full five-minute sample for this issue) `logman stop "user defined\AD DS Diagnostics" -ets`

Diagnostic data is logged here:  C:\PerfLogs\Admin\AD DS Diagnostics\\_DateStamp_  

Sample Data Collection Script

```console
logman start "system\Active Directory Diagnostics" -ets time /t >slow.txt  
repadmin /showrepl /verbose LiverpoolDC1 dc=north,dc=fabrikam,dc=com >slowrepl.txt  
repadmin /queue LiverpoolDC1 >>slow.txt  
repadmin /showutdvec LiverpoolDC1 dc=north,dc=fabrikam,dc=com >>slow.txt  
:start  
ping 127.0.0.1 -n 60 >NUL  
time /t >>slow.txt time /t >>slowrepl.txt  
repadmin /showrepl /verbose LiverpoolDC1 dc=north,dc=fabrikam,dc=com >>slowrepl.txt
repadmin /queue LiverpoolDC1 >>slow.txt  
repadmin /showutdvec LiverpoolDC1 dc=north,dc=fabrikam,dc=com >>slow.txt  
goto start
```

Event log data  

The default logging enabled in the directory services event log is useful to monitor for events that indicate slow application of changes. (EVENT X)  Verbose diagnostic logging can be enabled to see what changes are currently being applied.  Enabling diagnostic logging at the level mentioned in this article will cause the log to fill up rather quickly, so only enable it while actively troubleshooting this condition.  To give an idea of rate of events logged with this level of verbosity:

A Directory Services event log configured to 100 MB wrapped in less than two minutes (1 minute 27 seconds).  The log contained 195,728 events. Of all events, 189,340 were event ID 1412 (attribute addition).

- Increase the size of the Directory Services event log
- Size the event log so that the enhanced logging doesn't cause the log to wrap in too short of a period
- Enable AD Replication Diagnostic logging to 0x5:

    `HKLM\System\CurrentControlSet\Services\NTDS\Diagnostics 5 Replication Events = 5`

Export the Directory Services event log shortly after you receive the status 8461, and reduce the diagnostic logging to a suitable level.  

Review the event log for the following:

How quickly are attribute values are written to the database? ->Directory Services event log Event ID 1412 or even better, use performance counter: DirectoryServices / DRA Inbound Properties Applied/sec

At diagnostic level 5 for Replication Events, for user object creation, around 25 or so event 1412's (depending on what was written at time of user creation) are written (one per attribute value).  When all attributes have been added, the object creation event is logged (Event ID 1365).

The description section of the event contains the following data:

> Internal event:  
The following object changes were applied to the local Active Directory Domain Services database.  
Property: 900dd (sAMAccountName)  
Object: CN=xtestingusers14167,CN=Users,DC=north,DC=fabrikam,DC=com Object  
GUID: *\<GUID>*  
Remote version: 1  
Remote timestamp: *\<DateTime>*  
Remote Originating USN: 540828

The Property section contains both the attributeID and the lDAPDisplayName of the attribute.

One event is written per value at this debug log level.  Filter on the events and determine how many entries occur in a given period.  Review the event details in order to determine if we are writing values for multiple attributes in order to instantiate an object or if we are writing to the same attribute across multiple objects.  While this level of analysis can seem cumbersome, it can be useful in determining root cause.  As an example, if you see that we are only writing a few events per second then that could indicate that transactions are being written to the database slowly or perhaps we have too many partners that are sending redundant changes (event ID 1239).

Notice that it is perfectly normal to see event ID 1239 when replication diagnostics is set to 0x5.  If you filter out event 1239 and you see nothing else and you have a fairly long event log history, then that may indicate a problem.  This issue was observed by a customer with a large Active Directory environment that had inter-site change notification enabled. If you determine that there is a large number of events per second, replication is probably not affected by a performance problem.

Object Metadata  

If an event is logged that indicates a change is taking a long time to process Event ID,   record the objectGUID, and then get the following output:

Replication metadata:

```console
Repadmin /showobjmeta "<GUID=ObjectGUID>" >objectmeta.txt
```

Review the output for recently modified attributes.  Pay particular attention to attributes with frequently modified version numbers.  An attribute that has a high version count could indicate that frequent changes are being made to the attribute. If you suspect this, you can either view the attribute value to get some context as to why the attribute was changed, or you can let some time pass, and then get addition `repadmin /showobjmeta` output in order to check whether the version of the same attribute on the same object has increased further.

Object and attribute data:  

Use a utility to output the object and attribute values.  Then, review the attribute data for the attributes that have recently modified data. The following examples present two methods to do this.

Object attribute values from repadmin:  

```console
Repadmin /showattr DCName "<GUID=ObjectGUID>" /allvalues /long >objectByGuid.txt
```

Object attribute values from LDP  

Connect and bind to the server in LDP and copy all the output for the object to a text file

ldpoutput.txt  

Network-related data  

```console
Tasklist /svc >nets.txt Netstat -anob >>nets.txt
```

Data AnalysisKey AD Replication specific Performance Counters

- DRA Inbound Full Sync Objects Remaining
- DRA Inbound Objects Applied/Sec
- DRA Inbound Objects / Second (Inbound Replication)
- DRA Inbound Objects Filtered / Sec (Suggests all New Attributes)
- DRA Outbound Bytes Total Since Boot
 Replication Queue:  

|DirectoryServices\DRA Pending Replication Synchronizations|Indicates the number of directory synchronizations that are queued for this server. This counter helps identify replication backlogs-the higher the number, the larger the backlog.|This counter should be as low as possible. If it is not, the server hardware is probably slowing replication.|
|---|---|---|
  
Use this counter to determine the replication queue.  Repadmin /queue _DCName_ also reports this information.

Gauging Current Performance:  

|DRA Inbound Objects Applied/sec|Shows the number of objects received from neighbors through inbound replication and applied.|
|---|---|
|DRA Inbound Properties Applied/sec|Shows the total number of object properties (attributes) applied from inbound replication partners. |
  
You can use the two counters to monitor how quickly changes are being applied to the database.

Database:  

Server Performance:  

|DirectoryServices\DRA Inbound Object Updates Remaining in Packet|Indicates the number of object updates received in the most recent directory replication update packet that have not yet been applied to the local server.|This counter indicates that the monitored server is receiving changes, but it is taking a long time to apply them to the database. This counter should be as low as possible. If it is not, it usually indicates that server hardware is slowing replication.|
|---|---|---|
  
Network:  

|Object\counter|Description|Guidelines|
|---|---|---|
|DirectoryServices\DRA Inbound Bytes Total/sec|Indicates the total number of bytes received per second through inbound replication. This number is the sum of the bytes of uncompressed and compressed data received during inbound| |
  
#### Testing

Scenario
Two DCs were isolated (no client or other server activity)
15,000 users were created from script with the minimal attributes populated on one DC
Enabled the connection between the two DCs.

To give an idea of rate of events logged with this level of verbosity:

A Directory Services event log configured to 100 MB in size wrapped in less than two minutes (1 minute 27 seconds).  The log contained 195,728 events.  Of all events, 189,340 were event ID 1412 (attribute addition). The number of event 1412s per second:

01: 2400  
02: 3570  
03: 3540  
04: 2160  
05: 1170  
06: 1890  
07: 2225  
08: 1435  
09: 4233  
10: 2817  

Event ID 1365 (Object creation) was logged 6,312 times in 1 minute 27 seconds.
In one minute, 4,630 user objects were created, consisting of 138,900 attributes) or about 77 objects per second.

An understanding of NTDS performance counters is needed in order to troubleshoot this issue effectively.  

Object creations per second is obtained via the following performance counters:  

- NTDS / DRA Inbound Objects Applied/sec
- Database adds/sec
- NTDS / DRA Inbound Values (DNs only)/sec
This number includes objects that reference other objects. Values for distinguished names, such as group or distribution list memberships, are more expensive to apply than other kinds of values because a group or distribution list object can include hundreds or thousands of members. In contrast, a simple object might have only one or two attributes. A high number from this counter might explain why inbound changes are slow to be applied to the database.
Attribute creations per second is:

- NTDS / DRA Inbound Properties Applied/sec

#### Special Condition Frequently Encountered

Repadmin /rehost results in status 8461:

This issue occurs when the GC being rehosted is busy accepting updates for other partitions. The sourcing of writable domain partitions including schema, configuration, and domain partition are by nature higher priority work-items than the rehosting of a read-only domain partition.

Repadmin /queue output should show that the request to add the partition has been queued and will eventually be processed.  However, sometimes it is necessary to use an alternative method of partition rehost:

1. Repadmin /unhost
2. Wait for event ID 1660
3. Disable KCC connection translation
4. `Repadmin /addIf` the process is preempted before /add is complete, you can disable inbound replication and use `repadmin /replicate` and the `/readonly` and `/force` options to get the partition re-hosted before you re-enable inbound replication.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
