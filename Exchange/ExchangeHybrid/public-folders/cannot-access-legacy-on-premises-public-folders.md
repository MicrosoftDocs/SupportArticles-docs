---
title: Can't access legacy on-premises public folders
description: Describes an issue in which an Exchange Online user receives a The set of folders cannot be opened error message when they access legacy on-premises public folders in a hybrid deployment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: jmartin, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Exchange Online users can't access legacy on-premises public folders

_Original KB number:_ &nbsp; 3106618

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

You have a hybrid deployment of Microsoft Exchange Online in Microsoft 365 and on-premises Microsoft Exchange Server, and you've configured on-premises public folders in Exchange Server 2010 or Exchange Server 2007. These folders are also known as legacy public folders.

In this scenario, a user who was created in Exchange Online receives the following error message when they try to access the legacy public folders:

> Cannot expand the folder. The set of folders cannot be opened.  
> Network problems are preventing connection to Microsoft Exchange

## Cause

This issue occurs if the mailbox for the user was created in Exchange Online and doesn't have an associated on-premises user object for authentication to the public folder.

## Solution

For this issue to be resolved, the Exchange Online mailbox must be linked to an on-premises user account. For more information, see [How to use SMTP matching to match on-premises user accounts to Microsoft 365 user accounts for directory synchronization](https://support.microsoft.com/help/2641663).

## More information

For more information, see [Configure legacy on-premises public folders for a hybrid deployment](/exchange/collaboration-exo/public-folders/set-up-legacy-hybrid-public-folders)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
