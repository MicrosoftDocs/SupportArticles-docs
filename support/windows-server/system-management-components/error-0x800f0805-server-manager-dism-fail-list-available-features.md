---
title: Error 0x800f0805 when Server Manager and DISM fail to list the available features
description: Helps resolve the issue in which Server Manager and the Deployment Image Servicing and Management (DISM) tool fail to list the available features.
ms.date: 05/09/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, hamansoor, v-lianna
ms.custom: sap:server-manager, csstroubleshoot, ikb2lmc
ms.subservice: system-mgmt-components
---
# Error 0x800f0805 when Server Manager and DISM fail to list the available features 

This article helps resolve the issue in which Server Manager and the Deployment Image Servicing and Management (DISM) tool fail to list the available features.

_Applies to:_ &nbsp; Windows Server  
_Original KB number:_ &nbsp; 5019263

Server Manager fails to list the available features, and you receive the following error message:

> The request to list features available on the specified server failed.

In addition, you receive the following errors by using the DISM tool to list the available features:

- Error 0x800f0805 in an output text file

    > Error: 0x800f0805  
      The specific package is not valid Windows package.

- Error 0x800f0805 in the DISM log file

    ```output
    <Date Time>, Error DISM DISM Package Manager: PID=10396 TID=12656 Failed opening package @Foundation. - CDISMPackageManager::Internal_CreatePackageByName(hr:0x800f0805)
    ```

When you check the registry path `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ComponentBasedServicing\PackageIndex\System` in Registry Editor, the `Microsoft-Windows-Foundation-Package ~31bf3856ad364e35~amd64~~<Image Version>` registry value is missing.

## Manually create the registry value

You can manually create the `Microsoft-Windows-Foundation-Package ~31bf3856ad364e35~amd64~~<Image Version>` registry value under `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ComponentBasedServicing\PackageIndex\System`. For example, `Microsoft-Windows-Foundation-Package~31bf3856ad364e35~amd64~~10.0.14393.0` with the value data `0x00000000`.

> [!NOTE]
> You can switch to a working machine and find the expected `Microsoft-Windows-Foundation-Package ~31bf3856ad364e35~amd64~~<Image Version>` registry value and the value data. For more information about the OS build list, see [Windows 10 release information](/windows/release-health/release-information#windows-10-release-history).
