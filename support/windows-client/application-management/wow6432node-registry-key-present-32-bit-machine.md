---
title: WOW6432Node listed in 32-bit version of Windows
description: Fixes an issue in which a registry subkey labeled Wow6432Node is listed in system registry on x86 machines.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:1st-party-applications, csstroubleshoot
---
# Registry key WOW6432Node may be listed in system registry in 32 bit (x86) version of Windows 7

This article fixes an issue in which a registry subkey labeled Wow6432Node is listed in system registry on x86 machines.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2582176

## Symptoms

Consider the following scenario:

- A computer running 32 Bit (x86) Platform of Windows 7.
- Install Windows 7 with SP1 or install Windows 7 RTM Upgraded to SP1.
- Click the **Start** button, type *regedit* in the search box to open the Registry Editor.
- Expand the following registry key:

    `HKEY_LOCAL_MACHINE\SOFTWARE`

In this scenario, you may notice a registry subkey labeled **Wow6432Node** and feel that the system may have been incorrectly installed or upgraded.

:::image type="content" source="media/wow6432node-registry-key-present-32-bit-machine/wow6432node-registry-key.png" alt-text="Locate the Wow6432Node registry subkey in Registry Editor." border="false":::

## Cause

This registry key is typically used for 32-bit applications on 64-bit machines. If they're present on x86 machines, they don't cause any issues as they aren't used.

## Resolution

You can safely ignore the registry value.

## How to determine Windows 7 platform

There are a number of tools that you can use to identify which platform is installed on the system. Below are two ways that you can use to help identify the platform

### Method 1: Use System Information Tool to view Processor Architecture

1. Click on the **Start** button.
2. In the **Search** box, type the command `MSINFO32` without the quotes.
3. In the left-hand pane, click **System Summary**.
4. In the right-hand pane, view the entry labeled **System Type**.

    If the entry states **x86-Based PC**, this is 32-bit platform. If the entry states **x64-Based PC**, this is 64-bit platform.

### Method 2: Use the Set command to display Processor Architecture

1. Open an Administrative command prompt
2. Type the following command:

    ```console
    set processor_architecture
    ```

    If the result is **PROCESSOR_ARCHITECTURE=x86**, this is 32-bit platform. If the result is **PROCESSOR_ARCHITECTURE=AMD64** this is 64-bit platform.

## References

- [Registry Keys Affected by WOW64](/windows/win32/winprog64/shared-registry-keys)

- [Registry Redirector](/windows/win32/winprog64/registry-redirector)

- [32-bit and 64-bit Application Data in the Registry](/windows/win32/sysinfo/32-bit-and-64-bit-application-data-in-the-registry)
