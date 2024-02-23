---
title: Cannot determine group type error when checking group in Microsoft 365 admin center
description: Cannot determine group type error occurs in Microsoft 365 admin center when you convert a group to a room list by using Set-DistributionGroup.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CI 114841
  - CSSTroubleshoot
ms.reviewer: aubelin, v-six
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 01/24/2024
---
# (Cannot determine group type) error when checking group in Microsoft 365 admin center

## Symptoms

A distribution group is converted to a room list by running the following cmdlet:

```powershell
Set-DistributionGroup <group name> -RoomList
```

When you examine the distribution group in the Microsoft 365 admin center, you see the following error message:

> Cannot determine group type

## Resolution

Create room lists by using the following cmdlet instead:

```powershell
New-DistributionGroup <group name> -RoomList
```

For more information, see [New-DistributionGroup](/powershell/module/exchange/new-distributiongroup).

> [!NOTE]
> Room list distribution groups are not visible in the Microsoft 365 admin center or the Exchange admin center. The groups can be managed only through PowerShell.
