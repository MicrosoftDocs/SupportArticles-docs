---
title: Can't change the ownership of a distribution group
description: Describes an issue that can occur when you try to change the ownership of a distribution group in Exchange Server 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Service Pack 1
ms.date: 01/24/2024
ms.reviewer: v-six
---
# You can't change the ownership of a distribution group in Exchange Server 2010 SP1

_Original KB number:_ &nbsp; 2675738

## Symptoms

Consider the following scenario:

- You install Exchange Server 2010 SP1.
- You start the Exchange Management Console (EMC).
- You create a distribution group.
- You view the properties of the distribution group.
- On the **Group Information** tab, you try to add a user to the **Managed by** group.

In this scenario, you may receive an error message that resembles the following one:

> You don't have sufficient permissions. This operation can only be performed by a Manager of the group

> [!NOTE]
> This issue doesn't occur in Exchange Server 2010.

## Cause

This issue occurs because the EMC cmdlet doesn't include the `-BypassSecurityGroupManagerCheck` parameter.

## Workaround

To work around this issue, follow these steps:

1. Run the following Exchange Management Shell (EMS) command in which *dl_name* is the name of the distribution group, and *user_name* is the name of the user whom you want to add:

    ```powershell
    Set-DistributionGroup -Identity dl_name -ManagedBy user_name -BypassSecurityGroupManagerCheck
    ```

2. Force Active Directory Domain Services replication.
3. Open the EMC, and verify that the user was granted ownership of the distribution list.

## References

[Change the Ownership of a Distribution Group](/previous-versions/office/exchange-server-2010/dd638201(v=exchg.141))
