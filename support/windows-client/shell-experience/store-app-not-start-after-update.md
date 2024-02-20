---
title: Microsoft Store app cannot open when one user installs an older version than the current version installed by another user
description: Address an issue in which Windows 10 Apps won't open after update. This issue occurs when the App is used by multiple users.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:modern-inbox-and-microsoft-store-apps, csstroubleshoot
---
# Microsoft Store app cannot start when one user installs an older version than the current version installed by another user in Windows 10

This article provides help to fix an issue where Microsoft Store app cannot start when one user installs an older version than the current version installed by another user.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4055744

## Symptom

Consider the following scenario:

- On a Windows 10-based computer, you sign in as User A and then install a Microsoft Store app. For example, Minecraft: Education Edition, installed by System Center Configuration Manager as an offline app.
- You update the app to a newer version online from the Microsoft Store, and then sign out as User A.
- You sign in as User B and then install the older version of the app.

In this scenario, you cannot use the app when you sign in as User A. Additionally, when you sign in as User B, you cannot update the app.

This issue can occur when you use System Center Configuration Manager to deploy the older version of an offline app and then the user updates the app online from the Microsoft Store. You will see error 0x3 in the Configuration Manager console when [monitoring application status](/sccm/apps/deploy-use/monitor-applications-from-the-console).

## Cause

This issue is caused when User B installs the older version of the app and the installation replaces shared files with older versions.

## Workaround

The following steps can fix this issue for users on a specific computer:

1. Confirm that the activationStore.dat file does not exist in the AppRepository directory. For example: `C:\ProgramData\Microsoft\Windows\AppRepository\Packages\Microsoft.MinecraftEducationEdition_0.21.0_x64__8wekyb3d8bbwe\ActivationStore.dat`

2. Run the following command to set the registry key for the specific application. For example, Minecraft (Microsoft.MinecraftEducationEdition_1.0.21.0_x64__8wekyb3d8bbwe):

    ```console
    reg add HKLM\Software\Microsoft\Windows\CurrentVersion\AppModel\StateChange\PackageList\Microsoft.MinecraftEducationEdition_1.0.21.0_x64__8wekyb3d8bbwe /v PackageStatus /t REG_DWORD /d 2
    ```

3. Copy the application.appx file to a local folder, for example: C:\Temp\Microsoft.MinecraftEducationEdition_1.0.21.0_x64__8wekyb3d8bbwe.appx.

4. Set the following command to redeploy the app to run each time that a user signs in. For example, Minecraft (Microsoft.MinecraftEducationEdition_1.0.21.0_x64__8wekyb3d8bbwe):

    ```powershell
    powershell.exe Add-AppxPackage -Path C:\Temp\Microsoft.MinecraftEducationEdition_1.0.21.0_x64__8wekyb3d8bbwe.appx
    ```

    > [!NOTE]
    > If you are using Configuration Manager, do not deploy the app package as a Configuration Manager application.

## Resolution

If you are using Configuration Manager, see [Manage apps from the Microsoft Store for Business with System Center Configuration Manager](/sccm/apps/deploy-use/manage-apps-from-the-windows-store-for-business#next-steps) to help choose between online or offline app updates.

This issue will not occur in Windows 10 version 1709 and will be fixed for previous versions in an upcoming quality update.
