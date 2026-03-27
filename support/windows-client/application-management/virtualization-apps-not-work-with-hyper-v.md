---
title: Virtualization applications can't run alongside Hyper-V and its dependent features
description: Learn why virtualization applications don't work alongside Hyper-V, Device Guard, and Credential Guard, and how to resolve the issue.
ms.date: 03/27/2026
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kaushika
ai.usage: ai-assisted
ms.custom:
- sap:system performance\app,process,service reliability (crash,errors)
- pcy:WinComm Performance
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "aartigoyle" for triage before making the further changes to the screenshots.
--->

# Virtualization applications don't work together with Hyper-V and Hyper-V-based features

_Original KB number:_ &nbsp; 3204980

## Summary

Third-party virtualization applications, such as VMware and VirtualBox, can't run alongside Hyper-V, Memory Integrity, or Credential Guard. This article explains why this issue occurs and how to disable Hyper-V and its dependent security features so that your third-party virtualization software can work correctly.

## Symptoms

When Hyper-V is running, the third-party virtualization applications might not start virtual machines, or they might fall back to a slower, emulated mode.

## Cause

This behavior occurs by design.

Many virtualization applications depend on hardware virtualization extensions. Most modern processors, such as Intel VT-x and AMD-V, provide these extensions. However, only one software component can use this hardware at a time. Virtualization applications can't share the hardware.

## Workaround

To use third-party virtualization applications, disable  Hyper-V.

> [!IMPORTANT]  
> Some Windows security technologies depend on Hyper-V, including the following Windows features:
>
> - [Memory Integrity](/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity) (originally released as part of Device Guard)
> - [Credential Guard](/windows/security/identity-protection/credential-guard/how-it-works)
>
> When you disable Hyper-V, disable these dependent features as well.

### How to determine whether the Hyper-V hypervisor is running

To determine whether the Hyper-V hypervisor is running, follow these steps:

1. In the search box, type *msinfo32.exe*.
1. Select **System Information**.
1. In the Details pane, locate the following entry:

   > A hypervisor has been detected. Features required for Hyper-V will not be displayed.

   :::image type="content" source="media/virtualization-apps-not-work-with-hyper-v/system-information.svg" alt-text="screenshot of the detail window of System Information.":::

### How to disable Hyper-V

#### [Control Panel](#tab/controlpanel)

To disable Hyper-V in Control Panel, follow these steps:

1. In Control Panel, select **Programs and Features**.
1. Select **Turn Windows features on or off**.
1. Expand **Hyper-V**, expand **Hyper-V Platform**, and then clear the **Hyper-V Hypervisor** check box.

   :::image type="content" source="media/virtualization-apps-not-work-with-hyper-v/hyper-v-hypervisor.svg" alt-text="screenshot of the Hyper-V hypervisor check box." border="false":::

#### [PowerShell](#tab/powershell)

To disable Hyper-V by using Windows PowerShell, follow these steps:

1. Open an administrative PowerShell window.
1. Run the following command:

    ```powershell
    Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Hypervisor
    ```

#### [DISM](#tab/dism)

To disable Hyper-V by using DISM, follow these steps:

1. Open an administrative Command Prompt window.
1. Run the following command:

   ```console
   DISM /Online /Disable-Feature /FeatureName:Microsoft-Hyper-V-Hypervisor
   ```

---

### How to disable Memory Integrity and Credential Guard

You can disable Memory Integrity and Credential Guard by using Microsoft Intune, Group Policy, or registry entries. For more information, see the following articles:

- [Configure Credential Guard](/windows/security/identity-protection/credential-guard/configure)
- [Enable virtualization-based protection of code integrity](/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity)

## More information

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
