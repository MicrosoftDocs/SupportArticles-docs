---
title: Use WinRE to troubleshoot startup issues
description: This article discusses how to use Windows Recovery Environment (WinRE) to troubleshoot common startup issues.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:System Performance\Startup or Pre-logon Reliability (crash, errors, bug check or Blue Screen), csstroubleshoot
---
# Use Windows Recovery Environment (WinRE) to troubleshoot common startup issues

This article describes how to start WinRE from Windows installation media to troubleshoot common startup issues.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4026030

## Summary

When a Windows operating system fails to start or restarts unexpectedly, the [Windows Recovery Environment](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference) (WinRE) can be used to run commands that may resolve the issues. The system may be unable to start because of disk corruption, corrupted or missing system files, or pending actions from the installation of an update.  

## Start WinRE from Windows installation media

> [!NOTE]
> For additional methods to start WinRE, see [Entry points into WinRE](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference#entry-points-into-winre).

1. Start the system to the installation media for the installed version of Windows. For more information, see [Create installation media for Windows](https://support.microsoft.com/help/15088).
2. On the **Install Windows** screen, select **Next** > **Repair your computer**.
3. On the **System Recovery Options** screen, select **Next** > **Command Prompt**.
4. At the command prompt, run the following command by using [BCDEdit command-line options](/windows-hardware/manufacture/desktop/bcdedit-command-line-options) to identify the drive letter of the system volume:

    ```console
    BCDEdit
    ```

    In the **Windows Boot Loader** section, the drive letter of the system volume is displayed next to `osdevice`. (For example, D:)

5. At the command prompt, run the following command to complete a [check disk](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc730714(v=ws.11)) for the system volume that's identified in step 4:

    ```console
    CHKDSK /f D:
    ```

    > [!NOTE]
    > If any failures or unrepairable issues are listed in the results, you may have to investigate these further.

6. At the command prompt, run the following command to complete a [System File Check](/windows/win32/wfp/system-file-checker) (SFC) for the system volume that's identified in step 4:

    ```console
    SFC /scannow /offbootdir=D:\ /offwindir=D:\windows
    ```

    > [!NOTE]
    > If any failures or unrepairable issues are listed in the results, you may have to investigate these further.

7. At the command prompt, run the following command to complete an image cleanup and health restoration by using the [DISM](/windows-hardware/manufacture/desktop/repair-a-windows-image) tool:

    ```console
    DISM /image:D:\ /cleanup-image /restorehealth
    ```

    > [!NOTE]
    >
    > - If any issue is found and fixed, repeat step 6.
    > - The DISM command only applies to Windows Server 2012 and later versions.

8. At the command prompt, run the following command to revert any pending actions by using the DISM tool.

    > [!NOTE]
    > If the pending actions can't be reverted, you may have to investigate these further.

9. Close the **Command Prompt** window, and then select **Reboot**.

## References

- [Create installation media for Windows](https://support.microsoft.com/help/15088/windows-create-installation-media)

- [BCDEdit Command-Line Options](/previous-versions/windows/it-pro/windows-vista/cc709667(v=ws.10))

- [Chkdsk command line reference](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc730714(v=ws.11))

- [System File Checker](/windows/win32/wfp/system-file-checker)

- [Repair a Windows Image](/previous-versions/windows/it-pro/windows-8.1-and-8/hh824869(v=win.10))
