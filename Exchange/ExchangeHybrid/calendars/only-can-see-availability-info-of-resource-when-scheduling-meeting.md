---
title: Only see availability info of resource when scheduling
description: Describes a scenario in which on-premises users can't view capacity and description information when they try to create a meeting that uses a resource such as a meeting room or company equipment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: camlat, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Users see availability but not capacity or description information of resource when scheduling meeting

_Original KB number:_ &nbsp; 3065364

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

Consider the following scenario:

- You have a hybrid deployment of on-premises Exchange Server and Exchange Online in Microsoft 365.
- An on-premises user tries to schedule a meeting that uses a resource such as a meeting room or company equipment.

In this scenario, the user can see availability information about the resource. However, other properties, such as capacity and description, are missing.

## Cause

This problem occurs if the resource mailbox was migrated from the on-premises environment to Exchange Online. Capacity and description properties of on-premises resource mailboxes are stored in the `msExchResourceCapacity` and `msExchResourceDisplay` attributes of the object in Active Directory Domain Services (AD DS). When the object is migrated from the on-premises environment to Exchange Online, these attributes are removed from the on-premises AD DS, this behavior is by design. Therefore, on-premises users can't view capacity and description information about migrated resource mailboxes.

## Resolution

To enable on-premises users to view capacity and description details about the migrated resource mailboxes, manually update the following attributes for the intended resource mailbox that's migrated to Exchange Online:

- `msExchResourceCapacity`
- `msExchResourceDisplay`
- `msExchResourceMetaData`
- `msExchResourceSearchProperties`

> [!NOTE]
> The `msExchResourceCapacity` attribute will have the capacity value defined for the resource mailbox. To ensure consistency across objects, obtain its value from the migrated resource mailbox properties in Exchange Online by running `Get-Mailbox MigratedResourceMailboxId | fl ResourceCapacity` in an [Exchange Online PowerShell session](/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps&preserve-view=true).

The following cmdlets must be run from an on-premises PowerShell session with the ActiveDirectory module imported:
 
- If the resource mailbox is an equipment mailbox, run the following cmdlet:
  
  ```powershell 
  Set-AdUser MigratedResourceMailboxId -Replace @{msExchResourceCapacity ="<TheCapacityValue>";msExchResourceDisplay="Equipment"; msExchResourceMetaData="ResourceType:Equipment"; msExchResourceSearchProperties="Equipment"}
  ```

- If the resource mailbox is a room mailbox, run the following cmdlet:

  ```powershell 
  Set-AdUser MigratedResourceMailboxId -Replace @{msExchResourceCapacity ="<TheCapacityValue>";msExchResourceDisplay="Room"; msExchResourceMetaData="ResourceType:Room"; msExchResourceSearchProperties="Room"}
  ```
  
## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
