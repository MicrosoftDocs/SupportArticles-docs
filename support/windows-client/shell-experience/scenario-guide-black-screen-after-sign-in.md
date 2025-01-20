---
title: Black screen after you sign in to the system
description: Explains how to troubleshoot and collect data for the issue of a black screen after you sign in to the system.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, rafern, holgerh, v-lianna
ms.custom: sap:Windows Desktop and Shell Experience\Desktop (Shell, Explorer.exe init, themes, colors, icons, recycle bin), csstroubleshoot
---
# Scenario guide: Black screen after you sign in to the system

This scenario guide explains how to troubleshoot and collect data for an issue where a black screen appears after you sign in to the system.

> [!NOTE]
> This article doesn't cover the following issues:
>
> - A black screen appears right after a boot before you're prompted for credentials.
> - After a few minutes of black screen, you successfully sign in to the system.

You're prompted for credentials to sign in to the system. After you enter the credentials, the system fails to load the user profile and desktop, and a black screen appears (possibly with a visible mouse cursor).

## Reset the graphics driver

Reset the graphics driver by pressing the Windows logo key+<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>B</kbd>. If it doesn't work, proceed to the next steps.

## Check the Shell configuration

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

1. Press the Windows logo key+<kbd>R</kbd>, type *regedit*, and then press <kbd>Enter</kbd> to open the Registry Editor.
2. Navigate to `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon`, check the `Shell` value data in the right pane, and make sure the value data is set to `explorer.exe`.

    > [!NOTE]
    > If the value data isn't `explorer.exe`, [back up the registry](https://support.microsoft.com/help/322756), and then change the value data to `explorer.exe`.

3. Check the permissions of the registry key by right-clicking it and selecting **Permissions**. Make sure the permissions are the same as those on a functioning device.

If the issue persists, [perform a clean boot in Windows](https://support.microsoft.com/topic/how-to-perform-a-clean-boot-in-windows-da2f9573-6eec-00ad-2f8a-a97a1807f3dd) to determine which startup application or service is causing the issue.

## Capture process dumps of explorer.exe and userinit.exe

If the clean boot doesn't allow you to find the cause of the issue, proceed with the following steps to capture data by using ProcDump or Windows Error Reporting (WER), as appropriate.

Use the following steps to check if you can access Task Manager:

1. Press <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>Del</kbd> to enter the security options screen.

    > [!NOTE]
    > If you're on a remote desktop session, use <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>End</kbd>.

2. From the options presented, select **Task Manager**. You might need to use the arrow and <kbd>Enter</kbd> keys if the mouse doesn't work.
3. Once Task Manager is launched, navigate to the **Details** tab to view all running processes and their details.
4. Look for *explorer.exe* and *userinit.exe* in the list.

If *explorer.exe* and *userinit.exe* are running, collect the process dump by using the following steps:

1. Download [ProcDump](/sysinternals/downloads/procdump) and extract the ProcDump files to a known directory, such as *C:\\Tools\\*.
2. Navigate to the directory where ProcDump was extracted in an elevated command prompt.
3. Run the following commands:

    ```console
    procdump -ma explorer.exe explorer.dmp
    procdump -ma userinit.exe userinit.dmp
    ```

4. Proceed to analyze the dump files or contact Microsoft Support to analyze and diagnose the cause of the issue.

If *explorer.exe* and *userinit.exe* aren't running, there could be several reasons, such as:

- The processes stop responding.
- The processes exit.
- The explorer isn't the default shell.

## Check if the processes stop responding

1. Press the Windows logo key+<kbd>R</kbd>, type *eventvwr.msc*, and then press <kbd>Enter</kbd> to open the Event Viewer.
2. Expand the **Windows Logs** section and select the **Application** log.
3. Search specifically for "Event ID 1000," which indicates that an application stops responding. Check if the event is related to *explorer.exe* or *userinit.exe* and matches the timeframe of the issue. If so, proceed with the next step. Otherwise, continue to the [Verify if explorer.exe or userinit.exe has exited](#verify-if-explorerexe-or-userinitexe-has-exited) section.
4. To enable WER using the Registry Editor, follow these steps:

    [!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

    1. Create a new folder (for example, *C:\\dumps*), or use any folder of your choice.
    2. Press the Windows logo key+<kbd>R</kbd> to open the **Run** dialog.
    3. Type *regedit* and press <kbd>Enter</kbd> to open the Registry Editor.
    4. Navigate to the following key:

        `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting`

        > [!NOTE]
        > If the `Windows Error Reporting` key doesn't exist, create it by right-clicking the `Microsoft` key, selecting **New** > **Key**, and then naming it as `Windows Error Reporting`.

    5. Inside the `Windows Error Reporting` key, create the following registry values:

        |Value name  |Value type  |Value data  |
        |---------|---------|---------|
        |`DumpCount`     |`REG_DWORD`         |`10`         |
        |`DumpType`     |`REG_DWORD`         |`2`         |
        |`DumpFolder`     |`REG_EXPAND_SZ`         |`C:\dumps`         |

5. Restart the system or sign in again to reproduce the issue. Once *explorer.exe* or *userinit.exe* stops responding, a process dump should be generated in the path where you chose to save the dump in the previous step.

## Verify if explorer.exe or userinit.exe has exited

Download [Process Monitor (ProcMon)](/sysinternals/downloads/procmon) and extract the ProcMon files to a known directory, such as *C:\\Sysinternals\\*.

For devices that allow only one user session at a time, use Process Monitor to collect the boot log.

1. Run ProcMon and select **Options** > **Enable Boot Logging** from the menu. This operation configures ProcMon to start logging at boot.
2. Restart the system. ProcMon will start logging the boot process automatically.
3. After the system starts, launch ProcMon to stop the boot logging and save the collected data. After launching ProcMon, you'll be prompted to save the file. In this case, select **Yes**. Then, go to **File** > **Save** and select **All events** > **OK** to save the file.

For devices with multiple sessions, regular ProcMon usage is possible.

To set up ProcMon for a scenario where one user is already signed in, and another user tries to sign in to reproduce the issue, follow these steps:

1. Have the first user sign in to the system and start ProcMon by using a command prompt. Navigate to the path where ProcMon was extracted and run it as an administrator.
2. Minimize ProcMon and leave it running in the background. Make sure that the first user doesn't sign out, as this might disrupt the monitoring process.
3. Have the second user sign in to the system to reproduce the black screen issue.
4. Once the issue is reproduced, the first user should return to ProcMon and stop the capture by using the capture icon.
5. In ProcMon, go to **File** > **Save**, and then select **All events** > **OK** to save the captured log file.

After capturing, analyze the log for any instances of *explorer.exe* and *userinit.exe* exiting with a nonzero process exit code. If that is the case, capture a process dump by using these steps:

1. Download [ProcDump](/sysinternals/downloads/procdump) and extract the ProcDump files to a known directory, such as *C:\\Tools\\*.
2. Press the Windows logo key+<kbd>R</kbd> and type *cmd* to open an elevated command prompt.
3. Navigate to the directory where ProcDump was extracted using the `cd` command in the command prompt, and then enter the following command to configure ProcDump to capture a dump when *explorer.exe* exits with an error:

    ```console
    Procdump -e 1 -x C:\Temp explorer.exe
    ```

4. Have a second user sign in to the system to reproduce the black screen issue.
5. After the issue is reproduced, monitor the dump file creation in the *C:\\Temp* directory.
6. Proceed to analyze the dump files or contact Microsoft Support to analyze and diagnose the cause of the issue.
