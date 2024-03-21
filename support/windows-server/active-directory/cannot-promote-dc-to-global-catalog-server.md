---
title: Can't promote a DC to global catalog server
description: Describes a problem where you can't promote a Windows Server-based domain controller to be a global catalog server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# You cannot promote a Windows Server domain controller to be a global catalog server

This article provides solutions to an issue where you can't promote a Windows Server domain controller to be a global catalog server.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 889711

## Symptoms

You cannot promote a Microsoft Windows Server domain controller to be a global catalog server. After you try to assign the role of global catalog server to the Windows Server domain controller by clicking the **Global Catalog** check box, the domain controller is not promoted to be a global catalog server. Information events that are similar to the following may be logged repeatedly in the Directory Services log.

- Event 1559

- Event 1578

- Event 1801

If you enable diagnostic logging for the Knowledge Consistency Checker (KCC) to level 1, the following event is logged.

### Additional symptoms

When you type `repadmin /showrepl` at the command line of the Windows Server domain controller, one or more of the domains may not appear.

When you try to add a connection by using the naming context of the missing domain, you may receive the following error message:  
> Error number: 8440.
>
> The naming context specified for this replication operation is invalid.

## Cause

This problem occurs when the domain-naming update for the domain has not reached the domain controller that is experiencing the problem. Or, the domain-naming update for a domain that is newly promoted may not have reached any domain controllers outside that domain.

You can verify whether the domain-naming update has reached all the domain controllers by modifying the dumpDatabase attribute on the domain controller that is experiencing the problem. For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[315098](https://support.microsoft.com/help/315098) How to use the online dbdump feature in Ldp.exe  

In the dump file that you create, look for the cross-reference record for the domain. This cross-reference record has an object class 196619. Locate the record that the object class 196619 points to. Then, make sure that the object class that is contained in the record has an assigned GUID.

In the following example, object 5070 references object 5072. However, object 5072 is not assigned a GUID:

> 5070 4111 1 1459 true 3 DOMAIN DOMAIN 5072 196619 - 6f73dba6-33e1-41e5-9330-c09a60a37942 4  
 objectclass: 196619, 65536  
5071 2 2 - false *\<DateTime>* - 1376281 com com - - - - -  
5072 5071 5 - false *\<DateTime>* - 1376281 domain domain  

## Resolution

To resolve this problem, use one of the following methods.

### Method 1

If one or two domain controllers experience the problem, and other domain controllers in the same domain do not experience the problem, you must demote and then promote the domain controllers that are experiencing the problem. To do this, follow these steps:  

1. Log on to the Windows Server domain controller by using an account that has domain administrator permissions.
2. Click **Start**, click **Run**, type *dcpromo*, and then click **OK**.
3. Follow the instructions in the wizard to demote the domain controller.
4. After you demote the domain controller, restart the Windows Server computer.
5. Click **Start**, click **Run**, type *dcpromo*, and then click **OK**.
6. Follow the instructions in the wizard to promote the Windows Server domain controller.

### Method 2

You must rebuild the domain that is mentioned in the event descriptions if one of the following conditions is true:  

- No domain controllers in the domain received the update.
- The domain controllers that reside outside the domain that was reported in the event messages did not receive the update.

## More information

Event 1119 may be logged in the Directory Services log on the domain controller. This event may be logged after you assign the role of global catalog server to the domain controller, and after the account and the schema information is replicated to the new global catalog server.

The event description states that the computer is identified as a global catalog server. To confirm that the domain-naming master is a global catalog server, follow these steps:  

1. Click **Start**, click **Run**, type cmd, and then click **OK**.
2. Type `nltest /dsgetdc`: **domain_name** /server: **server_name**, and then press **ENTER**.

3. Verify that the **GC** flag is present on the server.  

For example, when you type the command, you receive a message that is similar to the following if the **GC** flag is present:  
> DC: \\\\Server_Name
>
> Address: \\\\IP Address
>
> Dom Guid: *\<GUID>*
>
> Dom Name: Domain_name
>
> Forest Name: Domain_name.com
>
> Dc Site Name: Default-First-Site-Name
>
> Our Site Name: Default-First-Site-Name
>
> Flags: PDC GC DS LDAP KDC TIMESERV WRITABLE DNS_FOREST CLOSE_SITE
>
> The command completed successfully
