---
title: Application doesn't start in TS RemoteApp session
description: Describes the issue in which you cannot run an application that relies on the Explorer.exe file in a TS RemoteApp session. Two workarounds are offered that use Group Policy settings and changes.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, mghazai
ms.custom: sap:remoteapp-applications, csstroubleshoot
---
# An application does not start in a Windows Server Terminal Services RemoteApp session

This article provides workarounds for an issue where you can't run an application that relies on the Explorer.exe file in a Terminal Services RemoteApp session.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 951048

## Symptoms

Consider the following scenario. You log on to a Windows Server Terminal Services RemoteApp (TS RemoteApp) session. The TS RemoteApp session includes the startup applications and the Run registry entry or the RunOnce registry entry. Then, you try to start an application in the TS RemoteApp session. In this scenario, the application does not start.

## Cause

This issue occurs because you try to start an application that relies on the Explorer.exe file. By design, the TS RemoteApp session implements limited functionality. For example, the TS RemoteApp session does not process the following items:  

- The Run registry entry
- The RunOnce registry entry
- The startup applications

## Workaround

To work around this issue, use one of the following methods.

### Method 1: Run the startup applications as a part of a user's logon settings

To run the startup applications in the TS RemoteApp session, you can specify the startup applications as a part of a user's logon settings in Group Policy. Because Group Policy controls these settings, any startup application that you specify runs as expected when the user logs on.

To specify the startup applications as a part of a user's logon settings, follow these steps:

1. In the server Group Policy Management Console (GPMC), click **Local Computer Policy**, click **Computer Configuration**, and then click **Administrative Templates**.

2. Click **System**, double-click Logon and then double-click **Run these programs at user logon**.

3. In the **Run these programs at user logon Properties** dialog box, click **Enable**.

4. Click **Show**, and then click **Add**.

5. Type the name of the startup application.

    > [!NOTE]
    > Unless the startup application is located in the %SystemRoot% folder, you must specify the fully qualified path of the file.
6. Click **OK**.

### Method 2: Start the Runonce.exe file together with the /AlternateShellStartup switch

Some applications that rely on the Explorer.exe file may run in the TS RemoteApp session if you add the Runonce.exe file to a user's logon script. To do this, follow these steps:

1. In the server GPMC, click **Local Computer Policy**, click **User Configuration**, and then click **Windows Settings**.

2. Click **Scripts (Logon/Logoff)**, and then double-click **Logon**.

3. Click **Add**.

4. In the **Script name** box, type runonce.exe.

5. In the **Script parameters** box, type /AlternateShellStartup.

6. Click **OK** two times.
