---
title: Can't open files offline when you use Offline Files and Windows Information Protection
description: Describes an issue that prevents you from opening files offline when you're using the Offline Files feature together with Windows Information Protection. Occurs in Windows 10 Anniversary Edition. Workarounds are provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\Offline Files and Folders (CSC), csstroubleshoot
---
# Can't open files offline when you use Offline Files and Windows Information Protection

This article provides workarounds for an issue that prevents you from opening files offline when you're using the Offline Files feature together with Windows Information Protection.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3187045

## Symptoms

Consider the following scenario:

- You have Windows 10 installed.
- Special folders (for example, Documents or Favorites) are redirected to a file share.
- User data in the redirected folders is cached locally through the Offline Files feature.
- Windows Information Protection (also known as Enterprise Data Protection) is enabled on the system.
- You're using an application that's managed by Windows Information Protection.

If you try to open a file while working offline in this scenario, the attempt fails. The error message that's displayed in this situation varies, depending on the application. Word and Excel fail with the following error:
> Sorry, we couldn't open '\\\severname\fileshare\filename'

## Cause

This issue occurs because the Offline Files feature doesn't support Windows Information Protection.

## Workaround

To work around this issue, use one of the following methods:

- Open the file by using an application that's not managed by Windows Information Protection.
- Open the file while you're working online (connected to your corporate network).

## More information

There are no plans to update Offline Files to support Windows Information Protection. We recommend that you migrate to a modern file sync solution such as [Work Folders](https://technet.microsoft.com/library/dn265974.aspx) or [OneDrive for Business](https://onedrive.live.com/about/business/).

For information about how to migrate from Offline Files to Work Folders see the following TechNet site:

[Offline Files (CSC) to Work Folders Migration Guide](https://blogs.technet.microsoft.com/filecab/2016/08/12/offline-files-csc-to-work-folders-migration-guide/)
