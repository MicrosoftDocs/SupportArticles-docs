---
title: Login windows keep appearing in Power Automate for desktop
description: Provides a resolution for the issue where login windows of Power Automate for desktop keep appearing.
ms.reviewer: pefelesk, nimoutzo, dipapa, iomavrid
ms.date: 02/14/2023
ms.subservice: power-automate-desktop-flows
---
# Login windows keep appearing

This article provides a resolution for the issue where login windows of Power Automate for desktop keep appearing when you sign in to Power Automate for desktop.

## Symptoms

During signing in to Power Automate for desktop, the **login to your account** window pops up when you enter your credentials. If you select the question mark (**?**) icon to reset the account in **Login to your Microsoft account**, the login window disappears.

## Cause

Another process may run a named pipes server in the same machine. This process runs with elevated rights using the localhost endpoint and blocks other applications from using this endpoint.

To identify if another process is running:

1. Download the [Sysinternals Suite](/sysinternals/downloads/sysinternals-suite).
1. Extract the .zip file to a folder.
1. Run a command prompt as an administrator.
1. Navigate to the folder that Sysinternals Suite has been extracted to.
1. Run the following command:

    ```cmd
    handle net.pipe
    ```

   > [!NOTE]
   > Running this command should display a list of processes that use named pipes and the address they listen to.

1. You need to identify whether there's a process displaying the `EbmV0LnBpcGU6Ly8rLw==` string and decode the process using the following link:

    `https://www.base64decode.org/`

    For example:

    ```console
    PAD.BrowserNativeMessageHost.exe pid: 21064 type: Section 464: \Sessions\1\BaseNamedObjects\net.pipe:EbmV0LnBpcGU6Ly8rL0JST1dTRVJOQVRJVkVIT1NULzE2NjIwLzEv Microsoft.Management.Services.IntuneWindowsAgent.exe pid: 26708 type: Section 6AC: \BaseNamedObjects\net.pipe:EbmV0LnBpcGU6Ly8rL0lOVFVORU1BTkFHRU1FTlRFWFRFTlNJT04vU1RBVFVTU0VSVklDRS8= PipesTest.Server.exe pid: 6540 type: Section 3AC: \BaseNamedObjects\net.pipe:EbmV0LnBpcGU6Ly8rLw==
    ```

## Resolution

To fix this issue, the process that causes the issue should either stop running or, if it's an internal process, use a more specific endpoint, such as `net.pipe://localhost/something`.

## Workaround 1

As an alternate, ensure Power Automate for desktop is closed (from the taskbar, too), kill the process identified in previous steps, and try again to restart Power Automate for desktop.

## Workaround 2

If the other solutions aren't possible, specify Power Automate for desktop executables to run as administrator. This workaround may only solve the issue in some cases, and it causes a User Account Control (UAC) prompt to appear each time.
