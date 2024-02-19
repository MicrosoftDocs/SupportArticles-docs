---
title: Assign a logon script to a profile
description: Describes how to assign a logon script to a profile for a local user.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-profiles, csstroubleshoot
---
# How to assign a logon script to a profile for a local user

This article describes how to assign a logon script to a profile for a local user.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 324803

## Summary

This article describes how to assign a logon script to a profile for a local user's account in Windows Server 2003. This logon script runs when a local user logs on locally to the computer. This logon script does not run when the user logs on to the domain.

> [!NOTE]
> You must be logged on as Administrator or as a member of the Administrators group to complete this procedure. If your computer is connected to a network, network policy settings may also prevent you from completing this procedure.

## How to assign a logon script to a user's profile

1. Click the **Start**, point to **Administrative Tools**, and then click **Computer Management**.
2. In the console tree, expand **Local Users and Groups**, and then click **Users**.
3. In the right pane, right-click the user account that you want, and then click **Properties**.
4. Click the **Profile** tab.
5. In the **Logon script** box, type the file name (and the relative path, if necessary) of the logon script.

   > [!NOTE]
   > If the logon script is stored in a subfolder of the default logon script path, put the relative path to that folder in front of the file name. For example, if the Startup.bat logon script is stored in \\\\**ComputerName**\\Netlogon\\**FolderName**, type **FolderName**\\Startup.bat .

6. Click **Apply**, and then click **OK**.

   >[!NOTE]
   >
   > - Logon scripts that are stored on the local computer apply only to users who log on to the local computer.  
   > - Local logon scripts must be stored in a shared folder that uses the share name of **Netlogon**, or be stored in subfolders of the Netlogon folder.
   >
   > - The default location for local logon scripts is the Systemroot\\System32\\Repl\\Imports\\Scripts folder. This folder is not created on a new installation of Windows. Therefore, the SystemRoot\\System32\\Repl\\Imports\\Scripts folder must be created and shared out by using the **Netlogon** share name.
   >
   > - If you do not want to create the **Netlogon** share in the default location, put the logon script in any folder that the user can access during logon, and then share this folder.
