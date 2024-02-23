---
title: You receive an error when copying MSG email files in Outlook that contain multiple attachments or recipients
ms.author: meerak
author: cloud-writer
manager: dcscontentpm
ms.date: 10/30/2023
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - All versions of Outlook
ms.custom: 
  - Outlook for Windows
  - CI 111840
  - CSSTroubleshoot
ms.reviewer: sgriffin
description: Explains why you may receive error messages when trying to copy emails in MSG format that contain a large number of attachments or recipients.
---

# Error when you copy MSG email message files in Outlook containing multiple attachments or recipients

## Symptoms

You may receive an error when copying or opening MSG emails in Outlook if the message contains a large number of attachments or recipients.

Symptoms include:

- Copying or opening an MSG file takes longer than normal.
- Loss of data in the MSG when compared to the original.
- Out of memory errors.

## Cause

Archiving is not the functional purpose of an MSG format. There are a number of issues regarding the MSG format that are important to understand:

- The MAPI specification requires a new transaction each time a recipient or attachment is added. Com Structured Storage, the underlying storage format on which MSG is built, cannot handle a large number of transactions on it. A limit will be reached whenever a message has a large number of recipients or attachments, or when there exists a deep level of embedded messages. Depending on exactly where the limit is encountered, it may be observed either as an outright failure or a memory error.
- The underlying storage format is a legacy format that cannot be altered.
- The time needed to write to an MSG file increases exponentially as the number of transactions increases. For example, a message with more than 5000 recipients may take over an hour to copy into an MSG file.

## More information

When you take into consideration the following issues:

- Messages that cannot be copied to the archive (or opened, once it is archived)
- A slow API
- A format that's not capable of representing the actual message being archived
The process of archiving email to an MSG format does not contain desirable traits.

For developers seeking to export messaging data, the only workaround is to avoid using MSG to archive messages. Instead, develop your own file format to preserve the important properties on a message.

For more detailed information about this subject, see the Microsoft blog post [No MSG For You!](/archive/blogs/stephen_griffin/no-msg-for-you).
