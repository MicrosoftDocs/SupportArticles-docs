---
title: Troubleshoot Apps failing to start using Process Monitor
description: Provides guidance to troubleshoot when Modern, Inbox, and Microsoft Store Apps fail to start.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom: sap:modern-inbox-and-microsoft-store-apps, csstroubleshoot
ms.reviewer: kaushika, warrenw, traceytu, iovoicul, kimberj, v-lianna
localization_priority: medium
---
# Troubleshoot Apps failing to start using Process Monitor

This article describes how to install the Process Monitor tool to troubleshoot the issue in which Modern, Inbox, and Microsoft Store Apps fail to start.

Download the [Process Monitor](/sysinternals/downloads/procmon) tool. Once the Process Monitor tool is downloaded locally, extract the files.

## Capture events

In order to capture a Process Monitor trace, run it with elevated permissions (run as administrator).

> [!NOTE]
> Make sure you're running the version of Process Monitor that matches the platform (*Procmon.exe* for x86 systems, *Procmon64.exe* for X64 systems, and *Procmon64a.exe* for ARM).

Once started, reset any previously saved filters to default to ensure that no potential events are filtered out by the previously set filters. If it's the first time you run Process Monitor or if there are no filters set, you can start recording without the pop-up window.

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/process-monitor-filter-reset.png" alt-text="Screenshot of the Process Monitor Filter window with a Reset button.":::

By default, the recording should start automatically. However, you can make sure it's running by selecting the following icon:

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/process-monitor-check-running.png" alt-text="Screenshot of the Process Monitor window with an icon selected to check if the tool is running.":::

Alternatively, you can start the recording by pressing <kbd>Ctrl</kbd> + <kbd>E</kbd> or by selecting **Capture Events** from the **File** menu. You see the events recorded in the status bar as follows:

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/process-monitor-recorded-events.png" alt-text="Screenshot of the recorded events showing in the status bar.":::

Alternatively, if a graphical user interface (GUI) isn't an option or the system is accessible remotely only with console access, you can trace the issue using Windows PowerShell or a command prompt. For example:

```console
C:\ProcessMonitor>procmon64.exe -accepteula -backingfile C:\ProcessMonitor\Recording.pml -quiet -minimized
```

Other options are available, including filtering and setting the maximum file size. For more information, see [Process Monitor](/sysinternals/downloads/procmon).

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/process-monitor-usage.png" alt-text="Screenshot of the command line arguments of the Process Monitor Usage.":::

To terminate and save the trace, you can use the following command:

```console
C:\ProcessMonitor>procmon64.exe -terminate -quiet
```

Additionally, you can remotely run Process Monitor using PowerShell or the [PsExec tool](/sysinternals/downloads/psexec). For example:

```console
C:\PSTools>psexec.exe -sd \\<Computer Name> C:\ProcessMonitor\procmon64.exe -accepteula -backingfile C:\ProcessMonitor\Recording.pml -quiet -minimized
```

To stop the recording, you can use the following command:

```console
C:\PSTools>psexec.exe -sd \\<Computer Name> C:\ProcessMonitor\procmon64.exe -terminate -quiet
```

## Store and save events

There are several methods available to store and save the events. You can select **Backing files** from the **File** menu. Then, you can see two methods to store events:

- **Use virtual memory**
- **Use file named**

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/process-monitor-store-events-methods.png" alt-text="Screenshot of the Process Monitor Backing Files window with two methods of storing events.":::

### Use virtual memory

This method uses the system's memory to store the file until it gets saved by the user manually.

> [!NOTE]
> Running the Process Monitor for too long, backed by virtual memory, might cause the Process Monitor to consume all the available system virtual memory, which could lead to the system stopping responding.

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/backing-files-virtual-memory.png" alt-text="Screenshot of the events backed by virtual memory showing in the status bar.":::

If you start recording as **Backed by virtual memory**, you need to save the recording prior to exiting Process Monitor.

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/process-monitor-save-recording.png" alt-text="Screenshot of a saving icon and the Save To File window with All events and Native Process Monitor Format selected.":::

Make sure you select **All events** and the format is set as **Native Process Monitor Format (PML)**. If the recording doesn't contain all the events, you only have the displayed or highlighted events available for analysis, which might be insufficient.

### Backed by file

This method uses a file to store the recording and doesn't require saving the file manually before exiting Process Monitor.

> [!NOTE]
> If the maximum file size isn't defined, running the Process Monitor for too long, backed by a file, might cause the Process Monitor to consume all the available system disk space, which could lead to the system stopping responding.

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/backing-files-by-file.png" alt-text="Screenshot of the events backed by a file showing in the status bar.":::

Once the Process Monitor is set and the recording is started, you need to reproduce the problem.

## Troubleshooting example

Take this issue as an example; you have the Calculator application that isn't working. First, start the Process Monitor recording with any of the methods described above. Then reproduce the problem by trying to start the application. Once the issue is reproduced, stop the Process Monitor recording and save the data.

To analyze the recorded Process Monitor trace, open it with Process Monitor. Select **Process Tree** under **Tools** on the Menu to see if your application starts during the recording.

Select the Calculator process:

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/process-tree-calculator.png" alt-text="Screenshot of the Process Tree window with the Calculator process selected.":::

To focus on the process, right-click the application name and select **Add process to Include filter**.

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/add-process-to-include-filter.png" alt-text="Screenshot of the Calculator process right clicked and showing Add process to include filter.":::

Similarly, you can add a filter manually for your process ID.

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/process-monitor-filter-process-id.png" alt-text="Screenshot of the Process Monitor Filter window with the process ID defined.":::

Exit the **Process Tree** view or select **OK** on the **Process Monitor Filter** window to see the filtered captured lines containing your process. In this example, the *Calculator.exe* process is starting.

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/process-monitor-calculator-process.png" alt-text="Screenshot of the Process Monitor window with the Calculator process selected.":::

Then go towards the end of the process capture, and look for a group of the **Thread Exit** events right before the **Process Exit** event.

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/calculator-thread-exit.png" alt-text="Screenshot of the Process Monitor window with the Calculator process selected and Thread Exit events above.":::

You can also see the **Process Create** event for *WerFault.exe*. At that point, the application has already reached an unrecoverable condition and has called the default error handler.

You should also notice that some event logs related to application crashes are recorded as well.

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/event-viewer-application-error.png" alt-text="Screenshot of the Event Viewer window showing the application error event.":::

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/event-viewer-event-5961.png" alt-text="Screenshot of the Event Viewer window showing Event 5961.":::

You can start from this line to see if you can spot any Access Denied Results events.

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/calculator-process-access-denied.png" alt-text="Screenshot of the Process Monitor window with an access denied calculator process selected." lightbox="media/troubleshoot-apps-start-failure-use-process-monitor/calculator-process-access-denied.png":::

In this situation, you should check the permissions of the following registry key against those from a working machine to see if there are some differences.

`\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`

In this example, **ALL APPLICATION PACKAGES** is missing "read" permissions from **User Shell Folders**.

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/all-application-packages-permission.png" alt-text="Screenshot of the permissions for User Shell Folders with all application packages selected.":::

This operation can also be done by using PowerShell or a command prompt.

For the working system:

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/user-shell-folders-permission-working-system.png" alt-text="Screenshot of the PowerShell cmdlet for the User Shell Folders permission for a working system.":::

For the nonworking system:

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/user-shell-folders-permission-non-working-system.png" alt-text="Screenshot of the PowerShell cmdlet for the User Shell Folders permission for a nonworking system.":::

If you don't spot any nearby permission issues that could be suspicious, you can always check the entire trace for any suspect permission blocks. First, remove the filter for the Calculator process by selecting **Reset Filter** under the **Filter** menu. Then, select the **Count Occurrences** option from the **Tools** menu. You can choose the result **Result** from the drop-down menu, then select **Count**.

Once the filtering is done, you can double-click the "Access Denied" line to view the filtered events:

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/count-values-occurrences.png" alt-text="Screenshot of the Count Values Occurrences window with an access denied line selected.":::

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/process-monitor-access-denied-lines.png" alt-text="Screenshot of the Calculator process followed by some access denied processes." lightbox="media/troubleshoot-apps-start-failure-use-process-monitor/process-monitor-access-denied-lines.png":::

If you work through the list, not all "Access Denied" results cause the code to fail.

Generally, anything asking for "All Access" is often refused, so you can exclude them from your investigations. You can do it automatically by filtering the events containing **Desired Access: All Access** as follows:

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/process-monitor-filter-all-access.png" alt-text="Screenshot of the Process Monitor Filter window with the Desired Access All Access filter.":::

In this example, the result looks like the following:

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/process-monitor-start-menu-experience.png" alt-text="Screenshot of the Process Monitor window with the StartMenuExperienceHost and Calculator process selected." lightbox="media/troubleshoot-apps-start-failure-use-process-monitor/process-monitor-start-menu-experience.png":::

:::image type="content" source="media/troubleshoot-apps-start-failure-use-process-monitor/start-menu-experience.png" alt-text="Screenshot of the Process Monitor window with the StartMenuExperienceHost process selected." lightbox="media/troubleshoot-apps-start-failure-use-process-monitor/start-menu-experience.png":::

Adding the appropriate permission for "All Application Packages" resolves both issues at the same time for both applications.

Sometimes it isn't possible to work out what permission change is stopping the application from starting. Process Monitor only captures some parts of the process activities.

If many machines are affected by the same problem, work out the troubleshooting by starting from a new, freshly installed machine and slowly adding your policies until the application fails to start again.

If only one machine is affected, recover or reset the machine. If only one user is affected, recreate the user's profile.
