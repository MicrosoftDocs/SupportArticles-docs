---
title: OOBE Fails With Error "Something Went Wrong" 
description: Helps resolve the error "Something went wrong" during the Windows Out of Box Experience (OOBE).
manager: dcscontentpm
ms.date: 04/01/2025
ms.topic: troubleshooting
ms.reviewer: kaushika, erikje, v-lianna
ms.custom: sap:Managing Devices with Intune, intune-azure, get-started
ms.collection:
- M365-identity-device-management
- tier2
---
# OOBE fails with error "Something went wrong"

This article helps resolve the error "Something went wrong" during the Windows Out of Box Experience (OOBE).

When you first turn on Windows 365 Link, the OOBE is loaded to guide you through the process of joining the device to your Microsoft Entra tenant and enrolling the device into Intune management. If a failure occurs, you might encounter the following error message:

> Something went wrong.  
Looks like we can't connect to the URL for your organization's MDM terms of use. Try again, or contact you system administrator with the problem information from this page.

This error commonly occurs because you aren't configured for automatic enrollment in mobile device management (MDM) with Intune. For more information about the configuration details, see [Automatically enroll Windows 365 Link in Intune](/windows-365/link/intune-automatic-enrollment).
