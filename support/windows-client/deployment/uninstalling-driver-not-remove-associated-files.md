---
title: Uninstalling driver doesn't remove associated files
description: Resolves an issue where uninstalling a driver through device manager doesn't remove associated files or applications with that driver.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:devices-and-drivers, csstroubleshoot
ms.technology: windows-client-deployment
---
# In all supported versions of Windows, uninstalling a driver through device manager may not remove associated files or applications with that driver

This article provides help to solve an issue where uninstalling a driver through device manager doesn't remove associated files or applications with that driver.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2278714

## Symptoms

Consider the following scenario:

- You have a third-party driver installed on a system via the third-party installation.
- The driver installer also installs a third-party application or applications.
- You try to uninstall the driver through the Device Manager.

In this scenario, the driver files, as well as the third-party application are not removed. Each time you reboot the machine, or any other action that forces a re-enumeration of plug and play devices, it will try to install the drivers.

## Cause

Microsoft has confirmed that this behavior is by design.

## Resolution

If you have installed a third-party driver via a third-party installation, it is recommended that Add and Remove programs is used to uninstall third-party driver packages.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
