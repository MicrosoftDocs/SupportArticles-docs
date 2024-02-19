---
title: Connect to console session with Terminal Services
description: Describes how to use Windows Server 2003 Terminal Services to connect to and shadow a console session.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, CWEST
ms.custom: sap:connecting-to-a-session-or-desktop, csstroubleshoot
---
# Connect to and shadow the console session with Windows Server 2003 Terminal Services

This article describes how to use Microsoft Windows Server 2003 Terminal Services to connect to and shadow a console session.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 278845

## Summary

In Windows Server 2003, when you use Terminal Services, you can connect to the console session (session 0), and at the same time, open a shadow session to it (as long as you connect from a session other than the console). With this added functionality, you can log on to a Windows Server 2003-based server that is running Terminal Services remotely and interact with session 0 as if you were sitting at the physical console of the computer. This session can also be shadowed so that the remote user and the local user at the physical console can see and interact with the same session.

## Connect to the console session

When you connect to the console session of a Windows Server 2003-based server, no other user has to be already logged on to the console session. Even if no one is logged on to the console, you are logged on just as if you were sitting at the physical console.

To connect from the remote Windows Server 2003-based computer, open a command prompt, and then type the following command:

```console
mstsc -v: servername /F -console
```

Where mstsc is the Remote Desktop connection executable file, `-v` indicates a server to connect to, `/F` indicates full screen mode, and `-console` is the instruction to connect to the console session.

When you use this command, you open the Remote Desktop session, and when the logon is authenticated, you are connected to the console session that is running on the Windows Server 2003-based server. If a user is currently working on the console session at the computer, you receive the following error message:

> The user **domain** \ **username** is logged locally on to this computer. The user has been idled for
 **number** minutes. The desktop is unlocked. If you continue, this user's session will end and any unsaved data will be lost. Do you want to continue?

The user of the current console session is then logged off, and you receive a message that states that the computer is currently locked and only an administrator can unlock it.

> [!NOTE]
> If the console session user and the Terminal Services session user are the same, you can connect without any problems.

## Shadow the console session

To shadow the console session, first open a Remote Desktop connection to the Windows Server 2003-based server from another computer. By default, the Windows Server 2003 Remote Desktop Connection utility is installed in all versions of Windows Server 2003. You can either use this or the Mstsc command-line utility that is described in the [Connect to the console session](#connect-to-the-console-session) section, but omit the `-console` switch. After you open this session, start a command prompt in the session and type the following command to start the shadow session to the console:

```console
shadow 0
```

After you enter and send this command, you receive the following message:

> Your session may appear frozen while the remote control approval is being negotiated. Please wait...

In the console session on the server, you receive the following message:

> **domain** \ **username** is requesting to control your session remotely.  
Do you accept the request?

If the user of the console session on the server clicks **YES**, you are automatically connected to the console session on the remote Windows Server 2003-based server. If the user on the server's console clicks **NO** or does not respond, you receive the following error message at the command prompt on the remote computer:

> Remote control failed. Error code 7044  
Error [7044]:The request to control another session remotely was denied.

To disconnect the shadow session from the remote side, press CTRL + * (on the numeric keypad), and you are returned to the original session that you established to the Windows Server 2003-based server.

If you are logged on to the console of the server that is running Terminal Services, if you try to shadow another user's session from the console of the computer, you receive the following error message:

> Your session may appear frozen while the remote control approval is being negotiated. Please wait...  
Remote Control Failed. Error Code 7050.  
Error [7050]:The requested session cannot be controlled remotely.  
This may be because the session is disconnected or does not have a user logged on. Also, you cannot control a session remotely from the system console and you cannot remote control your own current session.

If the Windows Server 2003-based server is not configured to permit remote control, you receive the following error message:

> Remote control failed. Error code 7051  
Error [7051]: The requested session is not configured to allow Remote Control.

To configure the Windows Server 2003-based server to permit remote control, follow these steps:

1. Open the Group Policy snap-in (Gpedit.msc).
2. In the left pane, under the **Computer Configuration** branch, expand the **Administrative Templates** branch.
3. Expand the **Windows Components** branch.
4. Click the **Terminal Services** folder.
5. In the right pane, double-click **Sets rules for remote control of Terminal Services user sessions**.
6. On the **Setting** tab, click **Enabled**.
7. In the **Options** box, click **Full Control with users' permission**, and then click **OK**.
