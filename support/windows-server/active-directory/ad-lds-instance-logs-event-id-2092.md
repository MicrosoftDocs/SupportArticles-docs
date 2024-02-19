---
title: AD LDS instance logs Event ID 2092
description: Provides a solution to an issue that occurs when you reboot an AD LDS server that holds FSMO roles or restart an AD LDS instance on that server.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, akhleshs, tspring, lindakup, justintu
ms.custom: sap:active-directory-migration-tool-admt, csstroubleshoot
---
# AD LDS instance logs Event ID 2092 in Windows Server

This article provides a solution to an issue that occurs when you reboot an AD LDS server that holds FSMO roles or restart an AD LDS instance on that server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2547569

## Symptoms

When you reboot an Active Directory Light-weight Domain Services (AD LDS) server that holds Flexible Single Master Operations (FSMO) roles or restart an AD LDS instance on that server, you get a warning message (Event ID 2092) in the ADAM event viewer for that particular instance. Event ID 2092 shows:

> Log Name: ADAM (InstanceName)  
Source: ADAM [InstanceName] Replication  
Date:  
Event ID: 2092  
Task Category: Replication  
Level: Warning  
Keywords: Classic  
User: ANONYMOUS LOGON  
Computer: ADAMComputerName  
Description:
>
> This server is the owner of the following FSMO role, but does not consider it valid. For the partition which contains the FSMO, this server has not replicated successfully with any of its partners since this server has been restarted. Replication errors are preventing validation of this role.  
Operations which require contacting a FSMO operation master will fail until this condition is corrected.
>
> FSMO Role: CN=Schema,CN=Configuration,CN={95B93FA0-93B9-4E54-A654-0D55F5CF9E4B}
>
> User Action:
>
> 1. Initial synchronization is the first early replications done by a system as it is starting. A failure to initially synchronize may explain why a FSMO role cannot be validated. This process is explained in KB article 305476.
> 2. This server has one or more replication partners, and replication is failing for all of these partners. Use the command repadmin /showrepl to display the replication errors. Correct the error in question. For example there maybe problems with IP connectivity, DNS name resolution, or security authentication that is preventing successful replication.
> 3. In the rare event that all replication partners being down is an expected occurrence, perhaps because of maintenance or a disaster recovery, you can force the role to be validated. This can be done by using NTDSUTIL.EXE to seize the role to the same server. This may be done using the steps provided in KB articles 255504 and 324801 on `https://support.microsoft.com`.
>
> The following operations may be impacted:  
Schema: You will no longer be able to modify the schema for this forest.  
Domain Naming: You will no longer be able to add or remove domains from this forest.  
PDC: You will no longer be able to perform primary domain controller operations, such as Group Policy updates and password resets for non-Active Directory Lightweight Directory Services accounts.  
RID: You will not be able to allocation new security identifiers for new user accounts, computer accounts or security groups.  
Infrastructure: Cross-domain name references, such as universal group memberships, will not be updated properly if their target object is moved or renamed.

> Log Name: ADAM (InstanceName)  
Source: ADAM [InstanceName] Replication  
Date:  
Event ID: 2092  
Task Category: Replication  
Level: Warning  
Keywords: Classic  
User: ANONYMOUS LOGON  
Computer: ADAMComputerName  
Description:  
>
> This server is the owner of the following FSMO role, but does not consider it valid. For the partition which contains the FSMO, this server has not replicated successfully with any of its partners since this server has been restarted. Replication errors are preventing validation of this role.  
Operations which require contacting a FSMO operation master will fail until this condition is corrected.
>
> FSMO Role: CN=Partitions,CN=Configuration,CN={95B93FA0-93B9-4E54-A654-0D55F5CF9E4B}
>
> User Action:
>
> 1. Initial synchronization is the first early replications done by a system as it is starting. A failure to initially synchronize may explain why a FSMO role cannot be validated. This process is explained in KB article 305476.
> 2. This server has one or more replication partners, and replication is failing for all of these partners. Use the command repadmin /showrepl to display the replication errors. Correct the error in question. For example there maybe problems with IP connectivity, DNS name resolution, or security authentication that is preventing successful replication.
> 3. In the rare event that all replication partners being down is an expected occurrence, perhaps because of maintenance or a disaster recovery, you can force the role to be validated. This can be done by using NTDSUTIL.EXE to seize the role to the same server. This may be done using the steps provided in KB articles 255504 and 324801 on `https://support.microsoft.com`.
>
> The following operations may be impacted:  
Schema: You will no longer be able to modify the schema for this forest.  
Domain Naming: You will no longer be able to add or remove domains from this forest.  
PDC: You will no longer be able to perform primary domain controller operations, such as Group Policy updates and password resets for non-Active Directory Lightweight Directory Services accounts.  
RID: You will not be able to allocation new security identifiers for new user accounts, computer accounts or security groups.  
Infrastructure: Cross-domain name references, such as universal group memberships, will not be updated properly if their target object is moved or renamed.

## Cause

When there are two or more AD LDS instances in a replica set, FSMO-owning AD LDS instances are required to in-bound replicate a particular partition on service start-up in order to satisfy initial synchronization requirements. Event 2092 is logged shortly after service start-up to indicate this condition. The domain naming FSMO is required to replicate the Configuration partition, and the Schema FSMO is required to replicate the Schema partition. Once the respective partition has been replicated successfully updates will be allowed again. There is no event logged to indicate that initial synchronization has completed successfully.

## Resolution

If AD LDS replication is working between instances, you can ignore this event. This is a by design behavior that FSMO role holder instance looks for a replica partner to update the information, when AD LDS service/server is restarted.

## More information

To check replication between AD LDS instances, you can use dcdiag.exe or repadmin.exe. For more information, see the following articles:

- [Repadmin](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770963(v=ws.10))

- [Dcdiag](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731968(v=ws.10))
