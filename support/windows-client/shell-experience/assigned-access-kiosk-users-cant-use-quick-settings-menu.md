---
title: Assigned Access kiosk users can't use the Quick Settings flyout menu
description: Kiosk or Assigned Access users don't have access to the Quick Settings flyout menu.
ms.date: 04/02/2026
manager: dcscontentpm
ms.topic: troubleshooting
ms.custom:
- sap:windows desktop and shell experience\kiosk mode
- pcy:WinComm User Experience
ms.reviewer: kaushika, warrenw, v-appelgatet
audience: itpro
ai.usage: ai-assisted
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Assigned Access kiosk users can't use the Quick Settings flyout menu

## Summary

Assigned Access users can't use the Quick Settings feature of Windows. This feature is disabled by default in Assigned Access environments (also known as kiosk environments).

> [!NOTE]  
>
> - In earlier versions of Windows, the Quick Settings feature was referred to as Quick Actions or Control Center.
> - The Quick Settings area is immediately to the left of the clock display in the taskbar. Typically, the Quick Settings area displays system icons such as the network, volume, and battery icons.

## Symptoms

You apply an Assigned Access configuration to a set of users to designate them as kiosk users. Afterward, when one of those users selects the Quick Settings area of the Windows taskbar, nothing occurs.

## Cause

This behavior is by design for Assigned Access users. The Quick Settings flyout menu contains configuration and personalization settings that aren't appropriate for a kiosk experience (volume, Wi-Fi connection, Focus Assist, and so forth).

## More information

The following policy settings control the Quick Settings flyout menu:

- Configuration Service Provider (CSP) setting:
  - **Name:** [Taskbar: Remove Quick Settings](/windows/client-management/mdm/policy-csp-start#disablecontrolcenter)
  - **Path:** `./User/Vendor/MSFT/Policy/Config/Start/DisableControlCenter`

- Group Policy Object (GPO) setting:
  - **Name:** [Remove Quick Settings](https://gpsearch.azurewebsites.net/#16262)
  - **Path:** **User Configuration\Administrative Templates\Start Menu and Taskbar\Remove Quick Settings**

> [!IMPORTANT]  
> If you change the CSP or GPO setting, you have to restart the device to make the change take effect.

For more information about the settings that apply to Assigned Access users, see [Assigned Access Policy Settings](/windows/configuration/assigned-access/policy-settings).
