---
title: Application pauses if having large data file
description: This article provides a resolution for the issue that application may pause if you have a large Outlook data file.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 01/30/2024
---
# You may experience application pauses if you have a large Outlook data file

_Original KB number:_ &nbsp; 2759052

## Symptoms

If you have a large Microsoft Outlook data file in your profile, you may experience application pauses. The larger the data file, the more application pauses you may experience.

> [!NOTE]
> Outlook data files may be either personal folders (.pst) files or offline folder (.ost) files.

## Cause

This problem occurs when the size of your Outlook data file is 10 gigabytes (GB) or more.

## Resolution

To resolve this problem, reduce the size of your Outlook data file by moving or archiving items from the file.

### Outlook 2007 and later versions

You may also consider using synchronization filters for Cached Mode profiles to reduce your `.ost` file size. The following blog post describes how to reduce the size of your local data file by using synchronization filters.

[Optimizing Outlook 2007 Cache Mode Performance for a Very Large Mailbox](https://techcommunity.microsoft.com/t5/exchange-team-blog/optimizing-outlook-2007-cache-mode-performance-for-a-very-large/ba-p/589536)

This is a stopgap solution and is provided here for reference if you cannot reduce the size of your mailbox. For example, you may be unable to reduce the size of your mailbox if you have to maintain an archive of all sent and received email messages over a span of several years.

### Outlook 2013 and later versions

For Outlook 2013 and later versions, you can also try to use the Sync Slider feature for Cached Mode profiles. This feature lets you control how many months of email messages are synchronized with your `.ost` file. For more information about the Sync Slider feature, see [Only a subset of your Exchange mailbox items are synchronized in Outlook](/outlook/troubleshoot/user-interface/only-subset-items-synchronized).

## More information

If you have a large .pst or `.ost` file, you may experience application pauses while you perform typical operations in Outlook. These typical operations include reading email messages, moving email messages, and deleting email messages.

The following list summarizes expected behavior based on the size of your Outlook data file.

- Up to 5 GB: This file size should provide a good user experience on most hardware.
- Between 5 GB and 10 GB: This file size is typically hardware-dependent. Therefore, if you have a fast hard disk and lots of RAM, your experience will be better. However, slower hard disk drives, such as drives that are typically found on portable computers or early-generation solid-state drives (SSDs), experience some application pauses when the drives respond.
- More than 10 GB: When the `.ost` file reaches this size, short pauses begin to occur on most hardware.
- Very large (25 GB or larger): An `.ost` file of this size increases the frequency of short pauses, especially while you are downloading new email messages. However, you can use Send/Receive groups to manually sync your mail.

For more information about how to troubleshoot performance issues in Outlook, see [How to troubleshoot performance issues in Outlook](https://support.microsoft.com/help/2695805).
