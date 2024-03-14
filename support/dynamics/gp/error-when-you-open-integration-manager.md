---
title: Error when you open Integration Manager
description: Provides a solution to an error that occurs when you open Integration Manager or when you run an integration in Integration Manager.
ms.reviewer: theley, kvogel
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error message displays when you open Integration Manager or when you run an integration in Integration Manager

This article provides a solution to an error that occurs when you open Integration Manager or when you run an integration in Integration Manager.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 915463

## Symptoms

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](../../windows-server/performance/windows-registry-advanced-users.md)

After you install Integration Manager for Microsoft Dynamics GP or Integration Manager for Microsoft Business Solutions - Great Plains, Automation errors are returned as follows.

- When you run an integration in Integration Manager, you receive one of the following error messages.

    Error message 1  
    > The destination could not be initialized due to the following problem: ActiveX component can't create object

    Error message 2  
    > Automation Error Library not registered.

- When you open Integration Manager, you receive the following error message:
    > Automation Error: The object invoked has been disconnected from its clients.

## Cause

This problem occurs because the installation of Microsoft Dynamics GP or of Microsoft Great Plains wasn't written to the registry correctly.

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft can't guarantee that these problems can be solved. Modify the registry at your own risk.

To resolve this problem, follow these steps:

1. Make sure that you have the following registry subkey:  
    `HKEY_CLASSES_ROOT\CLSID\{6D016639-BA35-11CF-827E-00001B27AB13}\LocalServer32`
    To do it, follow these steps:

    1. Select **Start**, select **Run**, type **regedit**, and then select **OK**.
    2. On the **Edit** menu, select **Find**.
    3. In the **Find What** box, type **6D016639-BA35-11CF-827E-00001B27AB13**.
    4. In the **Look at** section, make sure that only the **Keys** check box is selected, and then select **Find Next**. If you have the registry subkey, you'll see the full path of the Dynamics.exe file in the LocalServer32 folder.
2. If you don't have this registry subkey, the subkey will be created when you re-register the Dynamics.exe file in step 4.

    > [!NOTE]
    > After you re-register the Dynamics.exe file, repeat step 1a through step 1d to verify that the subkey was created by using the correct path.
3. Sign in as the user who is receiving the error message.
4. Re-register the Dynamics.exe file.

    To re-register any .exe file, select **Start**, select **Run**, type "**\<path>\NameOfFile.exe**" /REGSERVER, and then select **OK**.

    > [!NOTE]
    > The placeholder *\<path>* represents the full path of the folder that contains the file, and the placeholder *NameOfFile.exe* represents the name of the file. For example, type the following string:  
    `"C:\Program Files\MyAppLocation\MyApp.exe" /REGSERVER`

    Most executables don't display any message boxes when they're registered. This behavior depends on how the application is created. When some applications are registered, they may open on your computer.
5. Verify the path of the registry subkey again to make sure that the path points to the Dynamics.exe file. To do it, repeat steps 1a through 1d.
6. Try to open Integration Manager or to run the integration. If the Automation errors aren't resolved, you must re-register the following files:

   - IM.exe
   - IMRun.exe

    To re-register these files, follow these steps:
    1. Sign in to the computer as the user who will run the integration.
        > [!NOTE]
        > You must re-register the IM.exe and IMRun.exe files by using this user ID.
    2. Re-register each file by following the procedure that is described in step 4.
