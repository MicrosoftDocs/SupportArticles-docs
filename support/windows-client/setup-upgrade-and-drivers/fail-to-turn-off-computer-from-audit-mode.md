---
title: Can't turn off a computer from Audit mode
description: Discusses that a local administrator account is disabled when you turn off a computer by using the Start menu in Audit mode.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Error after you turn off a Windows 10-based computer from Audit mode: Your account has been disabled

This article helps fix an error (our account has been disabled) that occurs after you turn off a Windows 10-based computer from Audit mode.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3141410

## Symptoms

Consider the following scenario:

- You're working on a Windows 10-based computer.
- You go into Sysprep Audit mode from the Out of Box Experience (OOBE) screen.
- You turn off the computer by using the **Shut down** command on the **Start** menu, or you use one of the following **Shut down** options:

  - Log off
  - Sleep
  - Hibernate
- You restart or wake the computer.

In this scenario, you receive the following error message on the logon screen:

> Your account has been disabled. Please see your system administrator.

## Cause

This is expected behavior because the system is using *hybrid shutdown*  (also known as fast startup) during Audit mode. Hybrid shutdown was introduced in Windows 8. In Audit mode, the administrator account is enabled immediately before logoff and disabled immediately after logon. Therefore, the account is locked out when you turn off the computer and then turn it back on.

## Workaround

To work around this behavior, disable hybrid shutdown. To do this, follow these steps:

1. Right-click the **Start** button, and then click **Command Prompt (Admin)**.
2. At the command prompt, type the following command, and then press Enter:

    ```console
    shutdown /s /t 00
    ``` 

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
