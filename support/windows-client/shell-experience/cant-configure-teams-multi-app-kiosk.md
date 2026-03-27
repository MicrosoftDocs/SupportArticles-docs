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

When you try to configure Microsoft Teams to run in a [multi-app kiosk](/windows/configuration/kiosk/), you experience multiple issues. Kiosk mode doesn't support Teams.

## Symptom

When you try to configure Microsoft Teams to run in a multi-app kiosk, you might experience various kinds of unexpected behavior. Such behavior includes the following issues:

- You configure Teams together with other apps. The Teams icon is visible, but when you select it, nothing happens.
- Teams starts successfully. Within a few seconds, it closes automatically.
- Teams starts successfully. However, other applications can't run.

## Cause

Kiosk mode doesn't support Teams.
