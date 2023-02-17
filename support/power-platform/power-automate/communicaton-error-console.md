---
title: Communication error when launching Power Automate for desktop
description: Provides a resolution for a communication error when launching or opening Power Automate for desktop.
ms.reviewer: pefelesk
author: georgiostrantzas
ms.author: gtrantzas
ms.date: 02/17/2023
ms.subservice: power-automate-desktop-flows
---

# Communication error when launching Power Automate for desktop

This article provides a resolution for a communication error when launching or opening Power Automate for desktop.

## Symptoms

An error dialog appears with title **Communication error** and message **Power Automate console didn't start properly. Restart Power Automate**.

## Cause

A process may run a WCF-named pipe in the same machine and prevents other WCF-named pipes from working as expected.

This process may run with elevated rights using the localhost endpoint, which blocks other applications from using the endpoint.

## Verify the issue

To identify whether there's a WCF-named pipe that uses the localhost endpoint:

1. Download the [SysInternals Suite](/sysinternals/downloads/sysinternals-suite).
1. Extract the ZIP to a folder.
1. Run a CMD as administrator.
1. Navigate to the **SysInternals** folder that you previously extracted.
1. Run the following command:

    ```CMD
    handle net.pipe
    ```

1. This command should display a list of processes that use named pipes and the address they listen to. Identify whether there's a process showing the following string:

    `EbmV0LnBpcGU6Ly8rLw==`

## Resolution

You should stop the process causing the issue or, if it's an internal process, configure it to use a more specific endpoint, such as **net.pipe://localhost/abc123**.

## Workaround

Run Power Automate for desktop (PAD) as administrator.

> [!NOTE]
>
> - Running processes as administrator may cause UAC prompts to appear each time you launch them.
> - Running Power Automate for desktop as administrator doesn't work on unattended mode.
