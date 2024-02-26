---
title: Command-line switches for Microsoft software update packages
description: Describes the consistent set of command-line switches that Microsoft is adopting for deploying packages that contain software updates.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: eriprice, kaushika
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Command-line switches for Microsoft software update packages

This article describes the consistent set of command-line switches that Microsoft is adopting for deploying packages that contain software updates.

_Applies to:_ &nbsp; Windows 10 – all editions  
_Original KB number:_ &nbsp; 824687

## Summary

Microsoft is adopting a consistent set of command-line switches that you can use to deploy packages that contain software updates, such as security updates, critical updates, and hotfixes. This article describes these new command-line switches and their behaviors.

> [!NOTE]
> Packages that support these new command-line switches also support earlier command-line switches for backwards compatibility. However, usage of the earlier switches should be discontinued as this support may be removed in future software updates.

For additional information about command-line switches that are used by Windows software update packages, click the following article number to view the article in the Microsoft Knowledge Base:

[262841](https://support.microsoft.com/help/262841) Command-line switches for Windows software update packages  

For additional information about command-line switches used by Windows Installer, visit the following Microsoft Web site:

[Command-Line Options](/windows/win32/msi/command-line-options)  

## More information

Microsoft is adopting the following command-line switches for software update packages:

- /help; /h; /? - Displays a dialog box that shows the correct usage of the Setup command, including a list of all its command-line switches and their behaviors. You can display this help information in the command-line interface (CLI) or the graphical user interface (GUI). If you use any command-line switch incorrectly, this help switch is invoked and the correct usage is displayed. The dialog box also provides references to more online information.
- /quiet - Runs the Setup program or the removal program in "quiet" mode. The program doesn't prompt the user with any messages. The program enters all messages in a log file. By default, the program restarts the computer with no prompt or warning if the process requires a restart for the changes to take effect. To change the default restart behavior, use a different restart mode.
- /passive - Runs the Setup program or the removal program in "passive" mode. The program doesn't prompt the user with any error messages. The user sees a progress bar that indicates that the installation or the removal is occurring. The user can't cancel the installation or the removal. By default, the program invokes the /warnrestart switch. If the program is installing multiple updates, the progress bar indicates the progress of the installation or the removal for each update.
- /norestart - Doesn't restart the computer after the installation or the removal, even if the process requires a restart for the changes to take effect.
- /forcerestart - Restarts the computer after the installation or the removal, even if the process doesn't require a restart for the changes to take effect. Restarting forces programs that are running to close.
- /warnrestart[:**x** ] - Invokes a dialog box that warns the user that a restart will occur in **x** seconds (in 30 seconds if no value is specified). For example, to warn that a restart will occur in 60 seconds, type /warnrestart:60. The dialog box contains a **Cancel** button and a **Restart Now** button. If the user clicks **Cancel**, the computer isn't restarted.
- /promptrestart - Prompts the user that the computer must be restarted for the changes to take effect. The user can select whether to restart the computer.

- /uninstall - Removes the package.
- /log - Enables the user to define the path for the local log file. This switch invokes the default logging behavior.
- /extract - Enables you to extract the installation files to a specified folder.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
