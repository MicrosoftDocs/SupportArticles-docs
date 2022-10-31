---
title: Only see availability info of resource when scheduling
description: Describes a scenario in which on-premises users can't view capacity and description information when they try to create a meeting that uses a resource such as a meeting room or company equipment.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: camlat
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 3/31/2022
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

This problem occurs if the resource mailbox was migrated from the on-premises environment to Exchange Online. Capacity and description properties of on-premises resource mailboxes are stored in the `msExchResourceCapacity` and `msExchResourceDisplay` attributes of the object in Active Directory Domain Services (AD DS). When the object is migrated from the on-premises environment to Exchange Online, these attributes are removed from the on-premises AD DS. Therefore, on-premises users can't view capacity and description information about migrated resource mailboxes.

## Resolution

To enable on-premises users to view capacity and description details about the migrated resource mailboxes, manually update the `msExchResourceCapacity` and `msExchResourceDisplay` attributes that were migrated to Exchange Online.

To do this, follow these steps:

1. Retrieve the values of the attributes from Exchange Online. To do this, follow these steps:
   1. Connect to Exchange Online by using remote Windows PowerShell. For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
   2. Run the [Get-Mailbox](/powershell/module/exchange/get-mailbox?view=exchange-ps&preserve-view=true) cmdlet to retrieve the values for these attributes from Exchange Online.
   3. Examine the output, and note the values that are returned for the `ResourceCapacity` and `ResourceCustom` properties.
2. Use the values that you obtained in step 1 to update the `msExchResourceCapacity` and `msExchResourceDisplay` attributes of the objects in the on-premises Active Directory.

> [!NOTE]
> You may receive warnings when you access such room or equipment mailboxes if they're attempted to be accessed by using EAC or Exchange Management Shell in the on-premises Exchange server. If you need to modify some properties on the on-premises Exchange server, clear these attributes, and perform the intended task by using Exchange Management Shell or EAC. Upon completion you can update `msExchResourceCapacity` and `msExchResourceDisplay` back to the original values.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
