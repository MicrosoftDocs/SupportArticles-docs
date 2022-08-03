---
title: Can’t edit certain cells in a protected worksheet using Excel for Mac
description: If editing permissions are restricted on a range of cells in a protected workbook, you can’t edit those cells in Excel for Mac.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 150452
ms.author: luche
appliesto: 
  - Excel for Mac
ms.date: 3/31/2022
---

# Can’t edit certain cells in a protected worksheet in Excel for Mac

## Symptoms

If a Microsoft Excel worksheet or workbook is protected, and the option to restrict editing permissions to certain users is selected for a range of cells, you can’t edit those cells in Excel for Mac.

## Cause

The option to let only certain users edit a cell range uses Active Directory permissions. Excel for Mac doesn't support using Active Directory permissions to unlock ranges of cells.

## Workaround

You can edit the cells if you use Excel on a domain-joined Windows device.

If you don’t have access to such a device, you can edit the cells in Excel for Mac if the worksheet or workbook is unprotected. If you are the owner of the file, or you know the password for it, you can unprotect the file by following these steps:

1. Select the **Review** tab.
1. Select **Unprotect Sheet** or **Unprotect Workbook**.
1. Enter the password.

## References

- [Lock cells to protect them in Excel for Mac](https://support.microsoft.com/office/lock-cells-to-protect-them-in-excel-for-mac-59bb04cf-1a79-4a69-9828-568c98bdb310)
- [Lock or unlock specific areas of a protected worksheet](https://support.microsoft.com/office/lock-or-unlock-specific-areas-of-a-protected-worksheet-75481b72-db8a-4267-8c43-042a5f2cd93a)
