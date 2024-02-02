---
title: Troubleshoot replication error 8606
description: Provides a resolution to an issue where Active Directory replication fails with error 8606.
ms.date: 08/03/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
ms.subservice: active-directory
---
# Active Directory Replication Error 8606: Insufficient attributes were given to create an object

This article provides help to troubleshoot Active Directory replication error 8606: Insufficient attributes were given to create an object.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2028495

> [!NOTE]
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com/en-us).

## Summary

This article describes the symptoms and causes of an issue in which Active Directory replication is unsuccessful and generates error 8606: "Insufficient attributes were given to create an object. This object may not exist because it may have been deleted." This article also describes a resolution for this issue.

## Symptoms

### Symptom 1

The DCDIAG reports that the Active Directory Replications test failed with error 8606: "Insufficient attributes were given to create an object."  
>Starting test: Replications  
[Replications Check, \<Destination DC>] A recent replication attempt failed:  
From \<source DC> to \<destination DC>  
Naming Context: \<directory partition DN path>  
The replication generated an error (8606):  
Insufficient attributes were given to create an object. This object may not exist because it may have been deleted and already garbage collected  
The failure occurred at \<date> \<time>  
The last success occurred at \<date> \<time>  

### Symptom 2

Incoming replication that is triggered by the Replicate Now  command in the Active Directory Sites and Services snap-in DSSITE.MSC is unsuccessful and generates the error "Insufficient attributes were given to create an object." When you right-click a connection object from a source DC and then select Replicate now, the replication is unsuccessful and generates the following error: "Access is denied." Additionally, you receive the following error message:  

> Dialog title text: Replicate Now  
Dialog message text: The following error occurred during the attempt to synchronize naming context <%active directory partition name%> from domain controller \<source DC> to domain controller \<destination DC>:  
>
> Insufficient attributes were given to create an object. This object may not exist because it may have been deleted and already garbage collected.
>
> The operation will not continue

### Symptom 3

Various *repadmin.exe* commands fail with error 8606. These commands include but are not limited to the following:  

`repadmin /add`  `repadmin /replsum`  
`repadmin /showrepl` `repadmin /showrepl`  
`repadmin /syncall`

### Symptom 4

Event 1988 is logged shortly after one of the following events occurs:  

- The first domain controller in the forest is deployed.
- Any update to the partial attribute set is made.

### Symptom 5

NTDS replication event 1988 may be logged in the Directory Service event log of domain controllers that are trying to inbound-replicate Active Directory.

> Type: Error  
Source: NTDS Replication  
Category: Replication  
Event ID: 1988  
User: NT AUTHORITY\ANONYMOUS LOGON  
Computer: \<hostname of DC that logged event, aka the "destination" DC in the replication attempt>  
Description: The local domain controller has attempted to replicate the following object from the following source domain controller. This object is not present on the local domain controller because it may have been deleted and already garbage collected.  
Source domain controller:  
\<fully qualified GUIDED CNAME of source DC>  
Object:  
\<DN path of live object on source DC>  
Object GUID:  
\<object GUID of object on source DCs copy of Active Directory>

## Cause

Error 8606 is logged when the following conditions are true:  

- A source domain controller sends an update to an object (instead of an originating object create) that has already been created, deleted, and then reclaimed by garbage collection from a destination domain controller's copy of Active Directory.  
- The destination domain controller was configured to run in [strict replication consistency.](https://technet.microsoft.com/library/cc816938%28ws.10%29.aspx)  

If the destination domain controller was configured to use loose replication consistency, the object would have been "reanimated" on the destination domain controller's copy of the directory. Specific variations that can cause error are 8606 documented in the "More Information" section. However, the error is caused by one of the following:  

- A permanently lingering object whose removal will require admin intervention
- A transient lingering object that will correct itself when the source domain controller performs its next garbage-collection cleanup. The introduction of the first domain controller in an existing forest and updates to the partial attribute set are known causes of this condition.
- An object that was undeleted or restored at the cusp of tombstone lifetime expiration

When you troubleshoot 8606 errors, think about the following points:  

- Although error 8606 is logged on the destination domain controller, the problem object that is blocking replication resides on the source domain controller. Additionally, the source domain controller or a transitive replication partner of the source domain controller potentially did not inbound-replicate knowledge of a deleted tombstone lifetime number of days in the past.  
- Lingering objects may exist under the following circumstances:  

  - As "live" objects, as CNF or conflict mangled objects "live" objects, or as CNF or conflict mangled objects in the deleted objects container of the source domain controller  
  - In any directory partition except the schema partition. Lingering objects are most frequently found in read-only domain partitions on GCs. Lingering objects may also exist in writable domain partitions as well as the configuration partition. The schema partition does not support deletes.  
  - In any object class (users, computers, groups, and DNS records are most common).

- Remember to search for potentially lingering objects by object GUID versus DN path so that objects can be found regardless of their host partition and parent container. Searching by objectguid will also locate objects that are in the deleted objects container without using the deleted objects LDAP control.  
- The NTDS Replication 1988 event identifies only the current object on the source domain controller that is blocking incoming replication by a strict mode destination domain controller. There are likely additional objects "behind" the object that is referenced in the 1988 event that is also lingering.  
- The presence of lingering objects on a source domain controller prevents or blocks strict mode destination domain controllers from inbound-replicating "good" changes that exist behind the lingering object in the replication queue.  
- Because of the way that domain controllers individually delete objects from their deleted object containers (the garbage-collection daemon runs every 12 hours from the last time each domain controller last started), the objects that are causing 8606 errors on destination domain controllers could be subject to removal in the next garbage-collection cleanup execution. Lingering objects in this class are transient and should remove themselves in no more than 12 hours from problem start.
- The lingering object in question is likely one that was intentionally deleted by an administrator or application. Factor this into your resolution plan, and beware of reanimating objects, especially security principals that were intentionally deleted. Resolution

## Resolution

1. Identify the current value for the forest-wide **TombStoneLifeTime** setting.

    ```console
    repadmin /showattr "CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=forest root domain,DC=TLD" /atts:tombstonelifetime  
    ```

    See the "Tombstone lifetime and replication of deletions" section in the following article in the Microsoft Knowledge Base:  
    [910205](https://support.microsoft.com/help/910205) Information about lingering objects in a Windows Server Active Directory forest.

2. For each destination domain controller that is logging the 8606 error, filter the Directory Service event log on NTDS Replication event 1988.

3. Collect metadata for each *unique* object that is cited in the NTDS Replication event 1988.
 From each 1988 event that is logged on the destination domain controller that cites a new object, populate the following table:

    | Object DN path| Object GUID| Source DC| Host partition| Live or deleted?| LastKnownParent| IsDeleted value |
    |---|---|---|---|---|---|---|
    | | | | | | | |
    | | | | | | | |
    | | | | | | | |
    | | | | | | | |
    | | | | | | | |

     Columns 1 through 5 of this table can be populated by reading values directly from fields in the NTDS Replication 1988 events that are logged in the Directory Service event logs of the destination domain controllers that are logging either the 1988 event or the 8606 replication status.

    The date stamps for LastKnownParent and IsDeleted columns can be determined by running `repadmin /showobjmeta` and referencing the objectguid of the object that is cited in the NTDS replication 1988 event. To do this, use the following syntax:

    ```console  
    repadmin /showobjmeta <fqdn of source DC from 1988 event> "<GUID=GUID of object cited in the 1988 event>"
    ```

    The date stamp for LastKnownParent identifies the date on which the object was deleted. The date stamp for IsDeleted tells you when the object was last deleted or reanimated. The version number tells you whether the last modification deleted or reanimated the object. An IsDeleteted value of 1 represents an initial delete. Odd-numbered values greater than 1 indicate a reanimation following at least one deletion. For example, an **isDeleted** value of 2 represents an object that was deleted (version 1) and then later undeleted or reanimated (version 2). Later even-numbered values for IsDeleted represent later reanimations or undeletes of the object.

4. Select the appropriate action based on the object metadata cited in the 1988 event.  

    Error 8606 / NTDS Replication event 1988 event is most frequently caused by long-term replication failures that are preventing domain controllers from inbound-replicating knowledge of all originating deletes in the forest. This results in lingering objects on one or more source domain controllers.

    Review the metadata for object that is listed in the table that was created in step 4 of the "Resolution" section.

    If the object in the 1988 event is either ((live on the source domain controller) but (deleted on the destination domain controller for longer than tombstone lifetime expiration)), see "Removing Lingering Objects" and "." Objects in this condition must be manually removed by an administrator.

    Deleted objects may have been prematurely purged from the deleted objects container if system time jumped forward in time on the destination domain controller. Review the "Check for Time Jumps" section.

    If the object that is cited in the 1988 event exists in the deleted objects container of the source domain controller and its delete date is right at the cusp of tombstone lifetime expiration in such a way that the object was reclaimed by garbage collection by one or more destination domain controllers and *will* be reclaimed by garbage collection at the next garbage-collection interval on source domain controllers (that is, the lingering objects are *transient*), you have a choice. Either wait for the next garbage collection execution to delete the object, or manually trigger garbage collection on the source domain controller. See "Manually starting garbage collection." The introduction of the first domain controller, or any change in the partial attribute set, can cause this condition.

    If `repadmin /showobjmeta` output for the object that is cited in the 1988 event has a LastKnownParent value of 1, this indicates that the object was deleted, *and* an **IsDeleted** value that of 2 or some other even-numbered value, *and* that date stamp for IsDeleted is at the cusp of the tombstone lifetime number of days different from the date stamp for LastKnownParent, then the object was deleted and then undeleted / auth-restored while it was still live on the source domain controller but already reclaimed by garbage collection by destination domain controllers logging error 8606 / Event 1988. See Reanimations at the cusp of TSL expiration  

### How to remove lingering objects

While many methods exist to remove lingering objects, there are three primary tools commonly used: *repadmin.exe*, Lingering Object Liquidator (LoL) and repldiag.  

#### Lingering Object Liquidator (LoL)  

The easiest method to clean up Lingering Objects is to use the LoL. The LoL tool was developed to help automate the cleanup process against an Active Directory Forest. The tool is GUI-based and can scan the current Active Directory Forest and detect and cleanup lingering objects. The tool is available on [Microsoft Download Center](https://www.microsoft.com/download/details.aspx?id=56051).  

#### Repadmin  

The following two commands in *repadmin.exe* can remove lingering objects from directory partitions:

- `repadmin /removelingeringobjects`
- `repadmin /rehost`

The `repadmin /removelingeringobjects` command can be used to remove lingering objects from writable and read-only directory partitions on source domain controllers. The syntax is as follows:

```console  
repadmin /removelingeringobjects <Dest_DSA_LIST> <Source DSA GUID> <NC> [/ADVISORY_MODE]
```

Where:  
\<Dest_DSA_LIST> is the name of a domain controller that contains lingering objects (such as the source domain controller that is cited in the NTDS Replication 1988 event).  

\<Source DSA GUID> is the name of a domain controller that hosts a writable copy of the directory partition that contains lingering objects to which the domain controller in <Dest_DSA_LIST> has network connectivity. The DC to be cleaned up (first DC specified in the command) must be able to connect directly to port 389 on the DC that hosts a writable copy of the directory partition (specified second in the command).  

\<NC> is the DN path of the directory partition that is suspected of containing lingering objects, such as the partition that is specified in a 1988 event.

The `repadmin /rehost` command can be used to remove lingering-objects domain controllers that host a *read-only* copy of a domain directory partition from domain controllers. The syntax is as follows:

```console  
repadmin /rehost DSA <Naming Context> <Good Source DSA Address>
```

Where:  
DSA is the name of a domain controller that hosts a read-only domain directory partition for a nonlocal domain. For example, a GC in root.contoso.com can rehost its read-only copy of child.contoso.com but cannot rehost root.contoso.com.

\<Naming Context> is the DN path of a read-only domain directory partition that is residing in a global catalog.

\<Good Source DSA Address> is the name of a domain controller that hosts a writable copy of \<Naming Context>. The domain controller must be network-available to the DSA computer.

If the lingering object that is reported in the 1988 event is not removed by repadmin, evaluate whether the object on the source domain controller was created in USN gap, or whether the objects originating domain controller does not exist in the source domain controller's up-to-dateness vector.

#### Repldiag

> [!NOTE]
> Lingering objects can also be removed by using *repldiag.exe*. This tool automates the `repadmin /removelingeringobjects` process. Removing lingering objects from a forest with repldiag is as simple as running `repldiag /removelingeringobjects`.  However, it is usually best to exercise some control over the process in larger environments.  The option `/OverRideReferenceDC` allows you to select which DC is used for cleanup.  The option `/outputrepadmincommandlinesyntax` allows you to see what a forest-wide cleanup looks like using repadmin.

Launch the following TechNet on-demand lab for guided troubleshooting practice of this and other AD replication errors:

In the lab, you use both repadmin and *repldiag.exe* to remove lingering objects  
Troubleshooting Active Directory Replication Errors  
In this lab, you'll walk through the troubleshooting, analysis and implementation phases of commonly encountered Active Directory replication errors. You'll use a combination of ADREPLSTATUS, *repadmin.exe*, and other tools to troubleshoot a five DC, three-domain environment.  AD replication errors encountered in the lab include -2146893022, 1256, 1908, 8453 and 8606."

### Monitoring Active Directory replication health daily

If error 8606 / Event 1988 was caused by the domain controller's failing to replicate Active Directory changes in the last tombstone lifetime number of days, make sure that Active Directory replication health is being monitored on a day-to-day basis going forward. Replication health may be monitored by using a dedicated monitoring application or by viewing the output from the one inexpensive but effective option to run `repadmin /showrepl * /csv` command in a spreadsheet application such as Microsoft Excel. (See "Method 2: Monitor replication by using a command line" in Microsoft Knowledge Base article [910205).](https://support.microsoft.com/help/910205) 

Domain controllers that have not inbound-replicated in 50 percent of tombstone lifetime number of days should be put in a watch list that receive priority admin attention to make replication operational. Domain controllers that cannot be made to successfully replicate should be force-demoted if they have not replicated within 90 percent of TSL.

Replication failures that appear on a destination domain controller may be caused by the destination domain controller, by the source domain controller, or by the underlying network and DNS infrastructure.  

### Check for time jumps

To determine whether a time jump occurred, check date stamps in Event and diagnostic logs (Event Viewer, `repadmin /showreps`, netlogon logs, dcdiag reports) on destination domain controllers that are logging error 8606 / NTDS Replication 1988 events for the following:  

- Date stamps that predate the release of an operating system (for example, date stamps from CY 2003 for an OS released in CY 2008)
- Date stamps that predate the installation of the operating system in your forest
- Date stamps in the future
- Having no events that are logged in a given date range  

Microsoft Support teams have seen system time on production domain controllers incorrectly jump hours, days, weeks, years, and even tens of years in the past and future. If system time was found to be inaccurate, you should correct it and then try to determine why time jumped and what can be done to prevent inaccurate time going forward vs. just correcting the bad time. Possible questions include the following:  

- Was the forest root PDC configured by using an external time source?  
- Are reference online time sources available on the network and resolvable in DNS?  
- Was the Microsoft or third-party time service running and in an error-free state?  
- Are domain controller role computers configured to use NT5DS hierarchy to source time?  
- Was time rollback protection that is described in Microsoft Knowledge Base article [884776](https://support.microsoft.com/help/884776) in place?
- Do system clocks have good batteries and accurate time in the BIOS on domain controllers on virtual host computers?  
- Are virtual host and guest computers configured to source time according to the hosting manufacturer's recommendations?  
Microsoft Knowledge Base article [884776](https://support.microsoft.com/help/884776) documents steps to help protect domain controllers from "listening" to invalid time samples. More information about MaxPosPhaseCorrection and MaxNegPhaseCorrection is available in the W32Time Blog post [Windows Time Service](https://blogs.msdn.com/w32time/archive/2008/02/28/configuring-the-time-service-max-pos-neg-phasecorrection.aspx).  

Check for lingering objects by using `repadmin /removelingeringobjects /advisorymode`, and then remove them as required.

Relax "Allow replication with Divergent and corrupt partner" as required.

### How to manually start garbage collection

Several options exist to manually trigger garbage collection on a specific domain controller:

Run "repadmin /setattr "" "" doGarbageCollection add 1"

Run LDIFDE /s \<server> /i /f dogarbage.ldif where dobarbage.ldif contains the text:  

> dn:  
changetype: modify  
replace: DoGarbageCollection  
dogarbagecollection: 1  
\-  

> [!NOTE]
> The final "-" character is a *required* element of the .ldif file.

### Reanimations at the cusp of TSL expiration

For this condition to exist, `repadmin /showobject "<GUID=object guid for object in 1988 event>"` should report that the object is
"not found" on the destination domain controller but is live on the source domain controller and is either a deleted or a nondeleted object.

A review of key fields from `repadmin /showobjmeta` on the source domain controller should report that the following are true:
 LastKnownParent has a value of 1, and its date stamp is at the cusp of TSL days in the past. Its date stamp indicates the delete date of the object.

IsDeleted has a version number of 2 (or another even-numbered value), where version 1 defined the original deletion and version 2 is the restore / reanimation. The date stamp for "isDeleted=2" should be ~ TSL number of days later than the last change date for LastKnownParent.

Evaluate whether the object in question should remain a live object or a deleted object. If LastKnownParent has a value of 1, something or someone deleted the object. If this was not an *accidental* deletion, chances are good that the object should be deleted from any source domain controllers that have a live copy of the object.

If the object should exist on all replicas, the options are as follows:  

- Enable loose replication on strict mode destination domain controllers that do not have the object.
- Force-demote the domain controllers that have already garbage collected the object.
- Delete the object and then re-create it.

## More information

Launch the following TechNet on-demand lab for guided troubleshooting practice of this and other AD replication errors:

> Troubleshooting Active Directory Replication Errors  
 In this lab, you will walk through the troubleshooting, analysis, and implementation phases of commonly encountered Active Directory replication errors. You will use a combination of ADREPLSTATUS, *repadmin.exe*, and other tools to troubleshoot a five DC, three-domain environment. AD replication errors encountered in the lab include -2146893022, 1256, 1908, 8453 and 8606."

### Causes of lingering objects

#### Cause 1: The source domain controller sends updates to objects that have already been reclaimed by garbage collection on the destination domain controller because the source domain controller either was offline or failed replication for TSL elapsed number of days

The `CONTOSO.COM` domain contains two domain controllers in the same domain. Tombstone lifetime = 60 days. Strict replication is enabled on both domain controllers. DC2 experiences a motherboard failure. Meanwhile, DC1 makes originating deletes for stale security groups daily over the next 90 days. After it is offline for 90 days, DC2 receives a replacement motherboard, powers up, and then originates a DACL or SACL change on all user accounts *before* it inbound-replicates knowledge of originating deletes from DC1. DC1 logs 8606 errors for updates security groups that are purged on DC1 for the first 30 days that DC2 was offline.

#### Cause 2: The source DC sends updates to objects at the cusp of TSL expiration that have already been reclaimed by garbage collection by a strict mode destination DC

The `CONTOSO.COM` domain contains two domain controllers in the same domain. Tombstone lifetime = 60 days. Strict replication is enabled on both domain controllers. DC1 and DC2 replicate every 24 hours. DC1 originates-deletes daily. DC1 is in-place upgraded. This stamps new attribute on all objects in the configuration and writable domain partitions. This includes objects that are currently in the deleted objects container. Some of them were deleted 60 days ago and are now at the cusp of tombstone expiration. DC2 reclaims some objects by garbage collection that were deleted TSL days ago before the replication schedule opens with DC2. Error 8606 is logged until DC1 reclaims the blocking objects by garbage collection.

Any updates to the partial attribute set can cause temporary lingering objects that will clear themselves up after source domain controllers garbage-collect deleted objects at the cusp of TSL expiration (for example, the addition of the first W2K8 R2 domain controller to an existing forest).

#### Cause 3: A time jump on a destination domain controller prematurely speeds up the garbage collection of deleted objects on a destination domain controller

The `CONTOSO.COM` domain contains two domain controllers in the same domain. Tombstone lifetime = 60 days. Strict replication is enabled on both domain controllers. DC1 and DC2 replicate every 24 hours. DC1 originates deletes daily. The reference time source that is used by DC1 (but not DC2) rolls forward to calendar year 2039. This causes DC2 to also use a system time in CY2039. This causes DC1 to prematurely delete objects that are deleted today from its deleted objects container. Meanwhile, DC2 originates changes to attributes on users, computers, and groups that are live on DC2 but deleted and now prematurely garbage collected on DC1. DC1 will log error 8606 when it next inbound-replicates changes for the premature deleted objects.  

#### Cause 4: An object is reanimated at the cusp of TSL expiration

The `CONTOSO.COM` domain contains two domain controllers in the same domain. Tombstone lifetime = 60 days. Strict replication is enabled on both domain controllers. DC1 and DC2 replicate every 24 hours. DC1 originates deletes daily. An OU that contains users, computers, and groups are accidentally deleted. A system state backup that is made at the cusp of TSL in the past is auth-restored on DC2. The backup contains objects that are live on DC2 but already deleted and reclaimed by garbage collection on DC1.

#### Cause 5: A USN bubble is triggered the logging of the 8606

Say that you create an object in a USN bubble in such a way that it does not outbound-replicate because the destination domain controller "thinks" it has the object because of the bubble. Now, after the bubble closes, and after changes start to replicate again, a change is created for that object on the source domain controller and is displayed as a lingering object to the destination domain controller. The destination controller logs event 8606.  

### Requirements for end-to-end replicate knowledge of originating deletes

Active Directory domain controllers support multi-master replication where any domain controller (that holds a writable partition) can originate a create, change, or delete of an object or attribute (value). Knowledge of object / attribute deletes are persisted by the originating domain controller and any domain controller that has incoming replicated knowledge of an originating delete for TSL number of days. (See Microsoft Knowledge Base articles [216996](https://support.microsoft.com/help/216993) and [910205](https://support.microsoft.com/help/910205))

Active Directory requires end-to-end replication from all partition holders to transitively replicate all originating deletes for all directory partitions to all partition holders. Failure to inbound-replicate a directory partition in a rolling TSL number of days results in lingering objects. A lingering object is an object that was intentionally deleted by at least one domain controller but that incorrectly exists on destination domain controllers that did not inbound-replicate the transient knowledge of all unique deletions.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
