---
title: Wrong output when running Get-CASMailbox
description: Describes an issue in which incorrect output is returned when you run the Get-CASMailbox cmdlet to view the HasActiveSyncDevicePartnership attribute in Exchange Online. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Incorrect output when you run Get-CASMailbox to view HasActiveSyncDevicePartnership

_Original KB number:_ &nbsp; 3001236

## Symptoms

In a Microsoft Exchange Online environment, you run the `Get-CASMailbox` cmdlet to view the `HasActiveSyncDevicePartnership` attribute. The output shows that the mailbox has no device partnership. However, the user has one or more devices that are synchronizing with their mailbox.

## Resolution

To resolve this issue, run the following command:

```powershell
Get-CASMailbox <Alias> -RecalculateHasActiveSyncDevicePartnership
```

> [!NOTE]
> The `RecalculateHasActiveSyncDevicePartnership` parameter was introduced to the `Get-CASMailbox` cmdlet in build 15.00.0980.000 of Microsoft 365. To determine the build of Microsoft 365 that the mailbox is on, run the following command:

```powershell
Get-Mailbox <Mailbox> | fl AdminDisplayVersion
```

## More information

The `RecalculateHasActiveSyncDevicePartnership` parameter recalculates the value of the `HasActiveSyncDevicePartnership` attribute on the mailbox. The value is automatically updated if it's determined to be incorrect. You don't have to specify a value for the `HasActiveSyncDevicePartnership` attribute.

For more information, see [Get-CASMailbox](/powershell/module/exchange/get-casmailbox?view=exchange-ps&preserve-view=true).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
