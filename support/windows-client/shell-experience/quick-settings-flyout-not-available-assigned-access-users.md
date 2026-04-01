---
title: Quick settings flyout menu isn't available for assigned access users
description: Kiosk or assigned access users don't have access to the quick settings flyout menu.
ms.date: 04/02/2026
manager: dcscontentpm
ms.topic: troubleshooting
ms.custom:
- sap:windows desktop and shell experience\kiosk mode
- pcy:WinComm User Experience
ms.reviewer: kaushika, warrenw, v-appelgatet
audience: itpro
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Quick settings flyout menu isn't available for assigned access users

## Summary

Assigned access users can't use the quick settings feature of Windows. This feature is disabled by default in assigned access environments (also referred to as kiosk environments).

> [!NOTE]  
>
> - The quick settings feature has been referred to as Quick Actions or Control Center in earlier versions of Windows.
> - The quick settings area is just to the left of the clock display in the taskbar. Typically, the quick settings area displays system icons such as the network, volume, or battery icons.

## Symptoms

You apply an assigned access configuration to a set of users to designate them as kiosk users. Afterwards, when one of those users selects the quick settings area of the Windows taskbar, nothing happens.

## Cause

This behavior is by design for assigned-access users. The Quick Settings flyout menu contains configuration and personalization settings that aren't appropriate for a kiosk experience (Volume, Wi-Fi connection, Focus Assist, and so forth).

## More information

The following policy settings control the quick settings flyout:

- Configuration Service Provider (CSP) setting:
  - **Name:** [Taskbar: Remove Quick Settings](/windows/client-management/mdm/policy-csp-start#disablecontrolcenter)
  - **Path:** `./User/Vendor/MSFT/Policy/Config/Start/DisableControlCenter`

- Group Policy Object (GPO) setting:
  - **Name:** [Remove quick settings](https://gpsearch.azurewebsites.net/#16262)
  - **Path:** **User Configuration\Administrative Templates\Start Menu and Taskbar\Remove Quick Settings**

> [!IMPORTANT]  
> If you change CSP or GPO setting, you have to restart the device to make the change take effect.

For more information about the settings that apply to assigned access users, see [Assigned Access Policy Settings](/windows/configuration/assigned-access/policy-settings).
