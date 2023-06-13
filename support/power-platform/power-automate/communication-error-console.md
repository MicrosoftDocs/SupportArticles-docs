---
title: Communication error when launching Power Automate for desktop
description: Provides a resolution for a communication error that occurs when launching or opening Power Automate for desktop.
ms.reviewer: pefelesk, nimoutzo, dipapa, iomavrid
ms.date: 02/17/2023
ms.subservice: power-automate-desktop-flows
---
# Communication error when launching Power Automate for desktop

This article provides a resolution for a communication error that occurs when you launch or open Power Automate for desktop.

## Symptoms

When you launch or open Power Automate for desktop, the following error message shows with a "Communication error" title:

> Power Automate console didn't start properly. Restart Power Automate.

## Cause

A process may run a WCF-named pipe in the same machine and prevents other WCF-named pipes from working as expected.

This process may run with elevated rights using the localhost endpoint, which blocks other applications from using the endpoint.

## Verify the issue

To identify whether there's a WCF-named pipe that uses the localhost endpoint:

1. Download the [SysInternals Suite](/sysinternals/downloads/sysinternals-suite).
1. Extract the .zip file to a folder.
1. Run a command prompt as an administrator.
1. Navigate to the _SysInternals_ folder that you previously extracted.
1. Run the following command:

    ```cmd
    handle net.pipe
    ```

    > [!NOTE]
    > This command should display a list of processes that use named pipes and the address they listen to.

1. Identify whether there's a process showing the following string:

    `EbmV0LnBpcGU6Ly8rLw==`

## Resolution

To fix this issue, you should stop the process that causes the issue or, if it's an internal process, configure it to use a more specific endpoint, such as `net.pipe://localhost/abc123`.

## Workaround

To work around this issue, run Power Automate for desktop as an administrator.

> [!NOTE]
>
> - Running processes as an administrator may cause User Account Control (UAC) prompts to appear each time you launch them.
> - Running Power Automate for desktop as an administrator doesn't work on unattended mode.
