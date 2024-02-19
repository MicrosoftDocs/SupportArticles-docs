---
title: lingering objects in AD forest
description: Contains information about lingering objects in a forest. Specifically, it provides information about events that indicate the presence of lingering objects, the causes of lingering objects, and methods to remove lingering objects.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Information about lingering objects in a Windows Server Active Directory forest

This article provides some information about lingering objects in a Windows Server Active Directory forest.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 910205

## Summary

This article contains information about lingering objects in an Active Directory forest. Specifically, the article describes the events that indicate the presence of lingering objects, the causes of lingering objects, and the methods that you can use to remove lingering objects.  

## INTRODUCTION

Lingering objects can occur if a domain controller does not replicate for an interval of time that is longer than the tombstone lifetime (TSL). The domain controller then reconnects to the replication topology. Objects that are deleted from the Active Directory directory service when the domain controller is offline can remain on the domain controller as lingering objects. This article contains detailed information about the events that indicate the presence of lingering objects, the causes of lingering objects, and the methods that you can use to remove lingering objects.

## More information

### Tombstone lifetime and replication of deletions

When an object is deleted, Active Directory replicates the deletion as a tombstone object. A tombstone object consists of a small subset of the attributes of the deleted object. By inbound-replicating this object, other domain controllers in the domain and in the forest receive information about the deletion. The tombstone is retained in Active Directory for a specified period. This specified period is called the TSL. At the end of the TSL, the tombstone object is permanently deleted.

The default value of the TSL depends on the version of the operating system that is running on the first domain controller that is installed in a forest. The following table indicates the default TSL values for different Windows operating systems.

|First domain controller in forest root|Default tombstone lifetime|
|---|---|
|Windows 2000|60 days|
|Windows Server 2003|60 days|
|Windows Server 2003 with Service Pack 1|180 days|

> [!NOTE]
> The existing TSL value does not change when a domain controller is upgraded to Windows Server 2003 with Service Pack 1 (SP1). The existing TSL value is maintained until you manually change it.

After the tombstone is permanently deleted, the object deletion can no longer be replicated. The TSL defines how long domain controllers in the forest retain information about a deleted object. The TSL also defines the time during which all direct and transitive replication partners of the originating domain controller must receive a unique deletion.

### How lingering objects occur

When a domain controller is disconnected for a period that is longer than the TSL, one or more objects that are deleted from Active Directory on all other domain controllers may remain on the disconnected domain controller. Such objects are called lingering objects. Because the domain controller is offline during the time that the tombstone is alive, the domain controller never receives replication of the tombstone.

When this domain controller is reconnected to the replication topology, it acts as a source replication partner that has an object that its destination partner does not have.

Replication problems occur when the object on the source domain controller is updated. In this case, when the destination partner tries to inbound-replicate the update, the destination domain controller responds in one of two ways:

- If the destination domain controller has Strict Replication Consistency enabled, the controller recognizes that it cannot update the object. The controller locally stops inbound replication of the directory partition from the source domain controller.

- If the destination domain controller has Strict Replication Consistency disabled, the controller requests the full replica of the updated object. In this case, the object is reintroduced into the directory.

### Causes of long disconnections

The following conditions can cause long disconnections:

- A domain controller is disconnected from the network and is put in storage.
- The shipment of a pre-staged domain controller to its remote location takes longer than a TSL.

- Wide area network (WAN) connections are unavailable for long periods. For example, a domain controller on board a cruise ship may be unable to replicate because the ship is at sea for longer than the TSL.

- The reported event is a false positive because an administrator shortened the TSL to force the garbage collection of deleted objects.

- The reported event is a false positive because the system clock on the source or on the destination domain controller is incorrectly advanced or rolled back. Clock skews are most common following a system restart. Clock skews may occur for the following reasons:  

  - There is a problem with the system clock battery or with the motherboard.

  - The time source for a computer is configured incorrectly. It includes a time source server that is configured by using Windows Time service (W32Time), by using a third-party time server, or by using network routers.

  - An administrator advances or rolls back the system clock to extend the useful life of a system state backup or to accelerate the garbage collection of deleted objects. Make sure that the system clock reflects the actual time. Also, make sure that event logs do not contain invalid events from the future or from the past.

### Indications that a domain controller has lingering objects

An outdated domain controller can store lingering objects without any noticeable effect when the following conditions are true:  

- An administrator, an application, or a service does not update the lingering object.
- An administrator, an application, or a service does not try to create an object that has the same name in the domain.
- An administrator, an application, or a service does not try to create an object by using the same user principal name (UPN) in the forest.

Even when there is no noticeable effect, the presence of lingering objects can cause problems. These problems are most likely to occur if a lingering object is a security principal.

#### Events that indicate that lingering objects may be present in the forest

|Event ID|General description|
|---|---|
|1862|The local domain controller has not recently received replication information from several domain controllers (intersite).|
|1863|The local domain controller has not recently received replication information from several domain controllers (intersite).|
|1864|The local domain controller has not recently received replication information from several domain controllers (summary).|
|1311|The Knowledge Consistency Checker (KCC) was not able to build a spanning tree topology.|
|2042|It has been too long since this server last replicated with the named source server.|

#### Events that indicate that lingering objects are present in the forest

|Event ID|General description|
|---|---|
|1084|There is no such object on the server.|
|1388|This destination system received an update for an object that should have been present locally but was not.|
|1311|Another domain controller replicated an object not present on this domain controller.|

> [!NOTE]
> Lingering objects are not present on domain controllers that log Event ID 1988. The source domain controller contains the lingering object.

#### Repadmin errors that indicate that lingering objects are present in the forest

|Event ID|General description|
|---|---|
|8240|There is no such object on the server.|
|8606|Insufficient attributes were given to create an object.|

### Other indications that lingering objects are present in the forest

- A user or group account that was deleted remains in the global address list (GAL) on servers that are running Microsoft Exchange Server. Therefore, although the account name appears in the GAL, errors occur when users try to send e-mail messages.

- Multiple copies of an object appear in the object picker or in the GAL for an object that should be unique in the forest. You sometimes see duplicate objects that have changed names. These duplicate objects cause confusion on directory searches. For example, if the relative distinguished name of two objects cannot be resolved, conflict resolution appends **CNF:GUID** to the name. In this example, `*` represents a reserved character, **CNF** is a constant that indicates a conflict resolution, and **GUID** represents the objectGUID attribute value.

- E-mail messages are not delivered to a user whose Active Directory account appears to be current. After an outdated domain controller or global catalog server is reconnected, both instances of the user object appear in the global catalog. Because both objects have the same e-mail address, e-mail messages cannot be delivered.

- A universal group that no longer exists continues to appear in a user's access token. Although the group no longer exists, if a user account still has the group in its security token, the user may have access to a resource that you intended to be unavailable to that user.

- A new object or Exchange mailbox cannot be created. But you do not see the object in Active Directory. An error message reports that the object already exists.

- Searches that use attributes of an existing object may incorrectly find multiple copies of an object of the same name. One object has been deleted from the domain. But that object remains in an isolated global catalog server.  

If an attempt is made to update a lingering object that resides in a writable directory partition, events are logged on the destination domain controller. However, if the only version of a lingering object is in a read-only directory partition on a global catalog server, the object cannot be updated. Therefore, this kind of event is not triggered.

### Removing lingering objects from the forest

#### Windows 2000-based forests

For more information about how to remove lingering objects in a Windows 2000-based domain, click the following article number to view the article in the Microsoft Knowledge Base:

[314282](https://support.microsoft.com/help/314282) Lingering objects may remain after you bring an out-of-date global catalog server back online  

#### Windows Server 2003-based forests

For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[892777](https://support.microsoft.com/help/892777) Windows Server 2003 Service Pack 1 Support Tools  

### Preventing lingering objects

The following are methods that you can use to prevent lingering objects.

#### Method 1: Enable the Strict Replication Consistency registry entry

You can enable the Strict Replication Consistency registry entry so that suspect objects are quarantined. Then, administrations can remove these objects before they spread throughout the forest.

If a writable lingering object is located in your environment, and an attempt is made to update the object, the value in the Strict Replication Consistency registry entry determines whether replication proceeds or is stopped. The Strict Replication Consistency registry entry is located in the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`  
The data type for this entry is REG_DWORD. If you set the value to 1, the entry is enabled. Inbound replication of the specified directory partition from the source is stopped on the destination. If you set the value to 0, the entry is disabled. The destination requests the full object from the source domain controller. The lingering object is revived in the directory as a new object.

The default value for the Strict Replication Consistency registry entry is determined by the conditions under which the domain controller was installed in the forest.

>[!NOTE]
>Raising the functional level of the domain or the forest does not change the replication consistency setting on any domain controller.

By default, the value of the Strict Replication Consistency registry entry on domain controllers that are installed in a forest is 1 (enabled) if the following conditions are true:

- The Windows Server 2003 version of Winnt32.exe is used to upgrade a Windows NT 4.0 primary domain controller (PDC) to Windows Server 2003. This computer creates the forest root domain of a new forest.
- Active Directory is installed on a server that is running Windows Server 2003. This computer creates the forest root domain of a new forest.  

By default, the value of the Strict Replication Consistency registry entry on domain controllers is 0 (disabled) if the following conditions are true:

- A Windows 2000-based domain controller is upgraded to Windows Server 2003.
- Active Directory is installed on a Windows Server 2003-based member server in a Windows 2000-based forest.

If you have a domain controller that is running Windows Server 2003 with SP1, you do not have to modify the registry to set the value of the Strict Replication Consistency registry entry. Instead, you can use the Repadmin.exe tool to set this value for one domain controller in the forest or for all the domain controllers in the forest.

For more information about how to use Repadmin.exe to set Strict Replication Consistency, visit the following Microsoft Web site:  
[https://technet.microsoft.com/library/cc780362(WS.10).aspx](https://technet.microsoft.com/library/cc780362%28ws.10%29.aspx)  

#### Method 2: Monitor replication by using a command-line command

To monitor replication by using the `repadmin /showrepl` command, follow these steps:  

1. Click **Start**, click **Run**, type cmd, and then click **OK**.

2. Type `repadmin /showrepl * /csv >showrepl.csv`, and then press ENTER.
3. In Microsoft Excel, open the Showrepl.csv file.

4. Select the **A + RPC** column and the **SMTP** column.
5. On the **Edit** menu, click **Delete**.
6. Select the row that is immediately under the column headers.
7. On the **Windows** menu, click **Freeze Pane**.

8. Select the complete spreadsheet.
9. On the **Data** menu, point to **Filter**, and then click **Auto-Filter**.
10. On the heading of the **Last Success** column, click the down arrow, and then click **Sort Ascending**.
11. On the heading of the **src DC** column, click the down arrow, and then click **Custom**.
12. In the **Custom AutoFilter** dialog box, click **does not contain**.
13. In the box to the right of **does not contain**, type del.

    >[!NOTE]
    >This step prevents deleted domain controllers from appearing in the results.  

14. On the heading of the **Last Failure** column, click the down arrow, and then click **Custom**.
15. In the **Custom AutoFilter** dialog box, click **does not equal**.
16. In the box to the right of **does not equal**, type 0.
17. Resolve the replication failures that are displayed.

#### Method 3: Remove domain controllers

You can remove failing domain controllers from the forest before the TSL expires.

#### Method 4: Increase the TSL

Windows 2000 Server  

Increase the TSL to 180 days by using the Adsiedit tool. To do it, follow these steps:  

1. In the Adsiedit tool, expand **Configuration** **DomainControllerName**, expand **CN=Configuration**, **DC=ForestRootDomain**, expand **CN=Services**, expand **CN=Windows NT**, right-click **CN=Directory Service**, and then click **Properties**.
2. Click the **Attribute** tab.
3. In the **Select which properties to view** list, click **Optional**.
4. In the **Select a property to view** list, click **TombstoneLifetime**.
5. In the **Edit Attribute** box, type 180, click **Set**, and then click **OK**. Windows Server 2003  

Increase the TSL to 180 days by using the Adsiedit tool. To do it, follow these steps:  

1. In the Adsiedit tool, expand **Configuration** **DomainControllerName**, expand **CN=Configuration**, **DC=ForestRootDomain**, expand **CN=Services**, expand **CN=Windows NT**, right-click **CN=Directory Service**, and then click **Properties**.
2. Click the **Attribute Editor** tab.
3. In the **Attribute** list, click **TombstoneLifetime**, and then click **Edit**.
4. In the **Value** box, type 180, and then click **OK**.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
