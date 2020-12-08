---
title: Issues when Windows 10 calls CreateWindowEx for some 32-bit applications
description: Describes an issue in which Windows 10 causes some 32-bit applications to crash. Provides a workaround.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: memarti, chmorri, kaushika, delhan
---
# Windows 10 causes issues when it calls CreateWindowEx in some 32-bit applications

_Original product version:_ &nbsp; Windows 10, version 1803, all editions, Windows 10, version 1709, all editions  
_Original KB number:_ &nbsp; 4054150

## Symptoms

In some cases, the Windows 10 causes crashes or other issues when it calls the **CreateWindowEx**  function in some 32-bit applications. We are aware of issues that affect some Microsoft Visual Studio extensions and the Bloomberg Professional service.
To determine whether your system is running Windows 10 Fall Creators Update (Version 1709, build 16299.19 or 16299.15), select **Start**, select **Settings**, select **System**, select **About**, and then look under **Windows specifications**  for the Windows version information.

## Workaround

To work around this issue, roll back your Windows 10 installation to the previous version.
The roll back option is available for 10 days after you've upgraded your Windows 10 installation. To roll back, select **Start**, select **Settings**, select **Update & Security**, and then select **Recovery**. This keeps your personal files, but removes applications and drivers that were installed after the upgrade, and also reverses any changes that you made to settings.
If the roll back option isn't available, please contact your IT support or helpdesk for help to restore the computer to the previous Window 10 version.
 We recommend that you make a backup of your personal files before you contact your IT support, helpdesk, or [Microsoft Support](https://support.microsoft.com/contactus/?ws=support).

## Status

Microsoft is working on a resolution and will provide an update in an upcoming release.

## References  

Third-party information disclaimer 

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
