---
title: Cached Exchange Mode Sync Setting wrongly shown in GPMC
description: Describes an issue in which the Outlook 2016 Cache Mode Setting is always displayed as Three days.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: cherryc, jobre, Jlyday
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook Cached Exchange Mode Sync Setting is displayed incorrectly in GPMC

_Original KB number:_ &nbsp; 4057720

## Symptoms

When you use the Microsoft Outlook administrative template to configure the **Cached Exchange Mode Sync Setting** policy to **One week**, **Two weeks**, or **All**, the Group Policy Management Console (GPMC) does not differentiate between these options, and it always shows **Three days** when you reopen the management console.

## More information

This only affects the way that the setting is displayed in GPMC. Actually, the **Cached Exchange Mode Sync Setting** policy works correctly as it's configured.

> [!NOTE]
> You can also configure the cache mode setting by using the `SyncWindowSetting` and the `SyncWindowSettingDays` registry keys. For more information, see [Update lets administrators set additional default Sync Slider windows for new Exchange accounts in Outlook 2016](https://support.microsoft.com/help/3115009/update-lets-administrators-set-additional-default-sync-slider-windows).
