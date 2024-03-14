---
title: Excel 2016 for Mac crashes
description: Assists customers who are migrating from Office for Mac 32-bit to 64-bit after they experience a crash issue while using 32-bit  ODBC drivers.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: lauraho
appliesto: 
  - Excel for Mac for Microsoft 365
ms.date: 03/31/2022
---

# Excel 2016 for Mac crashes when you click the From Database option

## Symptoms

Excel 2016 for Mac crashes when you click **Data** > **New Database Query** > **From Database**.

## Cause

This issue occurs if you 're running Excel 2016 for Mac version 15.25 or later, and you have an older 32-bit ODBC driver installed on your Mac.

## Resolution

To resolve this issue, remove the 32-bit driver, and then install a new 64-bit driver. For information about how to remove and install the drivers, contact the driver manufacturer or supplier.

## More Information

In September 2015, Excel 2016 for Mac was originally released as 32-bit software. However, in August 2016, the software was updated to 64-bit. To check whether you have this update, click **About Excel** on the **Excel** menu. If you have version 15.25 or later, you have the 64-bit version.

If you have the 64-bit version and an older 32-bit ODBC driver, this may cause Excel to crash. To prevent this issue, install a 64-bit driver from the provider or from the company's website. Some of the most common drivers are provided by Openlink Software and Actual Technologies.

To determine whether your driver is 32-bit or 64-bit, follow these steps:

1. Go to the Finder.
2. Click Go > Utilities, and then double-click System Information.
3. On the left side, scroll down, and then click Applications.
4. Scroll through the list of applications to find the name of your driver.
5. Click the driver, and then look in the 64-bit column.

For more information about compatible ODBC drivers, see [ODBC drivers that are compatible with Excel for Mac](https://support.office.com/article/odbc-drivers-that-are-compatible-with-excel-for-mac-9fa6bc7f-d19e-4f7f-9be4-92e85c77d712?ui=en-us&rs=en-us&ad=us).

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]
