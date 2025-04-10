---
title: Scheduled Tasks Fail with Error Task Schedular Service Is Not Available
description: Helps resolve the error Task schedular service is not available in which scheduled tasks fail.
manager: dcscontentpm
ms.date: 04/10/2025
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom:
- sap:system management components\task scheduler
- pcy:WinComm User Experience
---
# Scheduled tasks fail with error "Task schedular service is not available"

This article helps resolve the issue in which your scheduled tasks fail to run with error "Task schedular service is not available."

Some of your scheduled tasks fail to run. When you open Task Scheduler to investigate the failure, you receive the following error message:

> Task schedular service is not available. Task Scheduler will attempt to reconnect to it.

This issue is caused by the following reasons:

- Incorrect scheduled task configurations.
- Scheduled task target application or script is no longer available or valid.
- Incompatible scheduled tasks after recent operating system (OS) upgrade.

Use the following steps to resolve the issue:

1. Clean up `at` tasks if they exist.
2. Delete corrupted tasks and then create them again if needed.

## Step 1: Clean up at tasks if they exist

> [!NOTE]
> [At](/windows-server/administration/windows-commands/at) tasks refer to tasks scheduled to run automatically by the OS using the `at` command. It's a legacy command in Windows for scheduling tasks at specified time and date. These tasks are managed by the Task Scheduler service. After an OS upgrade, such tasks might fail due to compatibility issues or problems with the Task Scheduler service. This might affect the successful launch of Task Scheduler.

Check the **C:\\Windows\\System32\\Tasks** folder to determine if you have any `at` tasks created under Task Scheduler. If so, the tasks are listed under the following locations. For example:

- **C:\\Windows\\System32\\Tasks**
  - **C:\\Windows\\System32\\Tasks\\At1**
  - **C:\\Windows\\System32\\Tasks\\At2**

- **C:\\Windows\\Tasks**
  - **C:\\Windows\\Tasks\\At1.job**
  - **C:\\Windows\\Tasks\\At2.job**

To resolve this issue, clean up the legacy tasks by using the following steps:

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

1. Stop the Task Scheduler service:

    1. Download [PsTools](/sysinternals/downloads/pstools) and extract the file.
    2. Go to the extracted PsTools directory and run the following command from an administrative Command Prompt (**cmd.exe**) window:

        ```console
        psexec.exe -s -i cmd.exe
        ```

    3. After you accept the end-user license agreement (EULA), another **cmd.exe** process opens. Type `whoami` in the command prompt, and you should receive the output `nt authority\system`.
    4. Run this command:

        ```console
        net stop schedule
        ```

2. After the Task Scheduler service is stopped successfully, delete the files for `at` tasks after backup if they exist. Here are some examples:

    - **C:\\Windows\\System32\\Tasks**
      - **C:\\Windows\\System32\\Tasks\\At1**
      - **C:\\Windows\\System32\\Tasks\\At2**

    - **C:\\Windows\\Tasks**
      - **C:\\Windows\\Tasks\\At1.job**
      - **C:\\Windows\\Tasks\\At2.job**

3. Clear the schedule entries from the registry:

    1. Open Registry Editor as administrator.
    2. Go to `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks`, and back up the `Tasks` folder before proceeding with the next steps.
    3. Delete the keys ending in `{1}`, `{2}`, `{3}` … or more if they exist. Those keys have the property `Path` set to `\\At<#>`, for example:

        - `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{1}`

            `Path`=`\\At1`

        - `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{2}`

            `Path`=`\\At2`

    4. Delete the following keys if they exist:

        - `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{xxxxxxxx-EC79-4064-9831-xxxxxxxxxxxx}`
        - `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{xxxxxxxx-FB9E-4BDD-8FED-xxxxxxxxxxxx}`

    5. Go to `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree`, and delete the keys ending in `At1`, `At2`, `At3` … or more if they exist. Those keys end with `At<#>`, for example:

        > [!IMPORTANT]
        > [Back up](https://support.microsoft.com/topic/855140ad-e318-2a13-2829-d428a2ab0692) the `Tree` key before proceeding with the next steps.

        - `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\At1`
        - `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\At2`

4. Go back to the command prompt opened using the `psexec` command, and then run the following command to start the Task Scheduler service:

    ```console
    netsh start schedule
    ```

## Step 2: Delete corrupted tasks and then create them again if needed

If you have cleaned up the `at` tasks or you don't have `at` tasks, you might have corrupted tasks that cause this issue. Find the corrupted tasks, delete them, and then create them again if needed.

1. Find the corrupted tasks:

    1. Open Task Scheduler, and acknowledge the first error message to get into the Task Scheduler console.
    2. Expand the Task Scheduler Library structure.
    3. Select each folder object and observe if any of them produce the following error message:

        > The selected task "{0}" no longer exists. To see the current tasks, click Refresh.

    4. Take a note of each task that produces this error message.
    5. Once you've gone through all folders and subfolders within Task Scheduler, you're ready to delete the corrupted tasks.

2. Delete the corrupted tasks:

    [!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

    > [!NOTE]
    > Before you proceed with the following steps, back up the following items:
    >
    > - The folder **%SYSTEMDRIVE%\\Windows\\System32\\Tasks**
    > - The registry key `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\`

    1. Delete the task file that corresponds to the corrupted task from the Tasks folder (**%SYSTEMDRIVE%\\Windows\\System32\\Tasks**).
    2. Go to the registry subkey `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree`. Note down the `Id` value (in GUID format) of each task that needs to be deleted corresponding to the corrupted task.

        Delete the registry subkey that corresponds to the corrupted task from `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree`.

3. Delete the registry subkey that corresponds to the corrupted task from `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks`.

4. Delete the registry subkey that corresponds to the corrupted task from one of the following locations:

    > [!NOTE]
    > The task exists in only one of the three locations and is in GUID format.

    - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain`
    - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Logon`
    - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Boot`

## Contact Microsoft Support

If the preceding steps can't resolve the issue, contact Microsoft Support for further assistance.
