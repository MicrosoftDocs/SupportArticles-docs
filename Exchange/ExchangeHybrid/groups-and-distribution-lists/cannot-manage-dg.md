---
title: On-premises distribution group owner can't manage the group in Exchange Online
description: Describes an issue in which the owner of a distribution group that's synced to Microsoft 365 can no longer manage the distribution group. A resolution is provided.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Hybrid
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Owners of an on-premises distribution group synced to O365 can't manage the distribution group in Exchange Online

## Problem

When an on-premises distribution group is synced to a Microsoft 365 organization through Active Directory synchronization, migrated users who are owners of the distribution group can't manage it in Microsoft Exchange Online. For example, a user may receive an error message that resembles the following:

> The action '\<cmdlet>', '\<property>', can't be performed on the object '\<name>' because the object is being synchronized from your on-premises organization. This action should be performed on the object in your on-premises organization.**

## Solution

Distribution groups that are created in Microsoft 365 through directory synchronization must be managed in the on-premises environment. Distribution group owners must manage the group by using on-premises tools for Exchange Server such as the following:

- Exchange Admin Center
- Exchange Management Console
- Exchange Management Shell

After changes are made to the group in the on-premises environment, the changes are synced to Microsoft 365 the next time that directory synchronization runs. Or, to see the changes immediately, you can force directory synchronization. For more info about how to force directory synchronization, go to the following Microsoft website:

[Force directory synchronization](/azure/active-directory/hybrid/whatis-hybrid-identity#bkmk_synchronizedirectories)

We strongly recommend that you use native Exchange tools to manage distribution groups and mail-enabled security groups in your on-premises environment. For more info, go to the following Microsoft websites:

- Exchange 2013: [Create and manage distribution groups in Exchange Online](/exchange/recipients-in-exchange-online/manage-distribution-groups/manage-distribution-groups)
- Exchange 2010: [Managing distribution groups](/previous-versions/office/exchange-server-2010/bb125256(v=exchg.141))

## References

For more info about troubleshooting managing distribution groups in Microsoft 365, see ["You don't have sufficient permissions" error when you try to remove or make a change to a distribution group](../../ExchangeOnline/groups-and-distribution-lists/no-sufficient-permissions-moving-dg.md).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
