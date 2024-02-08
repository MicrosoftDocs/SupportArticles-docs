---
title: Terminal Services Application Server mode
description: Describes the issue when you toggle Terminal Services to Application Server mode, some programs may stop working.
ms.date: 09/07/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
ms.subservice: performance
---
# When you toggle Terminal Services to Application Server mode, some programs may stop working

This article describes the issue that some programs may stop working, when you toggle Terminal Services to Application Server mode.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 252330

> [!note]
> This article applies to Windows 2000. Support for Windows 2000 ends on July 13, 2010. The Windows 2000 End-of-Support Solution Center is a starting point for planning your migration strategy from Windows 2000. For more information, see the [Microsoft Support Lifecycle Policy](/lifecycle/).

## Summary

Two methods of toggling the Terminal Services mode have adverse effects on the programs that are running on a Terminal Services server. The first method is by toggling between Remote Administration mode and Application Server mode. The second is by disabling or removing the Terminal Services component. Either method may cause some programs not to start or not to work as designed.

This article discusses Terminal Services modes and describes how to install programs on a server that has the Terminal Server role.

## More information

Plan your environment carefully. After you have chosen to install Terminal Services, you must choose the mode in which Terminal Services will function.

### Terminal Services modes

Remote Administration mode is designed for using the Terminal Services client as an administration tool. It allows you to use a low-bandwidth connection to perform server administration tasks. It does not affect the performance of Microsoft BackOffice applications or services. However, it allows only two connections to a server by using Remote Desktop Protocol (RDP). You can add Terminal Services in Remote Administration mode at any time, but we recommend that you install Terminal Services when you build the server.

Application Server mode is designed for serving end-user programs. If you choose Application Server mode, Terminal Services enables additional objects that are required to manage multiple users running the same programs at the same time. It affects the performance of BackOffice programs or services. There are no connection limitations. However, you must purchase licenses and run the Terminal Services Licensing service to connect to a Terminal Services server. If you are supporting a large number of users in Application Server mode, we recommend that the server is a dedicated Terminal Server that does not perform any additional tasks. Although other services can run at the same time, overall system performance may be affected.

### Changing modes

After you choose your mode of operation, changing or disabling the Terminal Services mode may cause programs not to work as expected. When this problem occurs, you must reinstall the programs.

> [!NOTE]
> If you want to prohibit server access by using RDP, change or remove permissions in RDP-TCP properties, which is located in the Terminal Services Configuration tool.

If you choose to install Terminal Services in Remote Administration mode, no special program installation or configuration work is necessary.

If you choose to install Terminal Services in Application Server mode, installing programs is a little different. Changes to the operating system to enable multiple-user access are made behind the GUI. We recommend that you install the Terminal services role before you install programs that will be available by using Terminal Services. If you install the Terminal Services role after you install a program, the program may not work correctly in a multiple user environment. In this scenario, uninstalling and reinstalling the affected programs can resolve the issue.

You must put a Terminal Services server in Install mode to install or remove programs on the server. You can put a Terminal Services server in Install mode by using the Add/Remove Programs tool in Control Panel or by using the Install Application on the Terminal Server tool in Control Panel.

> [!NOTE]
> The Install application on the Terminal Server tool is available when you install the Terminal Services role. The Install application on the Terminal Server tool switches the Terminal Server server to Execute mode when the installation is complete.

You can also use the `change user` command to switch a Terminal Server server into Install mode. To switch a Terminal Services server into Install mode, follow these steps.

 > [!NOTE]
 > To determine the current mode on the Terminal Server server, run the `change user /query` command at a command prompt.  

1. Click **Start**, and then click **Run**.

2. In the **Open** box, type cmd, and then click **OK**.

3. At the command prompt, type `change user /install`, and then press ENTER. The following message appears:  
User session is ready to install applications.

4. Type exit, and then press ENTER.
5. Add or remove the programs that you want.  

To switch a Terminal Services server into Execute mode, follow these steps:  

1. Click **Start**, and then click **Run**.

2. In the **Open** box, type cmd, and then click **OK**.

3. At the command prompt, type `change user /execute`, and then press ENTER. The following message appears:  
User session is ready to execute applications.

4. Type exit, and then press ENTER.

When you install programs in Install mode, Terminal Services tracks all registry entries, and the HKEY_CURRENT_USER information is primarily written to the following registry key:  
 `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Terminal Server\Install`  

When you finish the program installation, by clicking Finish or by typing `change user /execute`, the system returns to Execute mode. The registry information that was written to the HKEY_CURRENT_USER registry hive during installation is written to the HKEY_CURRENT_USER registry hive for each user when they log on to the Terminal Server.

If you installed a program before you added the Terminal Services role, the system was not "listening" to the registry writes of the installation and the registry entries were not written to the correct user registry keys. Therefore, you must reinstall the program in Install mode for the program work properly.
