---
title: How to troubleshoot software installations by using Windows application management debug logging
description: Describes how you can troubleshoot software installations by using Windows application management debug logging.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, davidg
ms.custom: sap:deploying-software-through-group-policy, csstroubleshoot
---
# How to troubleshoot software installations by using Windows application management debug logging

This article describes how you can troubleshoot software installations by using Windows application management debug logging.

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base: [256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows registry  

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 249621

## Summary

When a problem occurs with a program that is deployed on a client computer by using Group Policy, a log file (Appmgmt.log) can be generated. This log file records information that is related to the advertisement, publishing, or assignment of Windows Installer applications by using Group Policy. This information, in conjunction with logging from the Windows Installer service, can help determine the cause of a software installation problem.

For more information about how to enable Windows Installer Logging, click the following article number to view the article in the Microsoft Knowledge Base:

[223300](https://support.microsoft.com/help/223300) How to enable Windows Installer Logging  

## More information

To enable diagnostic logging of Group Policy Software Installation processing, modify the registry on the computer where the program will be installed.

To enable diagnostic logging of Group Policy Software Installation processing, follow these steps:

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Click **Start**, click **Run**, type *regedit* in the **Open** box, and then click **OK**.
2. In the left pane, locate and then click the following registry subkey:
    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Diagnostics`
    > [!NOTE]
    > You may have to create the Diagnostics registry subkey.
3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Type *AppMgmtDebugLevel*, and then press Enter.
5. Double-click **AppMgmtDebugLevel**, type *4b* in the **Value data** box, and then click **OK**.
6. Quit Registry Editor.

After you make this registry modification, a log file named Appmgmt.log is created when Group Policy processing occurs. The Appmgmt.log file is located in the %SystemRoot%\\Debug\\UserMode folder on the computer where the AppMgmtDebugLevel registry value is enabled.

> [!Note]
>
> - After you troubleshoot software installations by using Windows application management debug logging, we recommend that you delete the AppMgmtDebugLevel registry value to avoid performance degradation.
> - Because of code changes in application management in Windows 8, debug logging isn't working in Windows 8 or Windows Server 2012.
