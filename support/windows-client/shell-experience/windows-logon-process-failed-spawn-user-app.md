---
title: Blank desktop after you log on
description: Discusses an issue where you're presented with a blank screen with no Start Menu, shortcuts, or icons after logging on to a Windows computer.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:desktop-shell, csstroubleshoot
---
# Blank desktop in Windows

This article provides resolutions to an issue where you're presented with a blank screen with no Start Menu, shortcuts, or icons after logging on to a Windows computer.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 970879

## Symptoms

After logging on to a Windows computer, you're presented with a blank screen with no Start Menu, shortcuts, or icons. If you reboot and use F8 to boot to Safe Mode with Networking, you'll see your normal desktop.

You may see the following events in the Application log:

> Log Name: Application  
Source: Microsoft-Windows-Winlogon  
Event ID: 4006  
Level: Warning  
User: N/A  
Computer: M1.Contoso.com  
Description:  
The Windows logon process has failed to spawn a user application. Application name: . Command line parameters: C:\\Windows\\system32\\logon.scr /s.
>
> Log Name: Application  
Source: Microsoft-Windows-Winlogon  
Event ID: 4006  
Level: Warning  
User: N/A  
Computer: M1.Contoso.com  
Description:  
The Windows logon process has failed to spawn a user application. Application name: . Command line parameters: C:\\Windows\\system32\\userinit.exe.

## Cause

This may occur when the membership of the local Users group is changed from the default settings. By default, the local Users group should contain the Interactive account and the Authenticated Users group.

By default, User Account Control (UAC) is enabled. At logon, the standard user access token is built, and if the Users group is missing the default members, the user will be unable to interact with the desktop, resulting in the blank desktop being displayed.

## Resolution

Add the Authenticated Users group and Interactive account to the local Users group.

For both methods below, you'll need to first restart and select F8 at boot to boot to Safe Mode with Networking.

### Method 1

1. Click **Start**, **Run**, type *lusrmgr.msc*, and then press ENTER.
2. Select **Groups** in the left pane.
3. Double-click **Users** in the right pane.
4. Click **Add**, and then click **Locations**. Scroll to the top of the Locations dialog and select the local computer name, then click **OK**.
5. In the Enter the object names to select field, type Interactive; Authenticated Users (separated by a semi-colon). Then click **OK**.
6. Restart the computer.

### Method 2

Run the following commands from a command prompt:

```console
Net localgroup Users Interactive /add
Net localgroup Users "Authenticated Users" /add
```

## More information

When an administrator logs on, the full administrator access token is split into two access tokens: a full administrator access token and a standard user access token.

During the logon process, the administrative privileges and user rights in the full administrator access token are filtered, resulting in the standard user access token. The standard user access token is then used to launch the Explorer.exe process that displays the desktop.

When the local Users group doesn't contain the default members, the standard user access token doesn't have sufficient permissions available to launch Explorer.exe, and only a blank desktop is displayed.

When UAC is turned off, only the full privilege access token is generated for the user and the membership of the local Users group doesn't impact the permissions available in that token.

Windows makes a distinction between the built-in Administrator account and members of the Administrators group. The built-in Administrator account still has full read/write access to the computer and runs with the full administrative access token. UAC administrators are also members of the local Administrators group, but they run with the same access token as standard users.

## Disclaimer

Microsoft and/or its suppliers make no representations or warranties about the suitability, reliability, or accuracy of the information contained in the documents and related graphics published on this website (the materials) for any purpose. The materials may include technical inaccuracies or typographical errors and may be revised at any time without notice.

To the maximum extent permitted by applicable law, Microsoft and/or its suppliers disclaim and exclude all representations, warranties, and conditions whether express, implied, or statutory, including but not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition or quality, merchantability and fitness for a particular purpose, with respect to the materials.
