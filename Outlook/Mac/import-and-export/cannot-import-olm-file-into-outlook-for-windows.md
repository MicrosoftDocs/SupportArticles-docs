---
title: Can't import (.olm) file into Outlook for Windows
description: Provides information about how to migrate the data, such as email and contacts, into Outlook for Windows by using Microsoft Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Errors, Crashes, and Performance
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# You can't import `.olm` files from Outlook for Mac to Outlook for Windows

_Original KB number:_ &nbsp; 2649169

## Summary

Consider the following scenario:

You try to transfer data from Outlook 2016 for Mac or Outlook for Mac 2011, such as email and contacts, to Outlook for Windows. To do so, you try to import the `.olm` file that was exported from Outlook for Mac. However, you receive the following error in Outlook for Windows:

> The file **\<path\>**.olm is not an Outlook data file (.pst).

## More information

Microsoft Outlook for Windows doesn't support `.olm` data files. However, there are several methods that you can use to transfer data from Outlook for Mac to a Windows-based Outlook client. These methods require that you use Microsoft Exchange Server.

### Synchronize data with Microsoft Exchange Server

If the data is available in a mailbox that's located on an Exchange Server, the Outlook for Windows client can access the data. To do so, the Windows client connects to the Exchange Server by using either Cached Exchange Mode or Online mode.

### Export data from Microsoft Exchange to an Outlook data (.pst) file

Use the `Export-Mailbox` shell cmdlet from Microsoft Exchange PowerShell to export mailbox data to an Outlook data (.pst) file. For more information about the `Export-Mailbox` shell cmdlet, see:

- [Mailbox imports and exports in Exchange Server](/Exchange/recipients/mailbox-import-and-export/mailbox-import-and-export)
- [How to Export and Import mailboxes to PST](https://techcommunity.microsoft.com/t5/exchange-team-blog/how-to-export-and-import-mailboxes-to-pst-files-in-exchange-2007/ba-p/594262)

> [!NOTE]
> Currently, Microsoft does not have a utility to convert an `.olm` file to a .pst file.
