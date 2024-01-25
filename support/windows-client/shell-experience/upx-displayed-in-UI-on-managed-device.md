---
title: Upgrade and Privacy Experience (UPX) is displayed in the UI on managed Windows 10 device
description: Fixes an issue in which UPX is displayed in the UI on managed Windows 10 device.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, ningzhan, delhan, christys
ms.custom: sap:desktop-shell, csstroubleshoot
ms.subservice: shell-experience
---
# Upgrade and Privacy Experience (UPX) is displayed in the UI on managed Windows 10 device

This article provides a workaround for an issue in which UPX is displayed in the user interface (UI) on a managed Windows 10 device.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4016551

> [!NOTE]
> This article is intended for managed environment scenarios. These steps not only suppress the UPX but also enable the devices to be considered as "managed" for the Windows 10 Creators Update.

## Symptoms

Assume that you have a Windows 10-based computer that's configured to receive updates from the Microsoft Windows Update server. The computer is not domain-joined or Microsoft Entra Domain-joined or managed by a System Center Configuration Manager (SCCM) client, but the computer is otherwise managed, for example by an IT professional.

In this situation, the Upgrade and Privacy Experience (UPX) may be displayed in the user interface (UI) unexpectedly, contrary to the preferences of the IT professional or other person who manages the device.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To work around this issue, follow these steps to suppress the UPX display and migrate existing privacy settings automatically instead of giving users of the device the opportunity to select privacy settings manually from the UPX UI:

1. Create the following registry key if it is not present on the system:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CreatorsUpdatePrivacySettings`
2. Create a new value named *ShowUI* of type REG_DWORD if it does not already exist, and set ShowUI to 0.
3. Create a new value named *AutoSet* of type REG_DWORD if it does not already exist, and set AutoSet to 0.
4. With the UPX UI suppressed, the existing privacy settings on the system will be migrated automatically when the Creators Update is applied. As part of your ongoing device management, we recommend you continue to review and manage privacy settings on the device, for example, by applying privacy-related group policies.

> [!NOTE]
> Any client that is managed by third-party enterprise management software can also avoid the UPX UI display by having the two registry key values set.

For more information about UPX, see [Choose your privacy settings for the Windows 10 Creators Update](https://support.microsoft.com/windows/choose-your-privacy-settings-after-updating-windows-10-9d92e194-36aa-ae41-18f6-fef5459ad86d).

> [!NOTE]
> If the [KB4013214](https://support.microsoft.com/help/4013214) update is already installed on the system, open **Task Scheduler**, navigate to \\Microsoft\\Windows\\UNP, and run the `RunCampaignManager` command. This operation will prevent the UPX UI from being shown to the end user even if the UPX has already been downloaded and installed on the system.

## Status

Microsoft has confirmed that this is a problem in Windows 10 - all editions.
