---
title: 0x8007000D ERROR_INVALID_DATA error after installing Windows updates
description: Helps resolve the 0x8007000D ERROR_INVALID_DATA error at system startup after installing Windows updates.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, hamansoor, v-lianna
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
---
# 0x8007000D ERROR_INVALID_DATA error at startup after installing updates

This article helps resolve an issue in which you receive the "0x8007000D ERROR_INVALID_DATA" error at the system startup after installing Windows updates.

After you install an update and restart the system, the system performs a rollback at the system startup, and you receive the "0x8007000D ERROR_INVALID_DATA" error.

This issue occurs because the database of performance counters is corrupted.

## Rebuild the performance counter setting

To resolve this issue, follow these steps:

1. Open an elevated Windows PowerShell prompt, and then navigate to the *C:\\windows\\system32\\wbem* folder by running the following cmdlet:

    ```PowerShell
    cd C:\Windows\system32\wbem
    ```

2. Run the following [wmiadap](/windows/win32/wmisdk/wmiadap) cmdlet to parse all the performance libraries:

    ```powershell
    C:\Windows\system32\wbem>wmiadap.exe /f
    ```

3. Run the following [lodctr](/windows-server/administration/windows-commands/lodctr) cmdlet to rebuild the performance counter setting:

    ```powershell
    C:\Windows\system32\wbem>lodctr /r 
    ```

    Then, you receive the following message if the cmdlet runs successfully:

    ```output 
    Successfully rebuilt performance counter setting from system backup store 
    ```

4. Install the update again.
