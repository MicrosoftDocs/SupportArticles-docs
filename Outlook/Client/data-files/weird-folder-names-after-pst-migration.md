---
title: Weird folder names after PST migration
description: Works around an issue in which the mailbox folder names appear with special characters after PST migration from Exchange Server 2003 to Exchange Server 2013.
ms.date: 10/30/2023
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
---
# Weird folder names after PST migration from Exchange Server 2003 to Exchange Server 2013

_Original KB number:_ &nbsp; 2978469

## Symptom

Consider the following scenario:

- You export data from a Mailbox on Exchange Server 2003 to a pst file by using Mailbox Merge Wizard (ExMerge).
- You use the `New-MailboxImportRequest` cmdlet to import the pst file into a Mailbox on Exchange Server 2013.

In this scenario, the folder names in the Exchange Server 2013 Mailbox appear with special characters.

## Cause

This issue occurs because the pst files that were created by ExMerge are in non-Unicode code and this is not supported by Exchange 2013.

## Workaround

To work around this issue, use Microsoft Outlook to export the data from the mailbox on Exchange Server 2003. Outlook creates a Unicode data file (.pst). Then use the `New-MailboxImportRequest` cmdlet to import the PST file. For more information about how to import the pst file to Mailbox, see [Mailbox Import and Export Requests](/exchange/mailbox-import-and-export-requests-exchange-2013-help).
