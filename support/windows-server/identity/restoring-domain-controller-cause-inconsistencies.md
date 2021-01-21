---
title: Event ID 1587 after you restore domain controller
description: Restoring a domain controller may cause inconsistencies between domain controllers. If this occurs, some lingering objects may be present on the restored domain controller. Also, new objects on the restored domain controller are not replicated. This article suggests a workaround correct the problem.
ms.date: 09/14/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Active Directory backup, restore, or disaster recovery
ms.technology: windows-server-active-directory 
---
# Restoring a domain controller may cause inconsistencies between domain controllers

This article provides help to solve an issue where restoring a domain controller causes inconsistencies between domain controllers.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 316829

## Symptoms

Restoring a domain controller may cause an Event ID: 1587, indicating inconsistencies between domain controllers. If this occurs, some lingering objects may be present on the restored domain controller. Also, new objects on the restored domain controller are not replicated. 

## Cause

This problem occurs because the domain controller assigns a new invocation ID, but uses the original highwater mark.

## Workaround

To work around this problem, demote and then promote the restored domain controller. Before you demote the affected server, force a full replication of the affected server to another domain controller. (The full synchronization can be resource-intensive for larger domains.) Perform the full synchronization on the domain partition and on the configuration partition. The following line shows the syntax of the Repadmin command that you use to perform the synchronization: repadmin /sync <Naming Context> <Dest DC> <Source DC GUID> [/force] [/full] 
The following line is an example use of this command: repadmin /sync DC=domain,DC=root good_DC dc1 122a5239-36b3-488a-b24c-971ed0ca8a46 /force /full 

In the example command,
- "DC=domain,DC=root" is the domain naming context.

- "good_DC" is the destination DC. This is the good partner that will receive the updates.
- The DSA GUID is the replication GUID for the restored DC. You can get this by running Repadmin /showreps on the restored server. The GUID is listed at the top under "DC Object Guid".

If the synchronization is successful, you receive the following message: Sync from 122a5239-36b3-488a-b24c-971ed0ca8a46 to Good_DC completed successfully.

Repeat the process for the configuration naming context by using a command similar to the following:

repadmin /sync cn=configuration,DC=domain,DC=root good_DC dc1 122a5239-36b3-488a-b24c-971ed0ca8a46 /force /full 

The problem is not likely to be solved after you do this. After you do this, install the hotfix or demote and then promote the domain controller to solve the problem.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article. This problem was first corrected in Windows 2000 Service Pack 3. 

## More information

When you restore a domain controller, the highest committed USN is rolled back to the point when the backup was created. The domain controller's invocation ID is retired and a new one is assigned. When a partner tries to replicate the first time after the restoration, the following message is recorded:

> Event Type: Information  
Event Source: NTDS Replication  
Event Category: (5)  
Event ID: 1587  
Date: *\<DateTime>*  
Time: *\<DateTime>*  
User: CONTOSO\\CO-NA-DC-01$  
Computer: CO-DC-02  
Description:  
The Directory Service Agent (DSA) corresponding to objectGuid   d0a6a575-9702-4f4e-bf68-bb2a9f875188 has asked for changes starting at a bookmark preceding the local DSA's most recent restore from backup at USN 94727614. The bookmark is being adjusted as follows: Previous Invocation ID: bc546028-fae7-4978-abe0-d294694da32b  
Previous Object Update USN: 95853579  
Previous Property Update USN: 95853579  
New Invocation ID: ae6286cb-740b-4bb3-ace7-9577efa9dc9f  
New Object Update USN: 94727614  
New Property Update USN: 94727614  

This event is typical for a restored domain controller. By itself, this does not indicate a problem. This is a problem if objects that are created on the restored domain controller "silently" do not replicate out.

In the problem scenario, the highest USN is rolled back. However, during the bookmark (or "up-to-dateness" vector reset), the source domain controller supplies the highest USN value that was present before the restoration. Objects that have USNchanged values between the upper and lower highestCommittedUSN attribute value are never considered for replication.

For example: Assume that domain controller 1 has a highest USN of 100. Its replication partner, domain controller 2, has an "up-to-dateness" vector of 100 for domain controller 1.

You restore domain controller 1 from a backup on which the highest USN is 50. After the next replication with domain controller 2, domain controller 1 resets the bookmark to 100 (it should be 50). domain controller 1 originates changes 51, 52, and 53. When domain controller 2 negotiates replication, it never considers the changes because it believes that it has changes up through 100. domain controller 1 continues to make changes and eventually reaches 101. Change 101 is replicated, but changes 51 through 100 are not.

In some cases, you can detect this state. Use Ldp or ADSI Edit to read the current highestCommittedUSN attribute on the rootDSE object on the restored domain controller. Then, compare that to the output from the **repadmin /showreps /verbose** command on one of its partners. In the Repadmin output, look for the "USN ###/OU" value for the restored domain controller for each naming context. If the value in Repadmin is higher than the highestCommittedUSN attribute, the restored domain controller is experiencing the problem.

If the restored domain controller has originated enough updates that its highestCommittedUSN attribute has reached or exceeded the "up-to-dateness" vector that is recorded on the other domain controllers (as in the example in this article), some changes will never be considered for replication. However, new changes are replicated out. The unreplicated changes are referred to as "lingering objects."
