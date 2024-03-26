---
title: Iexplorer.exe encountered a problem error when viewing timesheet in PWA
description: Describes an error message that you receive when you try view a timesheet in Microsoft Project Web Access in Internet Explorer when you have the Google Toolbar installed on your computer.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: v-dahedm
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Project
ms.date: 03/31/2022
---

# "Iexplorer.exe has encountered a problem and needs to close" error when you try to view a timesheet in Project Web Access

## Symptoms

When you try to view a timesheet in Microsoft Project Web Access, Microsoft Internet Explorer quits, and you receive the following error message:

> Iexplorer.exe has encountered a problem and needs to close

When you click **more information**, you receive the following error message where **x.x.xxxx.xxxx** is the version of Internet Explorer, and **yyyyyyy** is the offset:

> AppName: iexplore.exe  
> AppVer: x.x.xxxx.xxxx  
> ModName: pjgrid.ocx  
> ModVer: 9.0.2000.224  
> Offset: yyyyyyy

## Cause

This problem may occur if the Google Toolbar for Internet Explorer is installed on your computer.

## Workaround

To work around this problem, use one of the following methods.

### Method 1

Remove the Google Toolbar for Internet Explorer. To do this, follow these steps:

1. Click **Start**, click **Control Panel**, and then click **Add or Remove Programs**.   
2. Click **Google Toolbar for Internet Explorer**, and then click **Change/Remove**.   

### Method 2

Disable third-party browser extensions in Internet Explorer. To do this, follow these steps:

1. Start Internet Explorer.   
2. On the **Tools** menu, click **Internet Options**, and then click the **Advanced** tab.   
3. On the **Advanced** tab, click to clear the **Enable third-party browser extensions (requires restart)** check box, and then click **OK**.   

**Note** Both methods require that you restart Internet Explorer.

## More Information

You may not experience this problem with a later version of the Google Toolbar. For more information about the Google Toolbar for Internet Explorer, visit the following Google Web site:

[http://toolbar.google.com](https://toolbar.google.com)

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
