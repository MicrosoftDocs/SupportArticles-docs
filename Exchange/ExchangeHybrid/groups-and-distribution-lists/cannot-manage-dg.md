---
title: On-premises distribution group owner can't manage the group in Exchange Online
description: Describes an issue in which the owner of a distribution group that's synced to Office 365 can no longer manage the distribution group. A resolution is provided.
author: simonxjx
audience: ITPro
ms.prod: exchange-server-it-pro
ms.topic: article
ms.author: v-six
manager: dcscontentpm
ms.custom: CSSTroubleshoot
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
---

# Owners of an on-premises distribution group that's synced to Office 365 can't manage the distribution group in Exchange Online

## Problem 

When an on-premises distribution group is synced to a Microsoft Office 365 organization through Active Directory synchronization, migrated users who are owners of the distribution group can't manage it in Microsoft Exchange Online. For example, a user may receive an error message that resembles the following:

**The action '\<cmdlet>', '\<property>', can't be performed on the object '\<name>' because the object is being synchronized from your on-premises organization. This action should be performed on the object in your on-premises organization.**

## Solution 

Distribution groups that are created in Office 365 through directory synchronization must be managed in the on-premises environment. Distribution group owners must manage the group by using on-premises tools for Exchange Server such as the following:
- Exchange Admin Center   
- Exchange Management Console   
- Exchange Management Shell   

After changes are made to the group in the on-premises environment, the changes are synced to Office 365 the next time that directory synchronization runs. Or, to see the changes immediately, you can force directory syncronization. For more info about how to force directory synchronization, go to the following Microsoft website: 

[Force directory synchronization](https://technet.microsoft.com/library/jj151771.aspx#bkmk_synchronizedirectories)

We strongly recommend that you use native Exchange tools to manage distribution groups and mail-enabled security groups in your on-premises environment. For more info, go to the following Microsoft websites:

- Exchange 2013: [Manage distribution groups](https://technet.microsoft.com/library/bb124513%28v=exchg.150%29.aspx)   
- Exchange 2010: [Managing distribution groups](https://technet.microsoft.com/library/bb125256%28v=exchg.141%29.aspx)   

## References 

For more info about troubleshooting managing distribution groups in Office 365, see the following Microsoft Knowledge Base article:

[2731947](https://support.microsoft.com/help/2731947) "You don't have sufficient permissions" error when you try to remove or make a change to a distribution group in Office 365

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).