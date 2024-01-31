---
title: Memory allocation errors can be caused by slow page file growth
description: Describes an issue that causes memory allocation errors that can be caused by slow page file growth.
ms.date: 12/03/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, davean, eddo, delhan
ms.custom: sap:applications, csstroubleshoot
ms.subservice: performance
---
# Memory allocation errors can be caused by slow page file growth

This article provides a workaround for errors that occur when applications frequently allocate memory.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4055223

## Symptoms

Applications that frequently allocate memory may experience random "out-of-memory" errors. Such errors can result in other errors or unexpected behavior in affected applications.

## Cause

Memory allocation failures can occur due to latencies that are associated with growing the size of a page file to support additional memory requirements in the system. A potential cause of these failures is when the page file size is configured as "automatic." Automatic page-file size starts with a small page file and grows automatically as needed.

The IO system consists of many components, including file system filters, file systems, volume filters, storage filters, and so on. The specific components on a given system can cause variability in page file growth.

## Workaround

To work around this issue, manually configure the size of the page file. To do this, follow these steps:

1. Press the Windows logo key + the Pause/Break key to open **System Properties**.
2. Select **Advanced system settings** and then select **Settings** in the **Performance** section on the **Advanced** tab.
3. Select the **Advanced** tab, and then select **Change** in the **Virtual memory** section.
4. Clear the **Automatically manage paging file size for all drives** check box.
5. Select **Custom size**, and then set the "Initial size" and "Maximum size" values for the paging file. We recommend that you set the initial size to 1.5 times the amount of RAM in the system.
6. Select **OK** to apply the settings, and then restart the system.
If you continue to receive "out-of-memory" error messages, increase the "initial size" of the page file.

## Status

Microsoft has confirmed that this is a problem in Windows 10.

## More information

You might see intermittent build errors like the following if you encounter this problem when using the Microsoft Visual C++ compiler (cl.exe):

- Fatal error C1076: compiler limit: internal heap reached; use /Zm to specify a higher limit
- Fatal error C1083: cannot opentypefile: 'file': message
- Fatal error C1090: PDB API call failed, error code 'code': 'message'
- Compiler error C3859: virtual memory range for PCH exceeded; please recompile with a command line option of '-ZmXXX' or greater

For more information about the Visual C++ compiler errors and how to work around them, see [Precompiled Header (PCH) issues and recommendations](https://devblogs.microsoft.com/cppblog/precompiled-header-pch-issues-and-recommendations/).
