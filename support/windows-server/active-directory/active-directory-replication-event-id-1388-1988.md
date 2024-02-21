---
title: Active Directory replication Event ID 1388 or 1988 - A lingering object is detected
description: Helps you troubleshoot Active Directory Replication Event ID 1388 and 1988.
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
# Active Directory replication Event ID 1388 or 1988: A lingering object is detected

This article helps you troubleshoot Active Directory replication Event ID 1388 and 1988.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4469619

## Summary

If a destination domain controller logs [Event ID 1388](#event-id-1388) or [Event ID 1988](#event-id-1988), a lingering object has been detected and one of two conditions exists on the destination domain controller:

- Event ID 1388: Inbound replication of the lingering object has occurred on the destination domain controller.
- Event ID 1988: Inbound replication of the directory partition of the lingering object has been blocked on the destination domain controller.

## Event ID 1388

This event indicates that a destination domain controller that does not have strict replication consistency enabled received a request to update an object that does not reside in the local copy of the Active Directory database. In response, the destination domain controller requested the full object from the source replication partner. In this way, a lingering object was replicated to the destination domain controller. Therefore, the lingering object was reintroduced into the directory.

> [!IMPORTANT]
> When Event ID 1388 occurs, if either the source domain controller (the replication partner that is outbound-replicating the lingering object) or the destination domain controller (the inbound replication partner that reports Event ID 1388) is running Windows 2000 Server, you cannot use the Repadmin tool to remove lingering objects. For information about how to remove lingering objects in this case, see [Lingering objects may remain after you bring an out-of-date global catalog server back online](lingering-objects-remain.md). The procedures and information in this article apply to the removal of lingering objects from global catalog servers as well as from domain controllers that are not global catalog servers.

The event text identifies the source domain controller and the outdated (lingering) object. The following is an example of the event text:

> Log Name: Directory Service  
Source: Microsoft-Windows-ActiveDirectory_DomainService  
Date: 5/3/2008 3:34:01 PM  
Event ID: 1388  
Task Category: Replication  
Level: Error  
Keywords: Classic  
User: ANONYMOUS LOGON  
Computer: `DC3.contoso.com`
Description: Another domain controller (DC) has attempted to replicate into this DC an object which is not present in the local Active Directory Domain Services database. The object may have been deleted and already garbage collected (a tombstone lifetime or more has past since the object was deleted) on this DC. The attribute set included in the update request is not sufficient to create the object. The object will be re-requested with a full attribute set and re-created on this DC.
>
> Source DC (Transport-specific network address):  
4a8717eb-8e58-456c-995a-c92e4add7e8e._msdcs.contoso.com  
Object:  
CN=InternalApps,CN=Users,DC=contoso,DC=com  
Object GUID: a21aa6d9-7e8a-4a8f-bebf-c3e38d0b733a  
Directory partition:  
DC=contoso,DC=com  
Destination highest property USN: 20510  
User Action:  
Verify the continued desire for the existence of this object. To discontinue re-creation of future similar objects, the following registry key should be created.
>
> Registry Key:  
`HKLM\System\CurrentControlSet\Services\NTDS\Parameters\Strict Replication Consistency`

## Event ID 1988

This event indicates that a destination domain controller that has strict replication consistency enabled has received a request to update an object that does not exist in its local copy of the Active Directory database. In response, the destination domain controller blocked replication of the directory partition containing that object from that source domain controller. The event text identifies the source domain controller and the outdated (lingering) object. The following is an example of the event text:

> Log Name: Directory Service  
Source: Microsoft-Windows-ActiveDirectory_DomainService  
Date: 2/7/2008 8:20:11 AM Event ID: 1988  
Task Category: Replication  
Level: Error  
Keywords: Classic  
User: ANONYMOUS LOGON  
Computer: `DC5.contoso.com`  
Description:  
Active Directory Domain Services Replication encountered the existence of objects in the following partition that have been deleted from the local domain controllers (DCs) Active Directory Domain Services database. Not all direct or transitive replication partners replicated in the deletion before the tombstone lifetime number of days passed. Objects that have been deleted and garbage collected from an Active Directory Domain Services partition but still exist in the writable partitions of other DCs in the same domain, or read-only partitions of global catalog servers in other domains in the forest are known as "lingering objects".
>
> This event is being logged because the source DC contains a lingering object which does not exist on the local DCs Active Directory Domain Services database. This replication attempt has been blocked.
>
> The best solution to this problem is to identify and remove all lingering objects in the forest.
>
> Source DC (Transport-specific network address):  
4a8717eb-8e58-456c-995a-c92e4add7e8e._msdcs.contoso.com  
Object: CN=InternalApps,CN=Users,DC=contoso,DC=com  
Object GUID:  
a21aa6d9-7e8a-4a8f-bebf-c3e38d0b733a

## Diagnosis

An object that has been permanently deleted from AD DS (that is, its tombstone has been garbage-collected on all connected domain controllers) remains on a disconnected domain controller. The domain controller failed to receive direct or transitive replication of the object deletion because it was disconnected (it is offline or experiencing an inbound replication failure) from the replication topology for a period that exceeded a tombstone lifetime. The domain controller is now reconnected to the topology and that object has been updated on the domain controller, causing a replication notification to the replication partner that an update is ready for replication. The replication partner responded according to its replication consistency setting. This notification applies to attempted replication of a writable object. A copy of the writable lingering object might also exist on a global catalog server.

## Resolution

If replication of a lingering object is detected, you can remove the object from AD DS, along with any read-only replicas of the object, by identifying the domain controllers that might store this object (including global catalog servers) and running a repadmin command to remove lingering objects on these servers (`repadmin /removelingeringobjects`). This command is available on domain controllers that are running Windows Server 2008. It is also available on domain controllers that are not running Windows Server 2008 but are running the version of Repadmin.exe that is included with Windows Support Tools in Windows Server 2003.

To remove lingering objects, do the following:

1. Use the event text to identify the following:
    1. The directory partition of the object
    2. The source domain controller that attempted replication of the lingering object
2. [Use Repadmin to identify the GUID of an authoritative domain controller](#use-repadmin-to-identify-the-guid-of-an-authoritative-domain-controller).
3. [Use Repadmin to remove lingering objects](#use-repadmin-to-remove-lingering-objects).
4. [Enable strict replication consistency](#enable-strict-replication-consistency), if necessary.
5. [Ensure that strict replication consistency is enabled for newly promoted domain controllers](#ensure-that-strict-replication-consistency-is-enabled-for-newly-promoted-domain-controllers), if necessary.

### Use Repadmin to identify the GUID of an authoritative domain controller

To perform the procedure that removes lingering objects, you must identify the globally unique identifier (GUID) of an up-to-date domain controller that has a writable replica of the directory partition that contains the lingering object that has been reported. The directory partition is identified in the event message.
The object GUID of a domain controller is stored in the **objectGUID** attribute of the NTDS Settings object.

Requirements:

- Membership in **Domain Admins** in the domain of the domain controller whose GUID you want to identify is the minimum required to complete this procedure. Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](/previous-versions/orphan-topics/ws.10/dd728026(v=ws.10)).
- Tool: Repadmin.exe

#### Steps to identify the GUID of a domain controller

1. At a command prompt, type the following command, and then press ENTER:

    ```console
    repadmin /showrepl <ServerName>
    ```

    |Parameter|Description|
    |---|---|
    |`/showrepl`|Displays the replication status, including when the domain controller that is specified by \<ServerName> last attempted inbound replication of Active Directory partitions. Also displays the GUID of the specified domain controller.|
    |\<ServerName>|The name of the domain controller whose GUID you want to display.|

2. In the first section of the output, locate the **objectGuid** entry. Select and copy the GUID value into a text file so that you can use it elsewhere.

### Use Repadmin to remove lingering objects

If the destination domain controller and source domain controller are running either Windows Server 2003 or Windows Server 2008, you can use this procedure to remove lingering objects with Repadmin. If either domain controller is running Windows 2000 Server, follow the instructions in [Lingering objects may remain after you bring an out-of-date global catalog server back online](lingering-objects-remain.md).

Requirements:

- Membership in **Domain Admins** in the domain of the domain controller that has lingering objects, or **Enterprise Admins** if the directory partition that has lingering objects is the configuration or schema directory partition, is the minimum required to complete this procedure. Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](/previous-versions/orphan-topics/ws.10/dd728026(v=ws.10)).
- Operating system: Windows Server 2003 or Windows Server 2008 for \<ServerName> and \<ServerGUID>
- Tool: Repadmin.exe

#### Steps to use Repadmin to remove lingering objects

1. Open a Command Prompt as an administrator: On the **Start** menu, right-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins or Enterprise Admins credentials, if required, and then click **Continue**.

2. At the command prompt, type the following command, and then press ENTER:

    ```console
    repadmin /removelingeringobjects <ServerName> <ServerGUID> <DirectoryPartition> /advisory_mode
    ```

    |Parameter|Description|
    |---|---|
    |`/removelingeringobjects`|Removes lingering objects from the domain controller that is specified by \<ServerName> for the directory partition that is specified by \<DirectoryPartition>.|
    |\<ServerName>|The name of the domain controller that has lingering objects, as identified in the event message (Event ID 1388 or Event ID 1988). You can use the Domain Name System (DNS) name or the distinguished name, for example, the distinguished name CN=DC5,OU=Domain Controllers,DC=contoso,DC=com or the DNS name `DC5.contoso.com`.|
    |\<ServerGUID>|The GUID of a domain controller that has an up-to-date, writable replica of the directory partition that contains the lingering object.|
    |\<DirectoryPartition>|The distinguished name of the directory partition that is identified in the event message, for example:<ul><li>For the Sales domain directory partition in the `contoso.com` forest: DC=sales,DC=contoso,DC=com</li> <li>For the configuration directory partition in the `contoso.com` forest: CN=configuration,DC=contoso,DC=com</li> <li> For the schema directory partition in the `contoso.com` forest: CN=schema,CN=configuration,DC=contoso,DC=com</li> </ul>|
    |`/advisory_mode`|Logs the lingering objects that will be removed so that you can review them, but does not remove them.|

3. Repeat step 2 without `/advisory_mode` to delete the identified lingering objects from the directory partition.

4. Repeat steps 2 and 3 for every domain controller that might have lingering objects.

> [!NOTE]
> The \<ServerName> parameter uses the DC_LIST syntax for repadmin, which allows the use of * for all domain controllers in the forest and gc: for all global catalog servers in the forest. To see the DC_LIST syntax, type `repadmin /listhelp`. For information about the syntax of the `/regkey` and `/removelingeringobjects` parameters, type `repadmin /experthelp`.

### Enable strict replication consistency

To ensure that lingering objects cannot be replicated if they occur, enable strict replication consistency on all domain controllers. The setting for replication consistency is stored in the registry on each domain controller. However, on domain controllers that are running Windows Server 2003 with Service Pack 1 (SP1), Windows Server 2003 with Service Pack 2 (SP2), Windows Server 2003 R2, or Windows Server 2008, you can use Repadmin to enable strict replication consistency on one or all domain controllers.

On domain controllers running Windows Server 2003 without SP1 or running any version of Windows 2000 Server, you must edit the registry to enable the setting.

#### Use Repadmin to enable strict replication consistency

Use this procedure to remove lingering objects on a domain controller that is running Windows Server 2003 with SP1, Windows Server 2003 with SP2, Windows Server 2003 R2, or Windows Server 2008.

Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure on a single domain controller. Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure on all domain controllers in the forest. Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](/previous-versions/orphan-topics/ws.10/dd728026(v=ws.10)).

##### Steps to use Repadmin to enable strict replication consistency  

1. Open a Command Prompt as an administrator: On the **Start** menu, right-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins or Enterprise Admins credentials, if required, and then click **Continue**.

2. At the command prompt, type the following command, and then press ENTER:

    ```console
    repadmin /regkey <DC_LIST> +strict
    ```

    |Parameter|Description|
    |---|---|
    |`/regkey`|Enables (+) and disables (-) the value for the **Strict Replication Consistency** registry entry in `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`.|
    |\<DC_LIST>|The name of a single domain controller, or * to apply the change to all domain controllers in the forest. For the domain controller name, you can use the DNS name, the distinguished name of the domain controller computer object, or the distinguished name of the domain controller server object, for example, the distinguished name CN=DC5,OU=Domain Controllers,DC=contoso,DC=com or the DNS name `DC5.contoso.com`.|
    |`+strict`|Enables the **Strict Replication Consistency** registry entry.|

3. If you do not use * to apply the change to all domain controllers, repeat step 2 for every domain controller on which you want to enable strict replication consistency.

> [!NOTE]
> For more naming options and information about the syntax of the <DC_LIST> parameter, at the command prompt type `repadmin /listhelp`. For information about the syntax of the `/regkey` and `/removelingeringobjects` parameters, type `repadmin /experthelp`.

#### Use Regedit to enable strict replication consistency  

As an alternative to using Repadmin, you can enable strict replication consistency by editing the registry directly. The registry method is required for a domain controller that is running a version of Windows Server that is earlier than Windows Server 2003 with SP1. The setting for replication consistency is stored in the **Strict Replication Consistency** entry in `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`.

The values for the **Strict Replication Consistency** registry entry are as follows:

- Value: 1 (0 to disable)
- Default: 1 (enabled) in a new Windows Server 2003 or Windows Server 2008 forest; otherwise 0.
- Data type: REG_DWORD

Requirements:

- Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](/previous-versions/orphan-topics/ws.10/dd728026(v=ws.10))).
- Tool: Regedit.exe

> [!NOTE]
> It is recommended that you do not directly edit the registry unless there is no other alternative. Modifications to the registry are not validated by the registry editor or by Windows before they are applied, and as a result, incorrect values can be stored. This can result in unrecoverable errors in the system. When possible, use Group Policy or other Windows tools, such as Microsoft Management Console (MMC), to accomplish tasks rather than editing the registry directly. If you must edit the registry, use extreme caution.

##### Steps to use Regedit to enable strict replication consistency

1. Open Regedit as an administrator: Click **Start** and then, in **Start Search**, type _regedit_. At the top of the **Start** menu, right-click **regedit.exe**, and then click **Run as administrator**. In the **User Account Control** dialog box, provide Domain Admins credentials, and then click **OK**.

2. Navigate to the **Strict Replication Consistency** entry in `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`.
3. Set the value in the **Strict Replication Consistency** entry to 1.

### Ensure that strict replication consistency is enabled for newly promoted domain controllers

If you are upgrading a forest that was originally created using a computer running Windows 2000 Server, you should ensure that the forest is configured to enable strict replication consistency on newly promoted domain controllers to help avoid lingering objects. After you update the forest as described in ([Upgrading Active Directory Domains to Windows Server 2008 and Windows Server 2008 R2 AD DS Domains](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731188(v=ws.10))), all new domain controllers that you subsequently add to the forest are created with strict replication consistency disabled. However, you can implement a forest configuration change that causes new domain controllers to have strict replication consistency enabled. To ensure that new domain controllers that you add to the forest have strict replication consistency enabled, you can use the Ldifde.exe tool to create an object in the configuration directory partition of the forest. This object is responsible for enabling strict replication consistency on any Windows Server 2003 or Windows Server 2008 domain controller that is promoted into the forest.

The object that you create is an operational GUID with the following name:

CN=94fdebc6-8eeb-4640-80de-ec52b9ca17fa,CN=Operations,CN=ForestUpdates,CN=Configuration,DC=\<ForestRootDomain>

You can use the following procedure on any domain controller in the forest to add this object to the configuration directory partition.

Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](/previous-versions/orphan-topics/ws.10/dd728026(v=ws.10)).

#### Steps to create the object that ensures strict replication consistency on new domain controllers

1. In a text editor, such as Notepad, create the following text file:

    > dn:  
    CN=94fdebc6-8eeb-4640-80de-ec52b9ca17fa,CN=Operations,CN=ForestUpdates,CN=Configuration,DC=\<ForestRootDomain>  
    changetype: add  
    objectClass: container  
    showInAdvancedViewOnly: TRUE  
    name: 94fdebc6-8eeb-4640-80de-ec52b9ca17fa  
    objectCategory: CN=Container,CN=Schema,CN=Configuration,DC=\<ForestRootDomain>

2. Where \<ForestRootDomain> contains all domain components (DC=) of the forest root domain, for example, for the `contoso.com` forest, DC=contoso,DC=com; for the `fineartschool.net` forest, DC=fineartschool,DC=net.

3. Open a Command Prompt as an administrator: On the **Start** menu, right-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Enterprise Admins credentials, if required, and then click **Continue**.

4. At the command prompt, type the following command, and then press ENTER:

    ```console
    ldifde -i -f <Path>\<FileName>
    ```

    |Parameter|Description|
    |---|---|
    |`-i`|Specifies the import mode. If the import mode is not specified, the default mode is export.|
    |`-f`|Identifies the import or export file name.|
    |\<Path>\\\<FileName>|The path and name of the import file that you created in step 1, for example, C:\\ldifde.txt.|

    For information about using Ldifde, see [LDIFDE](/previous-versions/orphan-topics/ws.10/cc755456(v=ws.10)).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
