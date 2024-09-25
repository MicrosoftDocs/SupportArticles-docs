---
title: WSUS client computers restart automatically without any notification when updates are installed on the client computers
description: Describes the issue in which Windows Server Update Services (WSUS) client computers restart automatically without any notification when updates are installed on the client computers. A resolution is provided.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Software Update Management (SUM)\Unexpected Restarts
---
# WSUS client computers restart automatically without any notification when updates are installed on the client computers

This article provides a solution to an issue in which Windows Server Update Services (WSUS) client computers restart automatically without any notification when updates are installed on the client computers.

_Original product version:_ &nbsp; Windows Server Update Services  
_Original KB number:_ &nbsp; 931265

## Symptoms

Consider the following scenario:

- You use a Microsoft Windows Server Update Services server to deploy updates on WSUS client computers.
- A time deadline is set on the WSUS server for the updates to be installed on the WSUS client computers.
- The updates are installed on the WSUS client computers when the time deadline expires that is set on the WSUS server.

In this scenario, the WSUS client computers restart automatically without any notification even though the WSUS client computers are configured not to restart automatically without a notification.

## Cause

This issue occurs because the updates that are deployed on the WSUS client computers require that Windows Installer 3.1 is present on the WSUS client computers.

If Windows Installer 3.1 is not present on the WSUS client computers, Windows Installer 3.1 is downloaded from the WSUS server and installed on the WSUS client computers, regardless of the WSUS server approval status.

Installation of Windows Installer 3.1 on the WSUS client computers causes the WSUS client computers to restart because a restart is required for Windows Installer 3.1 to function correctly.

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. Make sure that you [back up the registry](https://support.microsoft.com/help/256986) before you modify it. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To resolve this issue, follow these steps on the WSUS client computers:

1. Select **Start**, select **Run**, type `regedit`, and then select **OK**.
2. Locate and then select the following registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU`

3. In the details pane, right-click **NoAutoRebootWithLoggedOnUsers**, and then select **Modify**.
4. Type **1** in the **Value data** box, and then select **OK**.
5. Exit Registry Editor.
6. Restart the WSUS client computers.
