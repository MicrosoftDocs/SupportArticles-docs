---
title: Invalid file name or Access denied error when adding pst or ost file
description: You get an error when adding a .pst or .ost file in Outlook 2016 version 16.0.7910.1000 or later if the file isn't located on a local hard drive.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Outlook 2019
- Outlook 2016
- Outlook for Microsoft 365
search.appverid: MET150
ms.reviewer: sbradley, robevans, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Error when you add a PST or OST file on a non-local drive in Outlook 2016

## Symptoms

When you try to add a personal folder file (.pst) or an offline folder file (.ost) in Microsoft Outlook 2016, you receive an error message that states that the file can't be opened. These may include:

- Errors indicating that the PST file has an "invalid file name."
- "Access denied" errors.

This issue occurs when the following conditions are true:

- The version of Outlook 2016 is 16.0.7910.1000 or later ([how to check what version of Outlook do I have?](https://support.microsoft.com/office/what-version-of-outlook-do-i-have-b3a9568c-edb5-42b9-9825-d48d82b2257c)).
- The .pst or .ost file isn't located on a local hard drive. For example, the file is on a removable drive or a network drive.

## Cause

This issue occurs because of a change in the way that Microsoft Outlook 2016 works with file names and paths. That change can make Outlook 2016 unable to add .pst and .ost files from a non-local drive, which was previously successful.

### Change details

Starting with build 16.0.7910.1000, Outlook 2016 makes a specific call to an operating system component to determine the canonical path. With the change, the `GetFinalPathNameByHandle` Windows API returns the normalized path to a file. In the case of a mapped drive, `GetFinalPathNameByHandle` converts the path into the [Universal Naming Convention (UNC)](/openspecs/windows_protocols/ms-dtyp/62e862f4-2a51-452e-8eeb-dc4ff5ee33cc) format. When converting the path, Windows must traverse the entire folder structure of the path to build the final name. If there are insufficient permissions to any folder in the UNC path, `GetFinalPathNameByHandle` will be unable to return a normalized path. As a result, Outlook 2016 can't add any .pst files from this location.

For example, suppose you have mapped to drive P: \\\Server\Share\Restricted\Everyone and you want to add a .pst file from P:\MyData.pst. In this example, you have permissions to the "Everyone" folder in the path, but have no permissions to the "Restricted" or "Share" folder. In this case, Windows is unable to return the normalized path. As a result, Outlook 2016 can't add the .pst file. After an administrator adds List and Read permissions for you to the "Restricted" folder, Windows can traverse the full path and return a normalized path to Outlook. Then you can successfully add the .pst file.

As a reminder, adding .pst files from a network share isn't technically supported in Outlook 2016. While this workaround will allow you to add a .pst file to your profile, you take the risk of any performance or stability problems when you use the .pst file in an unsupported configuration.

## Workaround

To work around this issue, copy the .pst or .ost file to a local hard drive, and then add the file in Outlook 2016.

### What if the .pst or .ost file can't be moved from the non-local drive

You can try to continue to use the file in this unsupported configuration. In that case, you may want to contact the vendor that provides the network storage about potential changes that might allow the storage path to be successfully translated into a final canonical path by Windows.

## References

More information on the [GetFinalPathNameByHandleA function](/windows/win32/api/fileapi/nf-fileapi-getfinalpathnamebyhandlea), which is used by Outlook.
