---
title: Can't view items in an Exchange Online archive mailbox by using Microsoft Outlook Web App
description: Describes an issue in which users can't access an online archive mailbox by using Outlook Web App.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - 'Associated content asset: 4555325'
ms.reviewer: subansal, mhaque
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 06/24/2024
---
# Can't view items in Exchange Online archive mailbox by using Microsoft Outlook Web App

_Original KB number:_&nbsp;4051373

## Symptoms

When a user tries to view items in a Microsoft Exchange Online archive mailbox by using Outlook Web App (Microsoft Outlook Web App), they receive the following error message:

> Your request can't be completed right now. Try again.

## Cause

This problem can occur due to a regression in Cumulative Update 6 (CU6) for Exchange Server 2016 that breaks this functionality.

## Status

Microsoft has confirmed that this is an issue in the Microsoft products that are listed in the 'Applies to' section.

This issue is scheduled to be fixed in a future update.

## More Information

This issue only occurs if the user's primary mailbox is on Exchange 2016. See the 'Symptoms' and run the following command (in Exchange 2016 PowerShell) to confirm the issue:

```powershell
Test-ArchiveConnectivity -UserSmtp EmailAddressOfUser -IncludeArchiveMRMConfiguration -Verbose | FL
```

The result resembles the following:

```console
Result : Couldn't log on to the mailbox.
Error : Cannot find row based on condition. There is no support for this operation. MapiExceptionNoSupport: Unable to find table row. (hr=0x80040102, ec=-2147221246)
```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
