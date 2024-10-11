---
title: Troubleshoot SessionHasLoggedOff error code
description: Provides troubleshooting steps for the SessionHasLoggedOff error code that occurs during a desktop flow run in Microsoft Power Automate.
ms.custom: sap:Desktop flows\Power Automate for desktop errors
ms.date: 10/11/2024
ms.author: johndund 
author: johndund
---
# SessionHasLoggedOff occurs during a desktop flow run connected with the cloud

This article provides troubleshooting steps for an issue where you receive the SessionHasLoggedOff error code during a desktop flow run in the cloud environment in Microsoft Power Automate.

## Symptoms

During a desktop flow run, you receive the SessionHasLoggedOff error code with the "The session logged off during run execution" message.

## Cause

The error code means that the Windows session that runs your desktop flow is signed off by the system. This issue occurs due to a manual user action or a third-party software running on your machine.

## Troubleshooting steps

To investigate the issue, follow these steps:

1. Verify that there's no custom script (such as a batch file or any PowerShell script execution) in your desktop flow. A custom script might cause the session to be signed off or the machine to restart.

1. Verify that no group policy settings sign out from the remote desktop session due to time limits. You can verify the settings by opening the [Local Group Policy Editor](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn789185(v=ws.11)) and navigating to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Session Time Limits**.

1. Note the time of when the desktop flow run completes.

1. Go to the machine that runs the flow and open the Windows Event Viewer.

1. In the Windows Event Viewer, select **Application and Service Logs** > **Microsoft** > **Windows** > **TerminalServices-LocalSessionManager** to check the local session manager logs. Try to find the log corresponding to the time when the sign out occurs by using the time when the run completes and looking at the logs at that time up to many minutes before.

1. Look for indications of what might cause the disconnection of the session, including whether the disconnection occurs due to a process running in session 0, or a user.

   If you see an event with **Event ID 40**, it describes that the session is disconnected with a [reason code](/windows/win32/termserv/extendeddisconnectreasoncode).

   If the disconnection is caused by a third-party software, you can also check the logs around the timestamp when the disconnection occurs in **Windows Logs** > **Application** to see if the application might log something.
