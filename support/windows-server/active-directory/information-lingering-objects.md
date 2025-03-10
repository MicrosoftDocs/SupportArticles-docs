---
title: Lingering objects in an AD DS forest
description: Provides information about lingering objects in a forest, including events that indicate lingering objects, causes of lingering objects, and methods to remove lingering objects.
ms.date: 03/10/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-tappelgate, ziggyn
ms.custom:
- sap:active directory\active directory replication and topology
- pcy:WinComm Directory Services
---
# How to detect and remove lingering objects in a Windows Server Active Directory forest

This article provides information about lingering objects in an Active Directory Domain Services (AD DS) forest. Specifically, the article discusses the events that indicate the presence of lingering objects, the causes of lingering objects, and the methods that you can use to remove lingering objects.  

_Original KB number:_ &nbsp; 910205

## Summary

Lingering objects are objects that reappear in the AD DS forest after they're deleted. This behavior might occur if a domain controller stops replicating changes to or from other domain controllers in the forest for a time, and then starts replicating again. This behavior occurs because of the manner in which the forest replicates object deletions among multiple domain controllers.

## How object deletions replicate through a forest

When you delete an object in an AD DS forest, AD DS generates a tombstone object to represent the deleted object. The tombstone object contains a small subset of the attributes of the deleted object. Other domain controllers in the domain and the forest use inbound replication to receive the tombstone object and update their forest information to account for the deletion. The tombstone object remains in the forest for a specified period that's known as the tombstone lifetime (TSL). At the end of the TSL, AD DS permanently deletes the tombstone object. All direct and transitive replication partners of the originating domain controller must receive a copy of the tombstone object within the TSL.

The default value of the TSL depends on the version of the operating system that's running on the first domain controller that's installed in a forest. For all currently supported versions of Windows Server, the default TSL is 180 days.

> [!NOTE]  
> The existing TSL value does not change when you upgrade a domain controller to a newer version of Windows Server. The existing TSL value persists until you manually change it.

## How lingering objects occur

Lingering objects can occur if a domain controller stops replicating changes to or from the remaining replication topology for a time, and then starts replicating again (for example, if the server has to be physically disconnected and moved, and then reconnected). When a domain controller doesn't replicate for a period that is longer than the TSL, the domain controller might not receive one or more tombstone objects. Therefore, one or more objects that are deleted from the forest on all other domain controllers might persist on the disconnected domain controller. Such objects are called lingering objects.

When the disconnected domain controller starts replicating again, it acts as a source replication partner that has an object that its destination partner doesn't have. The destination domain controller responds by taking either of the following actions:

- If the `Strict Replication Consistency` registry key is enabled on the destination domain controller, that domain controller recognizes that it can't update the object. The destination domain controller locally stops inbound replication of the directory partition from the source domain controller.

- If the `Strict Replication Consistency` registry key is disabled on the destination domain controller, that domain controller requests the full replica of the object. This operation reintroduces the object into the forest. From an administrative point of view, an object that you deleted reappears.

Lingering objects don't always cause noticeable symptoms. Under the following conditions, lingering objects might remain undetected:  

- An administrator, an application, or a service doesn't update the lingering object.
- An administrator, an application, or a service doesn't try to create an object that has the same name in the domain.
- An administrator, an application, or a service doesn't try to create an object by using the same user principal name (UPN) in the forest.

### Causes of long disconnections

The simplest way to avoid lingering objects is to prevent domain controllers from disconnecting from the replication topology for periods greater than the TSL. If a domain controller has to be disconnected for an extended period, be aware of the potential for lingering objects.

The following conditions can cause long disconnections:

- An administrator removes a domain controller from the network and then puts it into storage.

- An administrator pre-stages a domain controller and then sends it to a remote location. However, the TSL expires before the domain controller reaches the remote location.

- The domain controller can't connect to a wide-area network (WAN) for long periods. For example, a domain controller on board a cruise ship might be unable to replicate for longer than the TSL if the ship is at sea.

Under the following conditions, lingering objects can appear even if the domain controller was offline for less than the default TSL:

- An administrator shortens the TSL to force the garbage collection of deleted objects.

- The system clock on the source or destination domain controller is incorrectly advanced or rolled back. Clock skews are most common after a domain controller restarts, and can occur for the following reasons:  

  - The system clock battery or the motherboard has a problem.

  - The time source for a computer is configured incorrectly. Such a source could include a time source server that's configured by using Windows Time service (W32Time), by using a third-party time server, or by using network routers.

  - An administrator advances or rolls back the system clock to extend the useful life of a system state backup or to accelerate the garbage collection of deleted objects. Make sure that the system clock reflects the actual time. Also, make sure that event logs don't contain invalid events from the future or the past.

## Indications that a forest has lingering objects

Even when there's no noticeable effect, the presence of lingering objects can cause problems. These problems are most likely to occur if a lingering object is a security principal.

### Events that indicate that the forest might have lingering objects

| Event ID | General description |
| --- | --- |
| 1862 or 1863 | The local domain controller has not recently received replication information from several domain controllers (inter-site). |
| 1864 | The local domain controller has not recently received replication information from several domain controllers (summary). |
| 1311 | The Knowledge Consistency Checker (KCC) was not able to build a spanning tree topology. |
| 2042 | It has been too long since this server last replicated with the named source server. |

### Events that indicate that the forest has lingering objects

| Event ID | General description |
| --- | --- |
| 1084 | There is no such object on the server. |
| 1388 | This destination system received an update for an object that should have been present locally but was not. |
| 1311 | Another domain controller replicated an object not present on this domain controller. |

> [!NOTE]
>
> - Lingering objects don't exist on domain controllers that log event ID 1988. The source domain controller contains the lingering object.
> - When updates to a lingering object replicate from one domain controller to another, the event-logging behavior of the domain controller depends on whether the directory partition that contains the lingering object is writeable. If the lingering object on the destination domain controller resides in a writeable partition, the domain controller logs an event. If the lingering object resides in a read-only partition, the object can't be updated, and the domain controller doesn't log an event.

### Repadmin errors that indicate that the forest has lingering objects

| Event ID | General description |
| --- | --- |
| 8240 | There is no such object on the server. |
| 8606 | Insufficient attributes were given to create an object. |

### Other indications that the forest has lingering objects

- The Microsoft Exchange Server global address list (GAL) contains a user or group account that was deleted. In this case, the account name appears in the GAL, but errors occur when users try to send e-mail messages.

- An object should be unique in the forest, but you see multiple copies of the object in the object picker or the GAL. Such cases might include duplicate objects that have changed names. These duplicate objects confuse directory searches. For example, if a search can't resolve the relative distinguished names of two objects, the conflict resolution function appends `*CNF:<GUID>` to one of the names. In this example, `*` represents a reserved character, `CNF` is a constant that indicates a conflict resolution, and `<GUID>` represents the **objectGUID** attribute value.

- A user has a current account, but the account was renamed. The user doesn't receive email messages. Both instances of the user object (the current one and an older version) appear in the GAL. Because both objects have the same email address, email messages can't be delivered.

- A universal group that no longer exists continues to appear in a user's access token. Therefore, the user might have access to a resource that you intended to be unavailable to that user.

- You can't create a new object or Exchange mailbox. However, you don't see the object in the forest. An error message reports that the object already exists.

- Searches that use attributes of an existing object might incorrectly find multiple copies of an object that use the same name. One object has been deleted from the domain, but that object remains in a global catalog server that was isolated.  

## Remove lingering objects from the forest

Select one of the following methods to remove lingering objects.

### Method 1: Use LOLv2

The preferred method to detect and remove lingering objects is by using Lingering Object Liquidator v2 (LoLv2). To download the tool, see [Lingering Object Liquidator (LoL)](https://www.microsoft.com/download/details.aspx?id=56051)

For more information about how to use LoLv2, see the following articles:

- [Introducing Lingering Object Liquidator v2](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/introducing-lingering-object-liquidator-v2/ba-p/400475)
- [Description of the Lingering Object Liquidator tool](lingering-object-liquidator-tool.md)

### Method 2: Use the Repadmin tool

If you can't use LoLv2, you can use the Repadmin tool (*Repadmin.exe*). For more information, see [Steps to use Repadmin to remove lingering objects](active-directory-replication-event-id-1388-1988.md).

## Prevent lingering objects

To prevent lingering objects in your forest, use one of the following methods.

### Method 1: Enable the Strict Replication Consistency registry entry

[!INCLUDE [Registry caution](../../includes/registry-important-alert.md)]

You can enable the `Strict Replication Consistency` registry entry on each domain controller so that suspect objects are quarantined on the source domain controller. Then, administrators can remove these objects before the objects spread throughout the forest.

If a writable lingering object is located in your environment, and an attempt is made to update the object, the value in the `Strict Replication Consistency` registry entry determines whether replication proceeds or stops. The `Strict Replication Consistency` registry entry is located in the following registry subkey:  

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`  

- Name: `Strict Replication Consistency`
- Data type: REG_DWORD
- Values:
  - **0** (disabled). The destination domain controller requests the full object from the source domain controller. The lingering object reappears in the forest as a new object.
  - **1** (enabled). The destination domain controller stops inbound replication of the relevant directory partition from the source domain controller.

The default value for `Strict Replication Consistency` depends on the Windows version of the first domain controller in the forest. This computer creates the forest root domain of a new forest.  

- If the forest was created by promoting a server that's running Windows Server 2003 or a later version, the default value of `Strict Replication Consistency` is **1** (enabled) on any domain controller that you add to the forest.

- If the forest was created by promoting a server that's running Windows 2000 Server, the default value of `Strict Replication Consistency` is **0** (disabled) on any domain controller that you add to the forest. In this case, follow the steps in [Ensure Strict Replication Consistency Is Enabled On Newly Promoted Domain Controllers](/previous-versions/orphan-topics/ws.10/cc780362(v=ws.10)).

> [!NOTE]  
> The `Strict Replication Consistency` value on a domain controller does not change if you raise the functional level of the domain or the forest.

The preferred method to enable `Strict Replication Consistency` is by using Repadmin. For more information about how to do this, see the following articles:

- [Steps to use Repadmin to enable strict replication consistency](active-directory-replication-event-id-1388-1988.md)

- [Event ID 1388 or 1988: A lingering object is detected](/previous-versions/orphan-topics/ws.10/cc780362(v=ws.10)).

### <a name="method-2-monitor-replication-by-using-a-command-line-command" ></a>Method 2: Check replication by using a command-line command

To check replication by using the `repadmin /showrepl` command, follow these steps:  

1. Open a Command Prompt window (select **Start** > **Run**, type *cmd*, and then select **OK**).

1. At the command prompt, run the following command:

   ```console
   repadmin /showrepl * /csv >showrepl.csv
   ```

1. In Microsoft Excel, open the *Showrepl.csv* file.

1. Select the **A + RPC** column and the **SMTP** column, and then select **Edit** > **Delete**.
1. Select the row that is immediately under the column headers, and then select **Windows** > **Freeze Pane**.
1. Select the entire spreadsheet, and then select **Data** > **Filter** > **Auto-Filter**.
1. In the heading of the **Last Success** column, select the down arrow, and then select **Sort Ascending**.
1. In the heading of the **src DC** column, select the down arrow, and then select **Custom**.
1. In the **Custom AutoFilter** dialog box, select **does not contain**.
1. In the box to the right of **does not contain**, type *del*.

   > [!NOTE]  
   > This step prevents deleted domain controllers from appearing in the results.  

1. In the heading of the **Last Failure** column, select the down arrow, and then select **Custom**.
1. In the **Custom AutoFilter** dialog box, select **does not equal**.
1. In the box to the right of **does not equal**, type *0*.
1. Check the filtered spreadsheet for replication failures. These are the issues that you have to resolve.

### Method 3: Remove domain controllers

If you have to remove and replace a domain controller, or if you suspect that a domain controller is failing, make sure that the period in which that the domain controller is offline is less than the TSL.

### Method 4: Increase the TSL

You can use either Windows PowerShell or ADSI Edit to increase the TSL to 180 days.

To use PowerShell to increase the TSL, open an administrative PowerShell window, and then run the following commands in sequence:  

```powershell
$ADForestconfigurationNamingContext = (Get-ADRootDSE).configurationNamingContext

Set-ADObject -Identity "CN=Directory Service,CN=Windows NT,CN=Services,$ADForestconfigurationNamingContext" -Partition $ADForestconfigurationNamingContext -Replace @{tombstonelifetime='180'}
```

ADSI Edit is available on the **Tools** menu in Server Manager. To change the TSL, follow these steps:  

1. In ADSI Edit, connect to the Configuration partition of the forest. To do this, follow these steps:
   1. In the left pane, right-click **ADSI Edit**, and then select **Connect**.
   1. In **Connection Settings**, select **Select a well-known Naming Context**, and then select **Configuration**.
   1. Select **OK**.
1. In the navigation tree, go to **CN=Configuration** > **CN=Services** > **CN=Windows NT** > **CN=Directory Service**.
1. Right-click **CN=Directory Service**, and then select **Properties**.
1. Select the **Attribute** tab.
1. In the **Select which properties to view** list, select **Optional**.
1. In the **Select a property to view** list, select **TombstoneLifetime**.
1. In the **Edit Attribute** box, type *180*, select **Set**, and then select **OK**.

## Collecting data for Microsoft Support

If you need assistance from Microsoft Support, we recommend that you collect the information by following the steps that are mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
