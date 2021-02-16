---
title: Windows 10 RSAT uninstalled by in-place upgrade
description: Describes an issue in which Windows 10 Remote Server Admin Tools (RSAT) is uninstalled during an in-place upgrade.
ms.date: 12/04/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, v-jeffbo, warrenw
ms.prod-support-area-path: setup
ms.technology: windows-client-deployment
---
# Windows 10 Remote Server Admin Tools is uninstalled during in-place upgrade

This article provides a resolution to an issue in which Windows 10 Remote Server Admin Tools (RSAT) is uninstalled during an in-place upgrade.

_Original product version:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4090941

## Symptom

When you perform an in-place upgrade of a Windows 10 installation that has Remote Server Admin Tools (RSAT) installed, RSAT is uninstalled.

## Cause

This is by design. RSAT is always uninstalled during in-place upgrades.

## Resolution

After the in-place upgrade of Windows 10, reinstall [RSAT](https://www.microsoft.com/download/details.aspx?id=45520).
