---
title: Default Core Parking behavior changes
description: Describes the changes of the default behavior for Core Parking.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, match
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# Windows Server 2012 R2 default Core Parking behavior changes

This article describes the changes of the default behavior for Core Parking.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2814791

## Summary

The default behavior for Core Parking has changed for Windows Server 2012. By default, Windows Server 2012 will detect and enable/disable the built-in core parking feature to maximize optimal CPU performance based on what Processor is installed.

## More information

Since the Microsoft default behavior change for Core Parking is designed to maximize CPU performance, there is no built in method to re-enable core parking once it is disabled, as doing so can introduce degradation in CPU performance.

Due to the potential for performance degradation, modification of the default behavior of Windows Core Parking in Windows Server 2012 is not recommended nor supported. It was not designed/intended for OEMs to change the configuration in the current implementation of core parking in Windows Server 2012.

Currently by default, Windows Server 2012 disables core parking for Intel-based processors to maximize energy efficiency and CPU performance.

How Core Parking works: 

Windows Core parking for Windows Server 2012 works by Parking and unparking of cores as needed to adjust to changing workloads for efficiency reasons. Parking a core, by itself, does not save power. Parking a core alters the behavior of the scheduler to target threads at other cores. This allows the parked core to stay idle more (decreasing its power consumption), at the cost of placing additional work on unparked cores (increasing their power consumption). Whether or not this tradeoff results in a more or less efficient system is highly dependent on the processor. Windows is tuned to select optimal settings (core parking on or off) depending on which processor is installed and for Windows Server 2012 is considered the most efficient.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
