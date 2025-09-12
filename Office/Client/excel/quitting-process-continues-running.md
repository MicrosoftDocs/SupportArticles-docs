---
title: Excel process still runs after quitting using a VBA macro programmatically
description: Describes a behavior in which an Excel process continues to run after you programmatically quit Excel.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Extensibility\Macros
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - Office Excel 2007
  - Office Excel 2003
ms.date: 05/26/2025
---

# An active Excel process continues to run after using a VBA macro to programmatically quit Excel

## Symptoms

When you run a Microsoft Visual Basic for Applications (VBA) macro to programmatically exit Microsoft Excel, Excel appears to close as expected. However, an active Excel process continues to run.

This behavior may occur even when your VBA macro performs the following functions:

- Closes all open workbooks
- Calls the Quit method to exit Excel
- Sets the Excel object to "nothing"

## Cause

This behavior may occur if the following conditions are true:

- A COM add-in is installed in Excel.
- The COM add-in assigns an Excel or an Excel member reference to a global object.

For example, this behavior is known to occur when the Google Desktop search tool is installed in Excel. For more information about the Google Desktop search tool, visit the following Google Web site:

[https://desktop.google.com](https://desktop.google.com)

## Workaround

To work around this behavior, remove the COM add-in in Excel. To do this, follow these steps, as appropriate for the version of Excel that you are running.

### Microsoft Office Excel 2007

1. Click the **Microsoft Office Button**, and then click **Excel Options**.
2. Click **Add-Ins**.
3. Click **Excel Add-ins** in the **Manage** box, and then click **Go**.
4. In the **Add-Ins** dialog box, click to clear the check box for the add-ins that are known to cause this behavior.
5. Click **OK**.

### Microsoft Office Excel 2003

1. On the **Tools** menu, click **Add-Ins**.
2. In the **Add-Ins** dialog box, click to clear the check box for the add-ins that are known to cause this behavior.
3. Click **OK**.

## More Information

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
