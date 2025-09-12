---
title: Outlook users can't access public folders
description: Describes an issue in which Outlook users in an Exchange Server 2013 or Exchange Server 2016 environment can't access public mailbox folders, and provides resolutions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration\Issues with Public Folder Migration
  - Exchange Server
  - CI 119623
  - CSSTroubleshoot
ms.reviewer: guyg, batre, v-six
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
ms.date: 01/24/2024
---
# Outlook users can't access public folders in Exchange Server 2013 or Exchange Server 2016

_Original KB number:_ &nbsp; 2788136

## Symptoms

When Microsoft Outlook users try to access public folders in Exchange Server 2013 or Exchange Server 2016, the following dialog box appears:

:::image type="content" source="media/outlook-users-cannot-access-public-folders/exchange-dialog-box-appear.png" alt-text="Screenshot for the Microsoft Exchange dialog box.":::

However, if the users click **Ok** in this dialog box, they aren't connected to the public folder.

Additionally, the users may receive the following error message:

> Cannot expand the folder. The set of folders cannot be opened. The file C:\Users\\\<username>\AppData\Local\Microsoft\Outlook\filename.ost is in use and cannot be accessed. Close any application that is using this file, and then try again. You might need to restart your computer.

## Cause

This issue occurs because the AutoDiscover service can't discover the email address that is stamped on the public folder mailbox.

## Resolution

To resolve this issue, use one of the following methods:

- Create AutoDiscover-related DNS records for the email address that is stamped on the public folder mailbox. For more information about the Exchange 2010 Autodiscover service, see [White Paper: Understanding the Exchange 2010 Autodiscover service](/previous-versions/office/exchange-server-2010-technical-article/jj591328(v=exchg.141)).

    For more information about how to automatically configure user accounts in Outlook 2010, see [Plan to automatically configure user accounts in Outlook 2010](/previous-versions/office/office-2010/cc511507(v=office.14)).

- Change the email address of the public folder mailbox to match an email domain that already has published AutoDiscover records.

## More information

The public folder database concept is removed from Exchange Server 2013 and Exchange Server 2016. The public folders are now stored in a new kind of mailbox that is known as the Public Folder mailbox.

The Outlook client depends on information that is returned by the AutoDiscover service to access the Public Folder mailbox.

The following is an example of Public Folder mailbox information that is returned by the AutoDiscover service:

```xml
<PublicFolderInformation>  
    <SmtpAddress>PFMailbox@contoso.com</SmtpAddress>  
</PublicFolderInformation>
```

In this example, the Outlook client tries to *AutoDiscover* `PFMailbox@contoso.com`. However, if the DNS records that are related to `Contoso.com` aren't present, Public Folder access fails.
