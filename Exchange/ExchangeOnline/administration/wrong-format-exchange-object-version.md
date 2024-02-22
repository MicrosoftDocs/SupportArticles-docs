---
title: Format of the Exchange object version is wrong
description: Provides a workaround for an issue in which you receive an error message when you try to connect to Exchange Online by using the Exchange Management Console in Exchange 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Service Pack 3
search.appverid: MET150
ms.date: 01/24/2024
---
# Format of the Exchange object version is wrong when you connect to Exchange Online in EMC

_Original KB number:_ &nbsp; 3143722

## Problem

When you try to connect to Exchange Online through the Exchange Management Console (EMC) in Microsoft Exchange Server 2010, you receive the following error message:

> The following error occurred while attempting to connect to the specified Exchange server 'PS.Outlook.com'
>
> The format of the Exchange object version is wrong  
> Parameter name: ExchangeBuild

This problem causes the following conditions to occur:

- You can't run the Hybrid Configuration Wizard that's included in the EMC.
- You can't view the properties of recipients in Exchange Online from the EMC. (You can still manage recipients in the EMC, but you can't view the properties of the recipients.)

## Workaround

To work around this problem, do one or both of the following, as appropriate for your situation:

- Run the [Microsoft 365 Hybrid Configuration Wizard](https://aka.ms/hybridwizard).
- To view the recipient properties for mailboxes in an environment that has directory synchronization enabled, use the Exchange admin center in Exchange Online or use Exchange Online PowerShell.

## More information

For more information about using the Microsoft 365 Hybrid Configuration wizard in Exchange 2010, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
