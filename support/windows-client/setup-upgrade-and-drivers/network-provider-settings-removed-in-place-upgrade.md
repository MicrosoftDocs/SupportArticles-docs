---
title: Network provider settings are removed during an in-place upgrade to Windows 10
description: Discusses an issue in which network provider settings are removed during an in-place upgrade to Windows 10. Provides workarounds.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits
ms.custom: sap:Windows Setup, Upgrade and Deployment\Installing or upgrading Windows, csstroubleshoot
---
# Network provider settings are removed during an in-place upgrade to Windows 10

This article provides workarounds to an issue in which network provider settings are removed during an in-place upgrade to Windows 10.

_Applies to:_ &nbsp; Windows 10, version 1809, Windows 10, version 1709, Windows 10, version 1703, Windows 10, version 1607  
_Original KB number:_ &nbsp; 4013822

## Symptoms

When you perform an in-place upgrade to Windows 10, version 1809, version 1709, version 1703, or version 1607, the third-party network provider settings are removed from the computer.

## Cause

This is a known issue in the Windows 10 upgrade process. After the upgrade, the Provider list (`HKLM\SYSTEM\CurrentControlSet\Control\NetworkProvider`) is reset, and the third-party provider registry settings (under `HKLM\System\CurrentControlSet\Services\`) are removed.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, go to the following Microsoft Knowledge Base article:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

To work around this issue, use one of the following methods.

### Method 1

1. Before you upgrade, manually back up the contents of the Provider list at `HKLM\SYSTEM\CurrentControlSet\Control\NetworkProvider` and the respective third-party provider settings (under `HKLM\System\CurrentControlSet\Services\`).
2. Run the upgrade.
3. After the upgrade is completed, restore the registry settings that were backed up in step 1.

### Method 2

If you are experiencing issues that affect the third-party network provider settings after you upgrade, manually restore the registry keys that were deleted by the installer.

## More information

To verify the network providers list, follow these steps:

1. Open the **Run** box. To do this, press the Windows logo key (:::image type="icon" source="media/network-provider-settings-removed-in-place-upgrade/windows-logo-key.png" border="false":::)+R.
2. Type *ncpa.cpl*, and then press Enter.
3. Press the Alt key to open the menu bar.
4. Select **Advanced**, and then click **Advanced Settings**.

    :::image type="content" source="media/network-provider-settings-removed-in-place-upgrade/advanced-settings.png" alt-text="Screenshot of the Advanced Settings dialog." border="false":::

This third-party network providers list is stored in the following registry location:  
`HKLM\SYSTEM\CurrentControlSet\Control\NetworkProvider\Order\ProviderOrder`  
**Default value**: RDPNP,LanmanWorkstation,webclient  
`HKLM\System\CurrentControlSet\Control\NetworkProvider\HwOrder\ProviderOrder`  
**Default value**: RDPNP,LanmanWorkstation,webclient
> [!Note]
> Each string value has its own settings under `HKLM\System\CurrentControlSet\Services`.  
For example, the following are the default network providers:
>
> - `HKLM\System\CurrentControlSet\Services\RDPNP\NetworkProvider`
> - `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\NetworkProvider`
> - `HKLM\System\CurrentControlSet\Services\WebClient\NetworkProvider`
>
> The provider name is removed from the list, and all added registry key are removed.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
