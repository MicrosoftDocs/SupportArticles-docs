---
title: Enable debug logging in UE-V
description: Describes how to enable debug logging for the Microsoft User Experience Virtualization (UE-V) agent.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, markstan
ms.custom: sap:user-experience-virtualization-ue-v, csstroubleshoot
---
# How to enable debug logging in Microsoft User Experience Virtualization (UE-V)

This article describes how to enable debug logging for the Microsoft User Experience Virtualization (UE-V) agent.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2782997

## Summary

It's useful when troubleshooting issues where settings or files aren't replicating as expected. Typically, this process is run on at least two different client machines to test replication.

## More information

First, identify the scenario you wish to trace. The two main variations for UE-V are tracing applications and tracing desktop settings. User application traces can be collected when an executable is launched; desktop settings must be recorded during logoff and subsequent logoff.

Traces collect data for all users logged in to a computer. If you wish to record a trace for a non-administrator account, you will need to either log into a second desktop session (in the case of a Terminal Server, for example), or else launch a command prompt in the context of a member of the machine's local Administrators group by holding down the shift key and right-clicking on a shortcut to a Command Prompt. In addition, these commands must be run in an elevated token.

### Scenario 1: Tracing an Application

1. Log on to the computer as a member of the local administrators group.
2. Launch an elevated command prompt by right-clicking on a shortcut to **Command Prompt** and selecting **Run as administrator**.
3. Create the trace definition by running these two commands in the elevated Command Prompt window:

    ```console
    logman create trace UEV -P "Microsoft-User Experience Virtualization-App Agent" -ow  -o uevtrace.etl
    logman update UEV -P "Microsoft-User Experience Virtualization-Agent Driver"
    ```

4. Start the trace by typing the command `logman start UEV`.  
5. Close any running instances of the application you are investigating, then launch the application.
6. Reproduce the issue you are investigating, then close the application.
7. Stop the trace by typing `logman stop UEV`.
8. Delete the trace definition by typing `logman delete UEV`.  
9. Decode the trace by typing the command `netsh trace convert uevtrace_000001.etl DUMP=TXT`.

> [!NOTE]
> The first trace you take will be named **uevtrace_000001.etl** by default. Edit the command above if you take multiple traces to reflect the name of the ETL file.

### Scenario 2: Tracing a desktop settings issue

1. Log on to the computer as a member of the local administrators group.
2. Launch an elevated command prompt by right-clicking on a shortcut to **Command Prompt** and selecting **Run as administrator**.
3. Create the trace definition by running these two commands in the elevated Command Prompt window:

    ```console
    logman create trace UEV -P "Microsoft-User Experience Virtualization-App Agent" -ow  -o uevtrace.etl
    logman update UEV -P "Microsoft-User Experience Virtualization-Agent Driver"
    ```

4. Start the trace by typing the command `logman start UEV`.
5. Reproduce the issue you are investigating, then log off.
6. Log back on to the server.
7. Launch an elevated command prompt by right-clicking on a shortcut to **Command Prompt** and selecting **Run as administrator**.
8. Stop the trace by typing `logman stop UEV`.
9. Delete the trace definition by typing `logman delete UEV`.  
10. Decode the trace by typing the command `netsh trace convert uevtrace_000001.etl DUMP=TXT`.

> [!NOTE]
> The first trace you take will be named **uevtrace_000001.etl** by default. Edit the command above if you take multiple traces to reflect the name of the ETL file.

### Alternate method: Event Viewer logging

If you wish to use Event Viewer rather than text file logging, use the steps below.

1. Log on to the computer as a member of the local administrators group.
2. Launch **Event Viewer**.
3. Select **View\\Show Analytic and Debug Logs.**  
4. Navigate to **Event Viewer (Local)\\Applications and Service Logs\\Microsoft\\User Experience Virtualization\\App Agent**.
5. Right-click on **Debug** under **App Agent** and select **Enable Log**.
6. Select **OK** when presented with the "Analytic and Debug logs may lose events when they are enabled. Do you want to enable this log?" dialog.
7. Reproduce your issue.
8. Right-click **Debug** and select **Refresh**.
9. Right-click **Debug** and select **Disable Log**.
