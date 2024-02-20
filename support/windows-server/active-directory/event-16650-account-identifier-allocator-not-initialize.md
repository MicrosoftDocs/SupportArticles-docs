---
title: Account-identifier allocator fails to initialize
description: Describes Event 16650 and how to resolve Event 16650 RID Master errors on Windows Server-based computers.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# Event ID 16650: The account-identifier allocator failed to initialize in Windows Server

This article provides a solution to solve errors that occurs when you add objects to Active Directory or restore a domain controller from a system state backup.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 839879

## Symptoms

This article applies to Windows 2000 and all later versions.
When you try to add new users, groups, computers, mailboxes, domain controllers, or other objects to Active Directory on a Microsoft Windows Server computer, you may receive the following error message:  
> Cannot create the object because directory service was unable to allocate a relative identifier.  

When you restore a domain controller from a system state backup, the System log may contain the following error message:  
> Event Type:Error
>
> Event Source: SAM Event  
> Category:None
>
> Event ID: 16650
>
> The account-identifier allocator failed to initialize properly. The record data contains the NT error code that caused the failure. **Windows** will retry the initialization until it succeeds; until that time, account creation will be denied on this Domain Controller. Look for other SAM event logs that may indicate the exact reason for the failure.  

You can also use the `Dcdiag` command together with the verbose switch to look for additional errors. To do this, follow these steps:  

1. Click **Start**, click **Run**, type **cmd** in the **Open** box, and then click **OK**.
2. At the command prompt, type `DCdiag /v`, and then press **Enter.**  

When you type `Dcdiag /v`, you may see error messages that resemble the following:  
> Starting test: RidManager
>
> \* Available RID Pool for the Domain is 2355 to 1073741823
>
> \* **`dc01.contoso.com`** is the RID Master
>
> \* DsBind with RID Master was successful
>
> \* rIDAllocationPool is 1355 to 1854
>
> \* rIDNextRID: 0 The DS has corrupt data: rIDPreviousAllocationPool value is not valid
>
> \* rIDPreviousAllocationPool is 0 to 0 No rids allocated -- please check eventlog.  
> \......................... DC01 failed test RidManager
>
> Warning: rid set reference is deleted.
>
> ldap_search_sW of CN=RID SetDEL:cfe0828c-8842-4cb1-a642-6d9991d0516d,CN=Deleted Objects,DC= **contoso**,DC= **com** for rid info failed with 2: The system cannot find the file specified.
>
> \......................... DC01 failed test RidManager
>
> Starting test: RidManager
>
> \* Available RID Pool for the Domain is 3104 to 1073741823
>
> Warning: FSMO Role Owner is deleted.
>
> \* **`dc01.contoso.com`** is the RID Master
>
> \* DsBind with RID Master was successful
>
> Warning: rid set reference is deleted.
>
> ldap_search_sW of CN=RID SetDEL:5a128cf2-f365-47bc-a883-8ff9561ff545,CN=Deleted Objects,DC=contoso,DC=com for rid info failed with 2: The system cannot find the file specified.
......................... DC01 failed test RidManager  
>
> Starting test: KnowsOfRoleHolders
>
> Role Rid Owner = CN="NTDS Settings DEL:fd615439-1ebb-4652-b16f-3f8517d25593",CN=dc01,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=contoso,DC=com Warning: CN="NTDS Settings DEL:fd615439-1ebb-4652-b16f-3f8517d25593",CN=dc01,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=contoso,DC=com is the Rid Owner, but is deleted.  

You may also receive other errors in the system event log that can help you to troubleshoot the problem:  
> Event ID: 16647
>
> Event Source: SAM
>
> Description: The domain controller is starting a request for a new account-identifier pool.

> Event Type: Error
>
> Event Source: SAM Event
> Category:None
>
> Event ID: 16645
>
> Description: The maximum account identifier allocated to this domain controller has been assigned. The domain controller has failed to obtain a new identifier pool. A possible reason for this is that the domain controller has been unable to contact the master domain controller. Account creation on this controller will fail until a new pool has been allocated. There may be network or connectivity problems in the domain, or the master domain controller may be offline or missing from the domain. Verify that the master domain controller is running and connected to the domain.

## Cause

This problem occurs in one of the following scenarios:

- When the relative ID (RID) Master is restored from backup, it tries to synchronize with other domain controllers to verify that there are no other RID Masters online. However, the synchronization process fails if there are no domain controllers available to synchronize with, or if replication is not working.  

    > [!Note]
    > If the domain has always contained only one domain controller, the RID Master will not try to synchronize with other domain controllers. The domain controller has no knowledge of any other domain controllers.

- The RID pool has been exhausted, or objects in Active Directory that are related to RID allocation use incorrect values or are missing.

## Resolution

### Delete the replication links for the naming contexts in Windows

In Windows 2000 and later versions, you can restore a second domain controller to complete initial synchronization. If you cannot restore a second domain controller, you must either perform a metadata cleanup on the non-existent domain controllers or delete the replication links to the Active Directory naming contexts. If you plan to restore the other domain controllers later, you must delete the replication links instead of performing a metadata cleanup.

Before you can delete the replication links to the Active Directory naming contexts, you must identify the objectGUID value by using the `Repadmin` command. To do this, follow these steps:  

1. Click **Start**, click **Run**, type **cmd** in the **Open** box, and then click **OK**.
2. At the command prompt, type `repadmin /showreps`. You will see output that resembles the following:  

    > CN=Schema,CN=Configuration,DC=contoso,DC=comDefault-First-Site-Name\DC02 via RPC objectGuid: *\<GUID>* Last attempt @ *\<DateTime>* was successful.
    >
    > CN=Configuration,DC=contoso,DC=com Default-First-Site-Name\DC02 via RPC objectGuid: *\<GUID>* Last attempt @ *\<DateTime>* was successful.
    >
    > DC=contoso,DC=com Default-First-Site-Name\DC02 via RPC objectGuid: *\<GUID>* Last attempt @ *\<DateTime>* was successful.

3. Type `repadmin /delete` to delete the replication links. Specify the naming context and the objectGUID as shown in the following examples:  

    ```console
    repadmin /delete CN=Schema,CN=Configuration,DC=contoso,DC=com DC01 <GUID>._msdcs.contoso.com /localonly  
    repadmin /delete CN=Configuration,DC=contoso,DC=com DC01 <GUID>._msdcs.contoso.com /localonly  
    repadmin /delete DC=contoso,DC=com DC01 <GUID>._msdcs.contoso.com /localonly
    ```

4. Restart the RID Master computer. The RID Master will initialize correctly.

### Remove domain controller metadata for all other domain controllers in the domain

You can restore or connect a second domain controller to complete initial synchronization. If you cannot add a second domain controller, you must either perform a metadata cleanup on the non-existent domain controllers to remove them from the domain permanently or delete the replication links to the Active Directory naming contexts.
 For more information about how to remove metadata, click the following article number to view the article [Clean up Server Metadata.](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup)  

### Verify that Active Directory objects that are related to RID allocation are valid

To verify that the Active Directory objects that are related to RID allocation are valid, follow these steps:  

1. Verify that the Everyone group has the Access this computer from the network user right. The setting can be configured in the following location in the Group Policy Object Editor: `Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment`.

2. Install the Windows 2000 Support Tools. These tools are available in the support folder on the Windows 2000 and the Windows Server 2003 CD-ROMs. When you have installed these tools, start `ADSI Edit`. To do this, follow these steps:  

      1. Click **Start**, click **Run**, type mmc in the **Open** box, and then click **OK**.
      2. In Windows 2000, click **Console**, and then click **Add/Remove Snap-in**. In Windows Server 2003, click **File**, and then click **Add/Remove Snap-in**.
      3. In the **Add/Remove** snap-in, click **Add**, click **ADSIEdit**, and then click **Add**.
      4. Click **Close**, and then click **OK**.  

3. In MMC, right-click **ADSIEdit**, and then click **Connect to**.
4. In **Connections Settings**, under **Connection Point**, click **Select a well known naming context**. In the drop-down list, click **domain**, and then click **OK**.
5. Expand **domain**, and then expand the distinguished name of the domain. For example, expand **DC=**contoso**, DC=**com****.
6. Expand **OU=Domain Controllers**.
7. Right-click the domain controller that you want to check, and then click **Properties**.
8. Click the **Select a property to view** menu, and then click **userAccountControl**.
9. Verify that the value for **userAccountControl** is 532480. To change the **userAccountControl** value, click **Edit** on the domain controller property dialog box.
10. In the **Integer Attribute Editor**, type **532480** in the **Value** field, and then click **OK**.

### Verify that the RID Master is replicating with another domain controller

If a newly promoted domain controller generates Event 16650, the domain controller may have obtained replication information from another domain controller that is not the RID Master. During promotion, the computer account for the new domain controller is modified. If these changes have not replicated to the domain controller that holds the RID master role, the request will fail when the newly promoted domain controller tries to obtain a RID pool.

To verify that the RID Master is replicating with at least one of its direct partners, follow these steps:  

1. Verify that the **CN=RID Set** object exists.

    The **CN=RID Set** object is in the right pane of ADSI Edit when the domain controller is selected under **OU=Domain Controllers** in the left pane.

    If no **CN=RID Set** object exists, you must demote that domain controller and then promote it again to create the object.
2. If the **CN=RID Set** object exists, make sure that the **rIDSetReferences** attribute on the domain controller's computer account object points to the distinguished name of the **RID Set** object, as shown in the following example: **CN=RID Set, CN=DC01,OU=Domain Controllers,CN=contoso,DC=local**  

    If the **rIDSetReferences** attribute does not point to the distinguished name of the **RID Set** object, contact Microsoft Product Support Services for more information.

## Status

This behavior is by design.  

## References

[822053](https://support.microsoft.com/help/822053) Error message: "Windows cannot create the object because the Directory Service was unable to allocate a relative identifier"  
