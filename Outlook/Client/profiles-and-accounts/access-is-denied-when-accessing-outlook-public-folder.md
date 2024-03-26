---
title: Access is denied error when accessing a public folder
description: Describes a by design behavior that you receive an Access is denied or  Cannot display the selected folder or item error when clicking an outlook:// link that references an Exchange public folder.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: aruiz, sercast, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# "Access is denied" error when you click an "outlook:\\\\" link to a public folder in Outlook 2010 or Outlook 2013

## Symptoms

In Microsoft Outlook 2010 and Microsoft Outlook 2013, you receive either of the following errors when you click an outlook:// link that references an Exchange public folder:

> Access is denied.

> Cannot display the selected folder or item.

In earlier versions of Outlook, the same URL will open the public folder that is specified in the outlook:// path.

If you have not configured Outlook to trust the custom protocol handler outlook://, the following warning appears before either of the above errors:

> Microsoft Office has identified a potential security concern. This location may be unsafe. outlook://public folders/... Hyperlinks can be harmful to your computer and data. To protect your computer, click only those hyperlinks from trusted sources. Do you want to continue?

## Cause

This is a known limitation in Outlook 2010 and Outlook 2013.

## More information

Support for multiple Microsoft Exchange accounts in a single profile was added starting with Outlook 2010. With the introduction of this feature, each Exchange account is distinguished from others because the mailbox user's SMTP address is included in the Mailbox and Public Folder store names. The inclusion of this additional data in the folder structure prevents the "outlook:\\\\" protocol link from using the correct store/folder path.

In earlier versions of Outlook, the path of the top-level public folder is similar to the following:

\\\Public Folders\All Public Folders

In Outlook 2010 and Outlook 2013, the path of the top-level public folder is similar to the following:

\\\Public Folders - `user3@fourthcoffee.com`\All Public Folders

If user3 sends a public folder link to user4, the link must be changed to work for user4:

\\\Public Folders - `user4@fourthcoffee.com`\All Public Folders
