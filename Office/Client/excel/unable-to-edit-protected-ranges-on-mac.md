---
title: Can’t edit certain cells in a protected worksheet using Excel for Mac
description: When the option to let only certain users edit a range of cells has been selected in a protected workbook, you can’t edit those cells in Excel for Mac.
author: v-matham
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: 
- CSSTroubleshoot
- CI 150452
ms.author: v-matham
appliesto:
- Excel for Mac
---

# Can’t edit certain cells in a protected worksheet using Excel for Mac

## Symptoms

If a Microsoft Excel worksheet or workbook has been protected, and the option to let only certain users edit a range of cells has been selected, you can’t edit those cells in Excel for Mac.

## Cause

The option to let only certain users edit a cell range uses Active Directory permissions. This isn’t available in Excel for Mac.

## Resolution

You can edit the cells if you use Excel on a domain-joined Windows device.

If you don’t have access to such a device, you can edit the cells in Excel for Mac if the worksheet or workbook is unprotected. If you are the owner of the file, or you know the password for it, you can unprotect it using the following steps:

1. Select the **Review** tab.
1. Select **Unprotect Sheet** or **Unprotect Workbook**.
1. Enter the password.

## References

- Lock cells to protect them in Excel for Mac
- Lock or unlock specific areas of a protected worksheet
