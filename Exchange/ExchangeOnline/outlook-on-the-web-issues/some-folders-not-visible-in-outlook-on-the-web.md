---
title: Some folders are not visible in Outlook on the web
description: Describes an issue that prevents you from seeing all your folders in Outlook on the web. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: davidspo, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Some folders are not visible in Outlook on the web

_Original KB number:_ &nbsp; 2849181

## Symptoms

When you view a mailbox in Outlook on the web (formerly known as Outlook Web App (OWA)), some of your folders are not visible. When this issue occurs, it's typically the Sent Items folder that's not visible.

## Cause

This issue occurs when the mailbox contains too many folders. The maximum number of folders in a single mailbox that Outlook on the web can display at one time is 10,000.

To confirm that this is the issue that you're experiencing, determine the number of folders in the mailbox. To do this, follow these steps:

1. Do one of the following, as appropriate for your situation:
   - Open Exchange Management Shell on the on-premises Exchange server.
   - Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Run one of the following commands:
   - To display the results on the screen, run the following command:

     ```powershell
     (Get-MailboxFolderStatistics <alias@contoso.com>).count
     ```

   - To send the results to a .txt file, run the following command:

     ```powershell
     (Get-MailboxFolderStatistics <alias@contoso.com>).count > c:\output.txt
     ```

## Resolution

To resolve this issue, reduce the total number of folders in the mailbox to fewer than 10,000.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
