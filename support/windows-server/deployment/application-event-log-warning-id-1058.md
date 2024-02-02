---
title: Warning ID 1058 (Security-SPP) after reboot on OEM systems
description: Provides some information about Application Event Log Warning ID 1058(Security-SPP) which may be logged after reboot on OEM systems
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, match
ms.custom: sap:activation, csstroubleshoot
ms.subservice: deployment
---
# Application Event Log Warning ID 1058 (Security-SPP) may be logged after reboot on OEM systems

This article provides some information about Application Event Log Warning ID 1058(Security-SPP) which may be logged after reboot on OEM systems.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 2916670

## Summary

Application Event Log Warning ID 1058 (Security-SPP) may be logged after an OEM system that utilizes OA (OEM Activation) has been rebooted.

## Cause

This warning is logged because of test activation data being present as part of the manufacturing process for OEM systems.  

This warning ID can be safely ignored in this scenario.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
