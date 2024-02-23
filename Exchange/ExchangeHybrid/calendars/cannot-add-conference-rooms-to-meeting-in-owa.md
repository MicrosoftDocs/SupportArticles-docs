---
title: Cannot add rooms to meeting requests in OWA
description: Describes an issue that occurs in a hybrid deployment when Exchange Online users select add room in a meeting request in Outlook Web App.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Exchange Online users can't add on-premises conference rooms to meeting requests in Outlook Web App

_Original KB number:_ &nbsp; 2904381

## Symptoms

In a hybrid deployment of on-premises Microsoft Exchange Server and Exchange Online, assume that Exchange Online users select **add room** in a meeting request in Outlook Web App. In this situation, on-premises room mailboxes aren't displayed in the list as expected. Therefore, Exchange Online users can't add an on-premises conference room to a meeting request.

## Cause

This issue occurs if the `recipientTypeDetails` property of on-premises room mailboxes is set to **MailUser**.

When a room mailbox is created in the cloud, its `recipientTypeDetails` property is set to **RoomMailbox**. In a hybrid environment, on-premises room mailboxes are synced to the cloud through directory synchronization. After directory synchronization occurs, the `recipientTypeDetails` property of on-premises room mailboxes is set to **MailUser**.

## Resolution

Add on-premises mailboxes to an on-premises room list. To do this, open the Exchange Management Shell on the on-premises Exchange server, and then run the following cmdlets:

```powershell
New-DistributionGroup -Name <NameOfRoomList> -roomlist
```

```powershell
Add-DistributionGroupMember <NameOfRoomList> -member <OnPremisesRoomMailbox>
```

> [!NOTE]
> A room list has a limit of 100 room mailboxes per room.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
