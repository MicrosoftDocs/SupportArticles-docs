---
title: RemoteApp sessions are disconnected
description: Resolves an issue where RemoteApp sessions are disconnected when all RemoteApp windows and user-launched notification area icons are closed.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remoteapp-applications, csstroubleshoot
---
# RemoteApp sessions are disconnected when all RemoteApp windows and user-launched notification area icons are closed

This article provides help to solve an issue where RemoteApp sessions are disconnected when all RemoteApp windows and user-launched notification area icons are closed.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2345390

## Summary

When a user launches a Remote Desktop Services or Terminal Services RemoteApp, a Remote Desktop session is created in which the application runs. Any subsequent RemoteApps that are launched from the same client before the session is logged off will run in the same session. Additionally, any notification area (system tray) icons that are launched by the user will also run in the same session.

When all active application windows and all user-launched notification area icons are closed, the session remains active for 20 more seconds. This allows time for the user to launch another application, and for applications to display final messages or perform other closing tasks. If another application or system tray icon isn't launched within that time, the RDP session is disconnected.

## More information

Leaving the session in a disconnected state allows subsequent RemoteApps to launch much more quickly. When a new RemoteApp is launched the session is reconnected instead of incurring the overhead of starting a new one.

By default disconnected RemoteApp sessions will remain in a disconnected state indefinitely. This behavior can be modified by a new Group Policy setting introduced in Windows Server 2008, **Set time limit for logoff of RemoteApp sessions**. This setting is located in Group Policy under both Computer Configuration and User Configuration:

- Computer Configuration\Administrative Templates\Windows Components\Remote Desktop Services\Remote Desktop Session Host\Session Time Limits
- User Configuration\Administrative Templates\Windows Components\Remote Desktop Services\Remote Desktop Session Host\Session Time Limits

To enable and configure the policy setting:

1. Log on to the terminal server as an administrator.
2. Start the Local Group Policy Editor. To do this, click **Start**, click **Run**, type *gpedit.msc*, and then click **OK**.
3. Locate the appropriate node under Computer Configuration or User Configuration as shown above.
4. In the right pane of the Local Group Policy Editor, double-click **Set time limit for logoff of RemoteApp sessions**.
5. Click **Enabled**.
6. In the RemoteApp session logoff delay list, select the desired time for logoff delay, and then click OK.
7. At a command prompt, type *gpupdate* and press ENTER to force the policy to refresh immediately on the local computer.

After the policy setting is enabled, disconnected RemoteApp sessions will be logged off after the configured time delay. If other settings that control logging off disconnected Remote Desktop or Terminal Services sessions (not just RemoteApp sessions) conflict with the above setting, then the policy configured for the shortest time period will take effect. For example, if the **Set time limit for disconnected sessions** policy setting is configured for a shorter time period than **Set time limit for logoff of RemoteApp sessions**, the former will take effect.

## Reference

For more information, see [Policy CSP - ADMX_TerminalServer](/windows/client-management/mdm/policy-csp-admx-terminalserver).
