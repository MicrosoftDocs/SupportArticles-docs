---
title: Assigned Access kiosk users can't access printers that use a domain print server
description: Learn how to troubleshoot single-app and multi-app kiosk configurations, as well as common problems like sign-in issues.
ms.date: 03/30/2026
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
# Assigned Access kiosk users can't access printers that use a domain print server

## Symptom

To support Assigned Access kiosk users, you deploy printers that use a common domain-joined print server. However, the kiosk users can't access the printers. Users who have regular domain accounts can access the printers.

## Cause

This behavior occurs because the printers use a domain-joined print server. This configuration is typical when you use domain-level or user-level Group Policy to manage printer availability. To see or use a printer in this configuration, a user has to use a domain account to authenticate against the domain print server.

In Assigned Access scenarios, kiosk users typically run under the context of a local account instead of a domain account. Because they don't have domain accounts, kiosk users can't authenticate against the domain print server, and can't use the printers.

This behavior is by design. It reflects the intended function of domain-level Group Policy scope and domain authentication.

## Resolution

> [!IMPORTANT]  
> tTo change a device's printer setup, you need the **Manage Printer** permission. Typical kiosk users can't install or configure printers.

To make a printer available to Assigned Access kiosk users, configure the device that supports kiosk users to connect directly to the printer. For example, add the printer to the device by specifying the printer's hostname or IP address, using a Standard TCP/IP port. Make sure to install the correct printer driver.

In this configuration, the printer is available to all the users on the device, and doesn't require domain authentication.
