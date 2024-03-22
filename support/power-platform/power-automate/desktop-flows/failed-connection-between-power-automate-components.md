---
title: Failed connection between Power Automate components
description: Provides resolutions per product version to a Power Automate connection error that occurs on startup.
ms.reviewer: kokapare, pefelesk, tapanm
ms.date: 03/20/2024
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
---

# "Communication error" and the connection between Power Automate components fails

_Applies to:_ &nbsp; Power Automate  

## Symptoms

When you try to start Power Automate, you receive the following error message:

> Communication error:
>  
> The connection between Power Automate components couldn't be established. A required named pipe is in use by another application. Contact your IT administrator.

## Cause

This issue might occur if two different versions of Power Automate for desktop are installed on the computer. In this scenario, one version is installed using the MSI installer and a different version is installed from the Microsoft Store. This could result in conflicts between the two versions, and is an unsupported scenario.

## Resolution

Based on your [version of Power Automate for desktop](/power-platform/released-versions/power-automate-desktop#all-power-automate-desktop-versions), follow the steps below to resolve the issue.

If the installer version of your Power Automate for desktop is **2.34.176.23181 or higher** (Microsoft Store version **10.0.7118.0 or higher**), follow these steps to uninstall one version of the app:

1. Go to **Start** > **Settings** > **Apps** > **Installed apps**.
1. Search for **Power Automate**.
1. Uninstall either version of the app.

If the installer version of your Power Automate for desktop is **earlier than 2.34.176.23181** (Microsoft Store version **earlier than 10.0.7118.0**), then this error might occur if another process is running a named pipes server on the same computer. This process likely runs by having elevated rights and by using the localhost endpoint. Therefore, the process blocks other applications from using the endpoint.

To determine whether another process is causing the error, follow these steps:

1. Close Power Automate. Use Windows Task Manager to verify that the Power Automate process is no longer running.
1. Download the [Sysinternals Suite](/sysinternals/downloads/sysinternals-suite).
1. Extract the compressed file to a folder on your desktop.
1. Open an elevated Command Prompt window.
1. Navigate to the folder to which you extracted Sysinternals.
1. Run the following command:

   ```console
   handle net.pipe
   ```

   Running this command should display a list of processes that use named pipes and display the address that they listen to.

   :::image type="content" source="media/failed-connection-between-power-automate-components/command-prompt.png" alt-text="Screenshot of the results of the handle net.pipe command.":::

1. Determine whether a process that displays the **EbmV0LnBpcGU6Ly8rLw==** string exists.

1. If such a process exists, stop the process.

1. Start Power Automate again.

To resolve the issue, stop the process that is causing the issue from running. Alternatively, if the process is internal, you can configure it to use a more specific endpoint, such as **net.pipe://localhost/something**.

If these actions are not possible, specify Power Automate executables to run in administrative mode. However, this solution might not resolve the issue in all cases. Additionally, this solution will cause a UAC prompt to appear every time that you run the app.
