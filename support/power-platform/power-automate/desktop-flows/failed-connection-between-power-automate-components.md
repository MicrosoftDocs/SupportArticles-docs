---
title: Failed connection between Power Automate components
description: Based on the version of Power Automate, provides resolutions to a Power Automate connection error that occurs on startup.
ms.reviewer: kokapare, pefelesk, tapanm
ms.date: 03/12/2024
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
---

# Failed connection between Power Automate components

_Applies to:_ &nbsp; Power Automate  

## Symptoms

On startup, Power Automate shows the following error message:

> Communication error:
>  
> The connection between Power Automate components couldn't be established. A required named pipe is in use by another application. Contact your IT administrator.

## Cause

This issue could occur if there are two Power Automate for desktop applications installed on the computer (one installed from the Microsoft Store and one from the MSI installer), and they are of different version. This is not a supported scenario due to conflicts between the installations.

## Resolution

If your version of Power Automate for desktop is **2.34.176.23181 or higher** (Microsoft Store version **10.0.7118.0 or higher**), then follow the steps below to uninstall either one of the two apps and resolve the issue:

1. Go to **Start** > **Settings** > **Apps** > **Installed apps**.
1. Search for **Power Automate**.
1. Uninstall either one of the two – either Power Automate (Microsoft Store installation) or Power Automate for desktop (MSI installation).

If your version of Power Automate for desktop is **less than 2.34.176.23181** (Microsoft Store version **less than 10.0.7118.0**), then this error might occur if another process is running a named pipes server on the same machine. This process probably runs with elevated rights using the localhost endpoint. As a result, it blocks other applications from using the endpoint.

Follow these steps to identify whether another process is indeed the issue:

1. Close Power Automate and use Windows Task Manager to ensure that its process isn't still running.
1. Download the [Sysinternals Suite](/sysinternals/downloads/sysinternals-suite).
1. Extract the zip file to a folder on your desktop.
1. Run a command prompt session as administrator.
1. Navigate to the folder in which you've extracted Sysinternals.
1. Run the following command:

   ```console
   handle net.pipe
   ```

   Running this command should display a list of processes that use named pipes and the address they listen to.

   :::image type="content" source="media/failed-connection-between-power-automate-components/command-prompt.png" alt-text="Screenshot of the results of the handle net.pipe command.":::

1. Identify whether a process displaying the string **EbmV0LnBpcGU6Ly8rLw==** exists.

1. If such a process exists, stop the process identified in the previous step.
1. Launch Power Automate again.

As a permanent fix, you can stop the process that is causing the issue from running. Alternatively,  if it's an internal process, you can change it to use a more specific endpoint, such as **net.pipe://localhost/something**.

If none of the above is possible, specify Power Automate executables to run as administrator. However, this solution might not solve the issue in all cases, and it will cause a UAC prompt to appear each time.
