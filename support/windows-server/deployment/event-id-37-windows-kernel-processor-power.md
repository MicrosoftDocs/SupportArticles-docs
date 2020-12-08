---
title: Event ID 37 : Microsoft-Windows-Kernel-Processor-Power
description: 
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Kernel processor power event 37 after changing power policy in Windows Server 2016

_Original product version:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4043839

## Symptoms

After you change the power policy for a Windows Server 2016-based server, you receive event ID 37 in the System log:
 Event ID 37 
 Source: Microsoft-Windows-Kernel-Processor-Power 
 Type: Warning 
 Description: 
 The speed of processorxin group y is being limited by system firmware. The processor has been in this reduced performance state forz seconds since the last report. 

**Note** The values ofx,y, andzin the Event ID message can vary.

## Cause

Event ID 37 is logged when the hardware platform determines that the OS can't use some frequency range that the processor supports. T his Warning event notifies the user that the processor or CPU core can't support running at full speed. 

## Resolution

To fix this issue, check for any Power Capping policy from the hardware manufactory, or verify the system options for any power policy that is configured to system firmware.
