---
title: Can't configure Microsoft Teams to run in a multi-app kiosk
description: Kiosk mode doesn't support Microsoft Teams.
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
# Can't configure Microsoft Teams to run in a multi-app kiosk

## Summary

When you try to configure Microsoft Teams to run in a [multi-app kiosk](/windows/configuration/kiosk/), you experience several issues. These issues occur because kiosk mode doesn't support Teams.

## Symptoms

When you configure Teams as one of the apps on a multi-app kiosk, you experience one or more of the following symptoms:

- The Teams icon is visible. However, if you select the icon, Teams doesn't start.
- Teams starts successfully. Within a few seconds, it closes automatically.
- Teams starts successfully. However, other applications can't run.

## Cause

Teams doesn't support Kiosk mode.
