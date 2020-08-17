---
title: Disable Hyper-V to run virtualization software
description: Discusses an issue in which virtualization applications do not work together with Hyper-V, Device Guard, and Credential Guard. Provides a resolution.
ms.date: 07/15/2020
author: delhan
ms.author: Deland-Han
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: 1st Party Applications
ms.technology: ApplicationCompatibility
---
# Virtualization applications do not work together with Hyper-V, Device Guard, and Credential Guard

This article provides solutions to disable Hyper-V, Device Guard, and Credential Guard to help you use virtualized applications.

_Original product version:_ &nbsp; Windows 10  
_Original KB number:_ &nbsp; 3204980

## Symptoms

Many third-party virtualization applications do not work together with Hyper-V. Affected applications include VMWare Workstation and VirtualBox. These applications might not start virtual machines, or they may fall back to a slower, emulated mode.

These symptoms are introduced when the Hyper-V Hypervisor is running. Some security solutions are also dependent on the hypervisor, such as the following:

- Device Guard
- Credential Guard

To determine whether the Hyper-V hypervisor is running, follow these steps:

1. In the search box, type *msinfo32.exe*.
2. Select **System Information**.
3. In the detail window, locate the following entry:

    A hypervisor has been detected. Features required for Hyper-V will not be displayed.

    :::image type="content" source="media/virtualization-apps-not-work-with-hyper-v/system-information.png" alt-text="screenshot of the detail window of System Information":::

## Cause

This behavior occurs by design.

Many virtualization applications depend on hardware virtualization extensions that are available on most modern processors. This includes Intel VT-x and AMD-V. Only one software component can use this hardware at a time. The hardware cannot be shared between virtualization applications.

## Resolution

To use other virtualization software, you must disable Hyper-V Hypervisor, Device Guard, and Credential Guard. If you are using Hyper-V to run virtual machines or containers, disable Hyper-V Hypervisor in Control Panel or by using Windows PowerShell. To do this, use the following methods, as appropriate.

### Method 1: Disable Hyper-V in Control Panel

To disable Hyper-V in Control Panel, follow these steps:

1. In Control Panel, select **Programs and Features**.
2. Select **Turn Windows features on or off**.
3. Expand **Hyper-V**, expand **Hyper-V Platform**, and then clear the **Hyper-V Hypervisor** check box.

    :::image type="content" source="media/virtualization-apps-not-work-with-hyper-v/hyper-v-hypervisor.png" alt-text="screenshot of the Hyper-V Hypervisor check box" border="false":::

### Method 2: Disable Hyper-V in PowerShell

To disable Hyper-V by using Windows PowerShell, follow these steps:

1. Open an elevated PowerShell Command Prompt window.
2. At the command prompt, run the following command:

    ```console
    Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Hypervisor
    ```

### Method 3: Disable Device Guard and Credential Guard

Disable Device Guard and Credential Guard by using registry keys or group policy. To do this, see [Manage Windows Defender Credential Guard](/windows/security/identity-protection/credential-guard/credential-guard-manage).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
