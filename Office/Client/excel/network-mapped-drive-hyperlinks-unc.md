---
title: Network Mapped Drive Hyperlinks resolve as UNC in Office Products
description: Fixes an issue that occurs after a user inserts a hyperlink to a file residing on a network mapped drive within an Office product.
author: Cloud-Writer
ms.author: meerak
ms.reviewer: akeeler, v-lisalozano
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Open\Links
  - CSSTroubleshoot
  - CI 164509
  - CI 10891
search.appverid: 
  - MET150
appliesto:
  - Microsoft 365 
  - Microsoft Excel 2024 
  - Microsoft Excel 2021 
  - Microsoft Excel 2016 
  - Microsoft Outlook 2016
  - Microsoft Word 2016
ms.date: 03/31/2026
---

# Network Mapped Drive Hyperlinks resolve as UNC in Office Products

## Symptoms

After a user inserts a hyperlink to a file residing on a network mapped drive within an Office product, the hyperlink's text displays the network mapped drive path, however the link is resolved as the UNC path.

For example, in Excel if you go to Insert, and then click on Hyperlink the user is prompted to select the file. If the user navigates to a file residing on a Network Mapped Drive, and inserts a hyperlink to that file, the hyperlink is created to the file via its UNC path instead of its network mapped drive path. After the link has been inserted, the user can then hover over the link and see that the full UNC path has been used when creating the link to the file.

## Cause

The cause is due to the way Office creates hyperlinks to files. Office products create links to files using the UNC path and won't use the network mapped drive location, even if it displays it in the hyperlink text.

## Resolution

There's no resolution for this. Microsoft recommends that users insert hyperlinks using the UNC path to prevent confusion in cases where opening a file via UNC or network mapped drive might make a difference in the expected behavior in the file.

## More Information

An example of where how a file is opened can be found listed in the following article under the section "Scenarios that may cause links to not work as expected."

[Description of link management and storage in Excel](https://support.microsoft.com/topic/description-of-link-management-and-storage-in-excel-46628e8d-2cd6-db5f-3474-f8d7144b09d6)
