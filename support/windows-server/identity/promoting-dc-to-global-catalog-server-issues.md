---
title: Problem with promoting DC to global catalog server
description: Discusses problems with promoting a Windows Server 2003 domain controller or Windows 2000 domain controller to a global catalog server. Discusses possible causes of global catalog promotion failure and ways to resolve global catalog promotion failure.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Active Directory topology (sites, subnets, and connection objects)
ms.technology: windows-server-active-directory
---
# Troubleshoot problems with promoting a domain controller to a global catalog server

This article discusses a problem with promoting a domain controller to a global catalog server.

_Original product version:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 910204

## Summary

This article discusses the following topics:

- The event messages that are logged in the Directory Services log for Windows 2000 Server and for Windows Server 2003  
- The possible causes of the global catalog promotion failure  
- Ways to determine the cause of the global catalog promotion failure  
- Ways to resolve the global catalog promotion failure  

## Symptoms

When you try to promote a Microsoft Windows Server 2003 domain controller or a Microsoft Windows 2000 domain controller to a global catalog server, the domain controller may not advertise itself as a global catalog. This is true if you promote the domain controller programmatically or by clicking to select the **Global Catalog** option. When this problem occurs, event messages are logged in the Directory Services log.

Additionally, the output may show that the domain controller did not pass the advertising test and is not advertising the global catalog. This output occurs when a domain controller logs event ID 1578 and when you run a domain controller diagnostic check (Dcdiag.exe) on that domain controller.

> [!NOTE]
> To run a domain controller diagnostic check, do the following:

1. Click **Start**, click **Run**, type cmd, and then click **OK**.
2. At the command prompt, type `dcdiag /v /f: logfile.txt`, and then press ENTER. The following sections describe the event messages that are logged in the Directory Services log when this problem occurs.

### Windows 2000 event messages

- Informational event messages that are similar to the following are logged every 30 minutes:
  - Event ID 1559  
  - Event ID 1578

    > [!NOTE]
    > Although the "Global Catalog Partition Occupancy" registry subkey is mentioned in this event message, you should not reduce the occupancy level to artificially accelerate global catalog promotion. We strongly recommend that you first resolve the Directory Service replication issue so that the global catalog is automatically advertised.
  - Event ID 1110  
    > [!Warning]
    > event messages that are similar to the following may be logged every 15 minutes:  

  - Event ID 1265

    > [!NOTE]
    > The description for event ID 1265 may vary. Several possibilities will cause event ID 1265 to be recorded. These possibilities also cause the Knowledge Consistency Checker (KCC) not to build a replication link. The following are some typical possibilities:  
    >
      > - The DSA operation cannot continue because of a DNS lookup failure. Resolve the DNS problem, or remove the metadata if the source DSA address represents a stale domain controller.
      > - The RPC server is unavailable. This typically indicates a network connectivity issue. Determine whether the target domain controller is offline or whether a network port is blocked.
      > - The target principal name is incorrect. Examine the security channel between the source and target domain controllers.
      > - You receive an "Access Denied" error message.  
  
- The following Error event message is logged every hour:

    Event ID 1126  
    > Event ID: 1126
    >
    > Event Source: NTDS General
    >
    > Event type: Informational
    >
    > Description: Unable to establish connection with global catalog

#### Windows Server 2003 event messages

- Event ID 1559  
- Event ID 1578  
- If you enable diagnostic logging for the Knowledge Consistency Checker (KCC) at level 1, the following event is logged.  

    Event ID 1801  

## Cause

A global catalog must replicate inbound copies of all objects from all domain partitions in the forest before the global catalog can advertise the global catalog role.

When a domain controller is selected to host the global catalog, the KCC on the domain controller that is being promoted uses its discretion to build connection objects from source domain controllers that host the required partitions. These source domain controllers may consist of existing global catalogs in the forest or domain controllers that host writable copies of every domain partition that resides in its forest. The contents of each domain partition are then inbound replicated from source domain controllers that are designated by the KCC. The contents are replicated to the newly promoted global catalog over existing or newly created connection links.

Global catalog promotion may fail if one of the following conditions is true:  

1. The configuration partition on one or more domain controllers contains a cross-reference object to a stale or orphaned domain, but no domain controllers for that domain are located in the forest.

2. Metadata for a source domain controller that is designated by the KCC is located in the configuration partition of one or more domain controllers but does not represent a domain controller currently present in the forest.

3. The source domain controller that is selected by the KCC on the global catalog that is being promoted is offline.

4. The source domain controller that was selected by the KCC on the global catalog that is being promoted is inaccessible over the network. This domain controller is inaccessible because there is no network connectivity or partial network connectivity. The following are examples of network connectivity issues:
   - Ports that are blocked
   - IP addresses that are filtered
   - Networks that are not fully routed but that have the **bridge-all-site-links** option enabled
5. Source domain global catalogs are constrained from acting as bridgeheads because non-global catalog domain controllers have incorrectly been selected as preferred bridgeheads by administrators.

6. The global catalog that is being promoted cannot build a connection link from the selected source domain controller because of the error status that is logged in one of the events that are listed in the Summary section.

An orphaned domain will prevent the domain controller from finishing the replication. The domain controller cannot advertise itself as a global catalog server until replication is completed. There are several issues that could lead to an orphaned domain:  

1. Active Directory was removed from all the domain controllers of a domain, but the domain partition cross-reference object still remains.

2. Active Directory was removed from a domain controller, and the directory partition of the domain controller was removed. The domain controller was then re-created before replication was completed. These events caused lingering phantoms that a cross-reference object incorrectly references.

3. The domain-naming update for the domain has not reached the domain controller that is experiencing the problem. Or, the domain-naming update for a domain that is newly promoted may not have reached any domain controllers outside that domain. This issue would be a temporary problem.

## Resolution

> [!WARNING]
> You should not enable a reduced occupancy level to artificially accelerate global catalog promotion. We strongly recommend that you first resolve the Directory Service replication issue so that the global catalog is automatically advertised.

To resolve this problem, first identify the root cause of the replication issue, and resolve that problem. Determine whether the replication issue is caused by one of the following conditions:  

- A replication delay
- An orphaned domain that is located in the forest environment
- An inability to build the connection link
- An inability to replicate over the connection agreementIf there is an NTDS KCC event ID 1265 that is logged in the Directory Service log, use that event to determine the cause of the replication failure for the same domain partition. Make sure that network connectivity is good and that no required network ports are blocked. Required network ports are, for example, TCP 135 and ephemeral ports that are used by RPC. View the DNS records to make sure that the registered Host and SRV records are all correctly registered. If there are incorrect records, you must clear them out and register such records.

Remove all stale metadata for any domain controllers and domains in the forest that are listed in the relevant event IDs. You must do this to make sure that replication is not failing because of a non-existent domain controller or domain. For more information about how to remove Active Directory metadata, click the following article number to view the article in the Microsoft Knowledge Base:

[216498](https://support.microsoft.com/help/216498) How to remove data in Active Directory after an unsuccessful domain controller demotion  

After you have verified that the replication between domain controllers is working correctly, determine whether there is an orphaned domain object. You can use the Ntdsutil.exe utility to clear the orphaned domain object. If there is any orphaned domain controller object for that domain, you must also delete the domain controller object. For more information about how to remove an orphaned domain, click the following article number to view the article in the Microsoft Knowledge Base:

[230306](https://support.microsoft.com/help/230306) How to remove orphaned domains from Active Directory  

For more information about how to remove orphaned domain controller objects, click the following article number to view the article in the Microsoft Knowledge Base:

[216498](https://support.microsoft.com/help/216498) How to remove data in Active Directory after an unsuccessful domain controller demotion  

## More information

After you promote the domain controller to a global catalog server, domain partitions in the forest will be replicated to the new global catalog server. When all partitions have successfully replicated to the new global catalog server, event ID 1119 will be logged in the Directory Services log on the domain controller. The event description states that the computer is now advertising itself as a global catalog server.

To confirm that the domain controller is a global catalog server, follow these steps:  

1. Click **Start**, click **Run**, type cmd, and then click **OK**.

2. Type `nltest /dsgetdc: Domain_name /server: Server_Name`, and then press ENTER.

3. Verify that the server is advertising the "GC" (global catalog) flag. For example, when you type the command in step 2, you will receive a message that is similar to the following if the GC flag is present:  

    > DC: \\\\ **Server_Name**  
    >Address: \\\\ **IP Address**  
    >Dom Guid: 47bc7d87-309e-4a2a-bac3-c9866a66bab8
    >
    > Dom Name: **Domain_name**  
    > Forest Name: **Domain_name .com**  
    > Dc Site Name: Default-First-Site-Name
    >
    > Our Site Name: Default-First-Site-Name
    >
    > Flags: PDC GC DS LDAP KDC TIMESERV WRITABLE DNS_FOREST CLOSE_SITE The command completed successfully  

    > [!NOTE]
    > The Nltest tool is included with Windows 2000 Support Tools. To install Windows 2000 Support Tools, open the Support\Tools folder on the Windows 2000 startup disk, and then run the Setup program. You must log on as a member of the Administrators group to install these tools.  

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[889711](https://support.microsoft.com/help/889711) You cannot promote a Windows Server 2003-based domain controller to be a global catalog server  

[230306](https://support.microsoft.com/help/230306) How to remove orphaned domains from Active Directory
