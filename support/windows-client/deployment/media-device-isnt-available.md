---
title: Media device isn't available in the Devices charm
description: Describes how to add non-certified devices as Play To endpoints on the Devices charm in Windows 8.1.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, vinbel, gfrost
ms.custom: sap:devices-and-drivers, csstroubleshoot
---
# My media device isn't available in the Devices charm

This article describes how to determine whether your device is certified for Windows 8, and how to change the default policy to show your non-certified devices in the Devices charm in Windows 8.1.

_Applies to:_ &nbsp; Windows 8.1  
_Original KB number:_ &nbsp; 2871501

## Summary

The Devices charm experience in Windows for streaming video, audio, and photos is designed to work together with devices that are certified for Windows 8. By default, devices that haven't been certified for Windows 8 aren't shown in the Devices charm for Microsoft Store apps.

## More information

To determine whether your device is certified for Windows 8, open the **Devices** page in **PC Settings**. To do it, type **Device Settings** from the Start screen, and then tap or select **Device Settings**. You'll see compatible media devices such as a TV or audio speaker organized as Play devices. If your device isn't certified for Windows 8, **Not Windows certified** will be displayed under the device name. If no Play devices are shown, tap or select **Add a device** to find a compatible device on your home network, or **Change network settings** to turn on finding devices automatically. Otherwise, your device may not be compatible with the Devices charm.

To enable the Devices charm for devices not certified for Windows 8 in Windows 8.1, add the following registry key value:

- Registry subkey: `HKEY_LOCAL_MACHINE\Software\Microsoft\PlayTo`
- Value name: ShowNonCertifiedDevices
- Value type: REG_DWORD
- Value data: 1

> [!IMPORTANT]
>
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To add this registry key value, follow these steps:

1. Start Registry Editor. To do it, type regedit.exe on the Start screen, and then tap or select **regedit.exe**.
2. Locate and then select the following registry subkey:
    `HKEY_LOCAL_MACHINE\Software\Microsoft`
3. On the **Edit** menu, point to **New**, tap or select **Key**, and then type PlayTo.
4. Select the newly added **PlayTo** key, point to **New** on the **Edit** menu, and then tap or select **DWORD Value**.
5. Type *ShowNonCertifiedDevices* in the **Name** field, and then press Enter.
6. Press and hold or right-click **ShowNonCertifiedDevices**, and then tap or select **Modify**.
7. In the **Value data** box, type *1*.
8. Tap or select **OK**.
9. Exit Registry Editor.

> [!NOTE]
>
> - This feature can also be enabled by following the same steps for `HKEY_CURRENT_USER\Software\Microsoft\PlayTo`. However, we recommend that you add this **ShowNonCertifiedDevices** value under a key that is machine-centric rather than user-centric.
> - This feature is for users who would prefer to connect to their non-certified devices even if they won't be guaranteed a great experience.
> - Devices not certified for Windows 8 may not be compatible with modern formats used by websites and apps in the Store or playback controls such as volume, skip, or seek.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
