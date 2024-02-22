---
title: Managing RBAC roles shows warnings or errors
description: Discusses that managing RBAC roles might display warnings or errors if Exchange Server 2010 SP1 RU6 or Exchange Server 2010 SP2 are partially deployed in the organization.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: ninob, v-six
appliesto: 
  - Exchange Server 2010
search.appverid: MET150
---
# Managing RBAC roles might display warnings or errors if Exchange Server 2010 is partially deployed

_Original KB number:_ &nbsp; 2638351

## Symptoms

If Exchange Server 2010 SP1 RU6 or Exchange Server 2010 SP2 is partially deployed in the organization, running the `Get-ManagementRole` or `Get-ManagementRoleAssignment` cmdlets or using Exchange Control Panel (ECP) to manage RBAC management roles might display the following warnings or errors:

Exchange Management Shell (EMS):

> WARNING: The object MyMailboxDelegation has been corrupted, and it's in an inconsistent state. The following validation errors happened:  
> WARNING: The property value you specified, "15", isn't defined in the Enum type "ScopeType".

Exchange Control Panel (ECP):

When managing roles, during the **Select a Role** step, ECP might display a warning:

> There are multiple warnings. Click here to see more

If it is clicked, the following might be displayed:

> The object MyMailboxDelegation has been corrupted, and it's in an inconsistent state. The following validation errors happened:  
> The property value you specified, "15", isn't defined in the Enum type "ScopeType".

> [!IMPORTANT]
>
> - If warnings are displayed, the problem is just cosmetic; operations performed should succeed regardless of warnings.
> - If errors are displayed, follow the Resolution section of this article.

## Cause

The warnings or errors happen because both Exchange Server 2010 SP1 RU6 and Exchange Server 2010 SP2 make modification to RBAC role definitions in Active Directory and the server trying to manage them has not been updated yet. The following conditions need to be true for warning or errors to display:

- The user must be doing RBAC management.
- The user must be a member of Organization Management group.
- Not all servers in the organization have been updated with either Exchange Server 2010 SP1 RU6 or Exchange Server 2010 SP2.
- The management tool displaying a warning is not currently connected to one of updated servers during the current management session.

## Resolution

As previously mentioned, warnings are only cosmetic; the functionality of RBAC management is not impacted.

There are two ways to resolve those errors:

- Finalize the deployment of Exchange Server 2010 SP1 RU6 or Exchange Server 2010 SP2 on all of your Exchange Server 2010 servers that can be connected to for management.

  or

- When creating a management connection to a server, make sure that you connect to a server that has already been updated to Exchange Server 2010 SP1 RU6 or Exchange Server 2010 SP2. Specifying the server you would like to connect to using EMS can be done by using the following article:

  [Connect Remote Exchange Management Shell to an Exchange Server](/powershell/exchange/connect-to-exchange-servers-using-remote-powershell).
