---
title: OOBE Fails with an Error Has Occurred Error
description: Helps resolve the error (An error has occurred) during the Windows Out of Box Experience (OOBE).
manager: dcscontentpm
ms.date: 04/02/2025
ms.topic: troubleshooting
ms.reviewer: kaushika, erikje, v-lianna
---
# OOBE fails with error "An error has occurred" when using Windows 365 Link

This article helps resolve the error "An error has occurred" during the Windows Out of Box Experience (OOBE).

When you first turn on Windows 365 Link, OOBE is loaded to guide you through the process of joining the device to your Microsoft Entra tenant and enrolling the device into Intune management. If a failure occurs, you might encounter the following error message:

> Let's add your Microsoft account  
An error has occurred. Please try again.

This error commonly occurs due to the following reasons:

- Join permissions
- Join limits
- Enrollment restrictions

To complete OOBE, ensure the following items:

- You're allowed to join Windows devices to Microsoft Entra. For configuration details, see [Allow joining Windows 365 Link to Microsoft Entra](/windows-365/link/join-microsoft-entra).
- You don't exceed the maximum number of devices allowed to join Microsoft Entra ID. For configuration details, see [Allow joining Windows 365 Link to Microsoft Entra](/windows-365/link/join-microsoft-entra).
- You aren't blocked by platform restrictions that prevent you from enrolling Windows devices in Intune management. For configuration details, see [Configure enrollment restrictions for Windows 365 Link devices](/windows-365/link/enrollment-restrictions).
