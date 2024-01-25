---
title: Disable Hyper-V to run virtualization software
description: Discusses an issue in which virtualization applications don't work together with Hyper-V, Device Guard, and Credential Guard. Provides a resolution.
ms.date: 03/18/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:1st-party-applications, csstroubleshoot
ms.subservice: application-compatibility
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "christys" for triage before making the further changes to the screenshots.
--->

# Virtualization applications don't work together with Hyper-V, Device Guard, and Credential Guard

Many third-party virtualization applications don't work together with Hyper-V. Affected applications include VMware Workstation and VirtualBox. These applications might not start virtual machines, or they may fall back to a slower, emulated mode.

These symptoms are introduced when the Hyper-V Hypervisor is running. Some security solutions are also dependent on the hypervisor, such as:

- Device Guard
- Credential Guard

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3204980

## Determine whether the Hyper-V hypervisor is running

To determine whether the Hyper-V hypervisor is running, follow these steps:

1. In the search box, type *msinfo32.exe*.
2. Select **System Information**.
3. In the detail window, locate the following entry:

   > A hypervisor has been detected. Features required for Hyper-V will not be displayed.

   :::image type="content" source="media/virtualization-apps-not-work-with-hyper-v/system-information.svg" alt-text="screenshot of the detail window of System Information.":::

## Cause

This behavior occurs by design.

Many virtualization applications depend on hardware virtualization extensions that are available on most modern processors. It includes Intel VT-x and AMD-V. Only one software component can use this hardware at a time. The hardware cannot be shared between virtualization applications.

To use other virtualization software, you must disable Hyper-V Hypervisor, Device Guard, and Credential Guard. If you want to disable Hyper-V Hypervisor, follow the steps in next two sections.

## How to disable Hyper-V

You can disable Hyper-V Hypervisor either in Control Panel or by using Windows PowerShell.

### Disable Hyper-V in Control Panel

To disable Hyper-V in Control Panel, follow these steps:

1. In Control Panel, select **Programs and Features**.
2. Select **Turn Windows features on or off**.
3. Expand **Hyper-V**, expand **Hyper-V Platform**, and then clear the **Hyper-V Hypervisor** check box.

    :::image type="content" source="media/virtualization-apps-not-work-with-hyper-v/hyper-v-hypervisor.svg" alt-text="screenshot of the Hyper-V Hypervisor check box." border="false":::

### Disable Hyper-V in PowerShell

To disable Hyper-V by using Windows PowerShell, follow these steps:

1. Open an elevated PowerShell window.
2. Run the following command:

    ```powershell
    Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Hypervisor
    ```

## Disable Device Guard and Credential Guard

You can disable Device Guard and Credential Guard by using registry keys or group policy. To do it, see [Manage Windows Defender Credential Guard](/windows/security/identity-protection/credential-guard/credential-guard-manage).

## More information

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
