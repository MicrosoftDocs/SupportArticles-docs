---
title: Stop error 7E on a server that's running NFS
description: Helps to fix the stop error 7E on a server that's running NFS.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# Stop error 7E on a server that's running NFS

This article helps to fix the stop error 7E on a server running NFS.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 4574597

## Symptoms

A Windows Server 2019-based server or a Windows Server 2016-based server that runs the Network File System (NFS) service experiences a Stop error (also known as a bugcheck or blue screen error). The error code is 7E, and the service that originated the error is Nfssvr.sys.

## Resolution

> [!Important]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.  

To fix this problem, the [July 14, 2020 KB 4565511 (build 14393.3808)](https://support.microsoft.com/help/4565511/windows-10-update-kb4565511) includes an update to Nfssvr.sys. Make sure that this update is installed.

### Enable the fix

On computers that run Windows Server 2019, the fix is enabled automatically. No further action is necessary.  

On computers that run Windows Server 2016, the fix is disabled by default. To enable the fix, you have to set a registry entry in addition to installing the binaries. (Windows Server 2019 does not require a registry key change.)  

In Windows Server 2016, you can make this change by using the command line, as follows.

1. On the computer on which you have installed the update, open an administrative Command Prompt window.
2. Run the following command:

    ```cosnole
    reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NfsServer\KBSwitch /v 769E60B7-C2FF-41B0-AD1F-14FC26F6F46B /t REG_DWORD /d 1 /f
    ```

> [!Note]
> You can set this registry entry in Windows Server 2019. However, it is not necessary.

### Disable the fix

In either Windows Server 2019 or Windows Server 2016, you can disable the fix by using either of the following methods:

- Start Registry Editor, locate the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NfsServer\KBSwitch\769E60B7-C2FF-41B0-AD1F-14FC26F6F46B` entry, and then change the value to 0.

- Delete the registry entry. To do this, open an administrative Command Prompt window, and then run the following command:

    ```console
    reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NfsServer\KBSwitch /v 769E60B7-C2FF-41B0-AD1F-14FC26F6F46B /f 
    ```
