---
title: Access error Your network access was interrupted when using a mapped drive
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
ms.date: 05/26/2025
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Access
ms.custom: 
  - CI 107826
  - CSSTroubleshoot
ms.reviewer: denniwil
description: Describes how to resolve an error where the connection is dropped when opening Access from a mapped drive.
---

# Access error "Your network access was interrupted" when using a mapped drive

## Symptoms

When opening Access from a mapped drive, using linked tables mapped to a drive, or executing VBA code based on mapped drive locations, you get the following error:

> Your network access was interrupted. To continue, close the database, and then open it again.

:::image type="content" source="media/your-network-access-was-interrupted-error/error-message.png" alt-text="Screenshot of the error message after opening Access from a mapped drive." border="false":::

## Cause

Access requires a fast and stable network connection when opening databases over a local area network. There are two common causes using mapped drives which may result in an interruption to the network connection:

- A group policy that maintains the mapped drive is using Replace instead of Update. This results in the mapped drive being disconnected and reconnected during each group policy refresh interval.
- The mapped drive detects an idle period resulting in the drive performing an auto disconnect.

## Resolution

Review the mapped drive preferences within the Group Policy Management Console. If the GPO is set to Replace, change the GPO to Update.

[Configure a Mapped Drive Item](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770902(v=ws.11)?redirectedfrom=MSDN)

See the following article to prevent mapped drives from performing an auto disconnect:

[Mapped Drive Connection to Network Share May Be Lost](https://support.microsoft.com//help/297684)

## More information

You may also consider using a UNC path to specify the database location on a network instead of using mapped drives within Access as the UNC path is unaffected by mapped drive policies. A UNC path uses the server name instead of the mapped drive letter. Sample UNC path: `\\ServerName\FolderName\FileName.accdb`.
