---
title: Create a user-defined service
description: Describes how to create a Windows NT user-defined service.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# Create a user-defined service

This article provides the steps to create a Windows NT user-defined service.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 137890

> [!IMPORTANT]
> This article contains information about editing the registry. Before you edit the registry, make sure you understand how to restore it if a problem occurs. For information on how to do this, view the **Restoring the Registry** or the **Restoring a Registry Key** online Help topics in Registry Editor.

## Summary

The Windows NT Resource Kit provides two utilities that allow you to create a Windows NT user-defined service for Windows NT applications and some 16-bit applications, but not for batch files.

Instrsrv.exe installs and removes system services from Windows NT and Srvany.exe allows any Windows NT application to run as a service.

## Steps to create a user-defined service

To create a Windows NT user-defined service, follow these steps:

1. At an MS-DOS command prompt(running CMD.EXE), type the following command:

    ```console
    path \INSTSRV.EXE My Service path \SRVANY.EXE
    ```

    where **path** is the drive and directory of the Windows NT Resource Kit (for example, `C:\RESKIT`) and **My Service** is the name of the service you're creating.

    Example: `C:\Program Files\Resource Kit\Instsrv.exe Notepad C:\Program Files\Resource Kit\Srvany.exe`

    > [!NOTE]
    > To verify that the service was created correctly, check the registry to verify that the **ImagePath** value under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\service name` is set to point to SRVANY.EXE. If this is not set correctly, the service will stop shortly after it starts and return an Event ID 7000 (The **service name** failed to start).

    > [!WARNING]
    > Using Registry Editor incorrectly can cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that problems resulting from the incorrect use of Registry Editor can be solved. Use Registry Editor at your own risk.

    For information about how to edit the registry, view the following online Help topics in Registry Editor:

    - **Changing Keys And Values**
    - **Add and Delete Information in the Registry**
    - **Edit Registry Data**

    > [!NOTE]
    > You should back up the registry before you edit it.

2. Run Registry Editor (Regedt32.exe) and locate the following subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\<My Service>`

3. From the **Edit** menu, select **Add Key**. Type the following entries, and select **OK**:

    - Key Name: **Parameters**
    - Class: \<leave blank>

4. Select the **Parameters** key.
5. From the **Edit** menu, select **Add Value**. Type the following entries, and select **OK**:

    - Value Name: **Application**
    - Data Type: REG_SZ
    - String: \<path>\\<application.ext>

    where \<path>\\<application.ext> is the drive and full path to the application executable including the extension (for example, C:\WinNT\Notepad.exe)

6. Close Registry Editor.

By default, a newly created service is configured to run automatically when the system is restarted. To change this setting to **Manual**, run the Services applet from Control Panel. Then change the **Startup** value to **Manual**. A service set to **Manual** can be started in one of several ways:

- From the Services applet in Control Panel

- From an MS-DOS command prompt, type the following command:

    ```console
    NET START <My Service>
    ```

- Use the Sc.exe utility from the Resource Kit. Type the following command from an MS-DOS command prompt:

    ```console
    <path>\Sc.exe start <My Service>
    ```

    where \<path> is the drive and directory of the Windows NT Resource Kit (for example, `C:\Reskit`).

For more information on installing and removing a user-defined service, see the Srvany.wri document provided with the Windows NT Resource Kit utilities (for example, `C:\Reskit\Srvany.wri`). This document can also be found on the Windows NT Resource Kit CD in the `Common\Config` directory.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
