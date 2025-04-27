---
title: Nothing happens when using Copy and Paste from Excel to GL
description: Nothing happens when using Copy and Paste from Excel to GL in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Nothing happens when using Copy and Paste from Excel to GL in Microsoft Dynamics GP

This article provides a resolution for the issue that nothing happens when using Copy and Paste from Excel to GL in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3119802

## Cause

This can be caused by:

- The Open XML SDK 2.0 is not installed.
- The Dex.ini has a setting preventing GP from opening the Open XML SDK 2.0.

## Resolution

Review the below troubleshooting tips below to see which method applies:

Method 1 - On your workstation, select the Start (windows) icon in the lower left corner, type in *Programs and Features*. Review the list of installed products to make sure Open XML SDK 2.0 for Microsoft Office is listed. If it is not listed, you will need to install it.

Method 2 - Browse out to your GP code folder (default location is C://Program Files (x86)/Microsoft Dynamics/Data) and right-click on the Dex.ini file and open it with Notepad. Look for the following setting in your Dex.ini and either remove it or set it to **FALSE**. This setting was used with the old COM Object model, and doesn't allow GP to open the Open XML SDK 2.0 that it needs to in order to paste the information from Excel to the journal entry.

```console
UseCOMForExcelExport=TRUE
```

should be:

```console
UseCOMForExcelExport=FALSE
```

## More information

The above information was taken from this blog article:

[GP 2013 R2 - Copy and Paste from Excel to GL – Nothing Happens](https://community.dynamics.com/blogs/post/?postid=025fef3d-71ca-4629-bbb0-c69ef31a7883)
