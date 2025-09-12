---
title: Troubleshoot SessionHasLoggedOff error code
description: Provides troubleshooting steps for the SessionHasLoggedOff error code that occurs during a desktop flow run in Microsoft Power Automate.
ms.custom: sap:Desktop flows\Power Automate for desktop errors
ms.date: 10/18/2024
ms.author: johndund 
author: johndund
---
# SessionHasLoggedOff occurs during a desktop flow run connected with the cloud

This article provides troubleshooting steps for an issue where you receive the SessionHasLoggedOff error code during a desktop flow run in the cloud environment in Microsoft Power Automate.

## Symptoms

During a desktop flow run in the cloud environment, you receive the `SessionHasLoggedOff` error code with the "The session logged off during run execution" message.

```json
{
    "error":{
        "code": "SessionHasLoggedOff",
        "message": "The session logged off during run execution."
    }    
}
```

## Cause

The error code occurs because the Windows session running your desktop flow is signed out by the system. This issue can occur due to manual user actions or third-party software running on your machine.

## Troubleshooting steps

To investigate the issue, follow these steps:

1. Check custom scripts: Ensure there are no custom scripts (such as batch files or PowerShell scripts) in your desktop flow that might cause the session to sign out or the machine to restart.

1. Verify group policy settings: Check that no group policy settings are configured to sign out from the remote desktop session due to time limits. You can verify these settings by opening the [Local Group Policy Editor](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn789185(v=ws.11)) and navigating to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Session Time Limits**.

1. Note the completion time: Record the time when the desktop flow run completes.

1. Review Windows Event Viewer logs:

   1. Go to the machine that runs the flow and open the Windows Event Viewer.

   1. Navigate to **Application and Service Logs** > **Microsoft** > **Windows** > **TerminalServices-LocalSessionManager** to check the local session manager logs.

   1. Look for logs corresponding to the sign-out time, using the completion time as a reference. Check logs from that time up to several minutes before.

1. Identify the cause:

   - Look for indications of what might cause the session disconnection, such as processes running in session 0 or user actions.
   - If you see an event with **Event ID 40**, it indicates that the session is disconnected with a [reason code](/windows/win32/termserv/extendeddisconnectreasoncode).

1. Check third-party software: If the disconnection is caused by third-party software, check the logs around the timestamp of the disconnection in **Windows Logs** > **Application** to see if the application logged any relevant information.
