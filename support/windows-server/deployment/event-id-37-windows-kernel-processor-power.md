---
title: Kernel processor power Event ID 37 after changing power policy
description: Provides a solution to an issue where the Event ID 37 is logged in the System log after you change the power policy for a Windows Server 2016-based server.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:devices-and-drivers, csstroubleshoot
---
# Kernel processor power Event ID 37 after changing power policy in Windows Server 2016

This article provides a solution to an issue where the Event ID 37 is logged in the System log after you change the power policy for a Windows Server 2016-based server.

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4043839

## Symptoms

After you change the power policy for a Windows Server 2016-based server, you receive event ID 37 in the System log:

> Event ID 37  
Source: Microsoft-Windows-Kernel-Processor-Power  
Type: Warning  
Description:  
The speed of processorxin group y is being limited by system firmware. The processor has been in this reduced performance state forz seconds since the last report.

> [!NOTE]
> The values of x, y, and z in the Event ID message can vary.

## Cause

Event ID 37 is logged when the hardware platform determines that the OS can't use some frequency range that the processor supports. This Warning event notifies the user that the processor or CPU core can't support running at full speed.

## Resolution

To fix this issue, check for any Power Capping policy from the hardware manufactory, or verify the system options for any power policy that is configured to system firmware.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
