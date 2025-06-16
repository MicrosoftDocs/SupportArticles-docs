---
title: Can't promote a domain controller to a global catalog server
description: Describes a problem where you can't promote a Windows Server-based domain controller to be a global catalog server.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-tappelgate, v-lianna, sagiv
ms.custom:
- sap:active directory\active directory replication and topology
- pcy:WinComm Directory Services
---
# Can't promote a Windows Server domain controller to a global catalog server

This article provides solutions to an issue where you can't promote a Windows Server domain controller to a global catalog server.

_Original KB number:_ &nbsp; 889711, 910204

**Applies to: All supported versions of Windows Server**

## Event messages logged in the Directory Services log of Windows Server

You can't promote a Windows Server domain controller to a global catalog server. After you try to assign the global catalog server role to the Windows Server domain controller by selecting the **Global Catalog** checkbox, the domain controller isn't promoted to a global catalog server. If you enable diagnostic logging for the Knowledge Consistency Checker (KCC) at level 1, information events that are similar to the following may be logged repeatedly in the Directory Services log.

- Event 1559
- Event 1578
- Event 1801

> [!Note]
> To run a domain controller diagnostic check, follow the steps:
> 
> 1. Select **Start** > **Run**, type *cmd*, and then select **OK**.
> 2. At the command prompt, type `dcdiag /v /f: logfile.txt`, and then press <kbd>Enter</kbd>.

Additionally, the output may show that the domain controller doesn't pass the advertising test and isn't advertising the global catalog. This output occurs when a domain controller logs event ID 1578 and you run a domain controller diagnostic check (*Dcdiag.exe*) on that domain controller.


### Other symptoms

When you type `repadmin /showrepl` at the command line of the Windows Server domain controller, one or more of the domains may not appear.

When you try to add a connection by using the naming context of the missing domain, you may receive the following error message:

> Error number: 8440.
>
> The naming context specified for this replication operation is invalid.

## Possible causes of the global catalog promotion failure

A global catalog must replicate inbound copies of all objects from all domain partitions in the forest before the global catalog can advertise the global catalog role.

When a domain controller is selected to host the global catalog, the KCC on the domain controller that's being promoted uses its discretion to build connection objects from source domain controllers that host the required partitions. These source domain controllers may consist of existing global catalogs in the forest or host writable copies of every domain partition that resides in its forest. The contents of each domain partition are then inbound replicated from source domain controllers that are designated by the KCC. The contents are replicated to the newly promoted global catalog over existing or newly created connection links.

Global catalog promotion may fail if one of the following conditions is true:

- The configuration partition on one or more domain controllers contains a cross-reference object to a stale or orphaned domain, but no domain controllers for that domain are located in the forest.
- The metadata for a source domain controller that's designated by the KCC is located in the configuration partition of one or more domain controllers but doesn't represent a domain controller currently present in the forest.
- The source domain controller selected by the KCC on the global catalog that's being promoted is offline.
- The source domain controller selected by the KCC on the global catalog that's being promoted is inaccessible over the network. This domain controller is inaccessible because there's no network connectivity or partial network connectivity. Here are examples of network connectivity issues:
   -	Ports are blocked.
   - IP addresses are filtered.
   - Networks aren't fully routed, but the **Bridge all site links** option is enabled.
- Source domain global catalogs are constrained from acting as bridgeheads because administrators have incorrectly selected non-global catalog domain controllers as preferred bridgeheads.
- The global catalog that's being promoted can't build a connection link from the selected source domain controller because of the error status that's logged in one of the [preceding events](#event-messages-logged-in-the-directory-services-log-of-windows-server).

An orphaned domain prevents the domain controller from finishing the replication. The domain controller can't advertise itself as a global catalog server until the replication is completed. Several issues can lead to an orphaned domain:

- Active Directory is removed from all the domain controllers of a domain, but the domain partition cross-reference object still remains.
- Active Directory is removed from a domain controller, and the directory partition of the domain controller is removed. The domain controller is then re-created before the replication is completed. These events cause lingering phantoms that a cross-reference object incorrectly references.
- The domain-naming update for the domain hasn't reached the problematic domain controller. Or, the domain-naming update for a newly promoted domain may not have reached any domain controllers outside that domain. This issue would be a temporary problem.

You can verify whether the domain-naming update has reached all the domain controllers by modifying the **dumpDatabase** attribute on the domain controller that is experiencing the problem. For more information, see [How to use the online dbdump feature in Ldp.exe](use-online-dbdump-feature-ldp-dot-exe.md).

In the dump file that you created, look for the cross-reference record for the domain. This cross-reference record has an object class **196619**. Locate the record that the object class **196619** points to. Then, make sure that the object class that's contained in the record has an assigned GUID.

In the following example, object 5070 references object 5072. However, object 5072 isn't assigned a GUID:

```ldp
5070 4111 1 1459 true 3 <DOMAIN> <DOMAIN> 5072 196619 - 6f73dba6-33e1-41e5-9330-c09a60a37942 4  
 objectclass: 196619, 65536  
5071 2 2 - false <DateTime> - 1376281 com com - - - - -  
5072 5071 5 - false <DateTime> - 1376281 <domain> <domain>  
```

## Determine the cause of the global catalog promotion failure

To resolve this problem, first identify the root cause of the replication issue. Determine whether the replication issue is caused by one of the following conditions:

- A replication delay
- An orphaned domain that's located in the forest environment
- An inability to build the connection link
- An inability to replicate over the connection agreement

## Methods to resolve the global catalog promotion failure

Use one of the following methods to resolve the global catalog promotion failure.

### Method 1

If one or two domain controllers experience the problem, and other domain controllers in the same domain don't experience the problem, you must demote and then promote the domain controllers that are experiencing the problem. To do this, follow these steps:  

1. Sign in to the Windows Server domain controller by using an account that has domain administrator permissions, and then demote the domain controller by using the steps in [Demoting Domain Controllers](/windows-server/identity/ad-ds/deploy/demoting-domain-controllers-and-domains--level-200-).
2. After you demote the domain controller, restart the Windows Server computer. After the computer restarts, install the Active Directory Domain Services role and promote the new domain controller by using the steps in the following articles:

   - [Install Active Directory Domain Services Role](/windows-server/identity/ad-ds/deploy/install-active-directory-domain-services--level-100-)
   - [Install a Replica Windows Server 2012 Domain Controller in an Existing Domain](/windows-server/identity/ad-ds/deploy/install-a-replica-windows-server-2012-domain-controller-in-an-existing-domain--level-200-)

### Method 2

If one of the following conditions is true, rebuild the affected domain:  

- No domain controllers in the domain received the update.
- The domain controllers that reside outside the domain that was reported in the event messages didn't receive the update.

### Method 3

If NT Directory Services (NTDS) KCC event ID 1265 is logged in the Directory Services log, use that event to determine the cause of the replication failure for the same domain partition. Make sure that the network connectivity is good and that no required network ports are blocked. Required network ports are, for example, TCP 135 and ephemeral ports that are used by Remote Procedure Calls (RPCs). View the Domain Name System (DNS) records to make sure that the registered host and service location (SRV) records are all correctly registered. If there are incorrect records, clear them and register such records.

Remove all stale metadata for any domain controllers and domains in the forest that are listed in the relevant event IDs. This is to make sure that the replication doesn't fail because of a non-existent domain controller or domain. 

For more information, see:  
[Clean up server metadata by using GUI tools](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc816907(v=ws.10))  
[Clean up Active Directory Domain Controller server metadata](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup).

After you have verified that the replication between domain controllers is working correctly, determine whether an orphaned domain object exists. You can use the Ntdsutil.exe utility to clear the orphaned domain object. If there's any orphaned domain controller object for that domain, also delete the domain controller object. For more information, see [How to remove orphaned domains from Active Directory](../windows-security/remove-orphaned-domains.md).

For more information about how to remove orphaned domain controller objects, see [Clean up Active Directory Domain Controller server metadata](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup).

## More information

After you promote the domain controller to a global catalog server, the domain partitions in the forest are replicated to the new global catalog server. Event ID 1119 may be logged in the Directory Services log on the domain controller. This event may be logged after you assign the role of global catalog server to the domain controller, and after the account and the schema information is replicated to the new global catalog server.

The event description states that the computer is identified as a global catalog server. To confirm that the domain-naming master is a global catalog server, open a command prompt window, and then run the following command:

```console
nltest /dsgetdc:<Domain_Name> /server:<Server_Name>
```

The output of this command should resemble the following example:

```output
DC: \\<Server_Name>
Address: \\<IP_Address>
Dom Guid: <GUID>
Dom Name: <Domain_Name>
Forest Name: <Domain_Name.com>
Dc Site Name: Default-First-Site-Name
Our Site Name: Default-First-Site-Name
Flags: PDC GC DS LDAP KDC TIMESERV WRITABLE DNS_FOREST CLOSE_SITE
The command completed successfully
```

Verify that the `Flags` entry of the output includes `GC`.

For more information, see [How to remove orphaned domains from Active Directory](../windows-security/remove-orphaned-domains.md).
