---
title: Updates may not install with Fast Startup in Windows 10
description: Describes that the Fast Startup feature may impede the installation of certain Windows 10 updates.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:power-management, csstroubleshoot
ms.subservice: deployment
---
# Updates may not be installed with Fast Startup in Windows 10

This article discusses an issue where Windows updates might not be installed with the Fast Startup feature in Windows 10 after you shut down your computer.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4011287

## Summary

Windows updates might not be installed on your system after you shut down your computer. This behavior occurs when the Fast Startup feature is enabled. This behavior doesn't occur when you restart your computer.

## More information

The Fast Startup feature in Windows 10 allows your computer start up faster after a shutdown. When you shut down your computer, Fast Startup will put your computer into a hibernation state instead of a full shutdown. Fast Startup is enabled by default if your computer is capable of hibernation.

Installation of some Windows updates can be completed only when starting your computer after a full shutdown. Since Fast Startup uses hibernation instead of a full shutdown, installation of those updates will not be completed before a full shutdown. In order to make sure pending updates are completed, you have to choose **Restart** from the **Power** menu.

In environments managed with Microsoft Endpoint Manager Configuration Manager (MEMCM), Fast Startup may delay the completion of updates as well. This has been addressed in MEMCM 2002 and Windows 10 21H1.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
