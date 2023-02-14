---
title: Login windows keep appearing
description: Provides a resolution for the issue where login windows of Power Automate for desktop keep appearing.
ms.reviewer: pefelesk
ms.date: 02/14/2023
ms.subservice: power-automate-desktop-flows
---

# Login windows keep appearing

This article provides a resolution for the issue where login windows of Power Automate for desktop keep appearing.

## Symptoms

During signing in to Power Automate for desktop, the **login to your account** window pops out when you enter your credentials. If you select question mark (**?**) icon to reset the account in **Login to your Microsoft account**, the sign-in window disappears.

## Cause

Another process may run a named pipes server in the same machine. This process runs with elevated rights using the localhost endpoint and blocks other applications from using this endpoint.

To identify if another process is the issue:

1. Download the [Sysinternals Suite](/sysinternals/downloads/sysinternals-suite).

1. Extract the zip to a folder.

1. Run a CMD as administrator.

1. Navigate to the folder Sysinternals has been extracted to.

1. Run the following command:

    ```CMD
    handle net.pipe
    ```

1. Running this command should display a list of processes that use named pipes and the address they listen to.

1. Decode the process using the following link:

    `https://www.base64decode.org/`

    For example:

    ```CMD
    e.g.: PAD.BrowserNativeMessageHost.exe pid: 21064 type: Section 464: \Sessions\1\BaseNamedObjects\net.pipe:EbmV0LnBpcGU6Ly8rL0JST1dTRVJOQVRJVkVIT1NULzE2NjIwLzEv Microsoft.Management.Services.IntuneWindowsAgent.exe pid: 26708 type: Section 6AC: \BaseNamedObjects\net.pipe:EbmV0LnBpcGU6Ly8rL0lOVFVORU1BTkFHRU1FTlRFWFRFTlNJT04vU1RBVFVTU0VSVklDRS8= PipesTest.Server.exe pid: 6540 type: Section 3AC: \BaseNamedObjects\net.pipe:EbmV0LnBpcGU6Ly8rLw==.
    ```

## Resolution

As a permanent fix, the process causing the issue should either stop running or, if it's an internal process, use a more specific endpoint, such as **net.pipe://localhost/something**.

## Workaround #1

As an alternate, ensure Power Automate for desktop is closed (from the taskbar too), kill the process identified in previous steps, and try again to relaunch Power Automate for desktop.

## Workaround #2

If the other solutions aren't possible, specify Power Automate for desktop executables to run as administrator. This workaround may solve the issue only in some cases, and it causes a UAC prompt to appear each time.
