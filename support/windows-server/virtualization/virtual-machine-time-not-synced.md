---
title: Hyper-V Time Synchronization can't correct system clock
description: Discusses an issue in which The Hyper-V Time Synchronization Service won't correct the system clock in the virtual machine if the system clock in the VM is running more than five seconds ahead of the system clock on the host machine.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:integration-components, csstroubleshoot
---
# Hyper-V Time Synchronization doesn't correct the system clock in the virtual machine if it's more than five seconds ahead of the host clock

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2618634

## Symptoms

The Hyper-V Time Synchronization Service won't correct the system clock in the virtual machine (VM), if the system clock in the VM is running more than five seconds ahead of the system clock on the host machine.

## Cause

This is by design and was implemented after reports of issues with applications when the Hyper-V Time Synchronization Service adjusted the time.

If the system clock in the VM is ahead of the host for no more than five seconds, the Hyper-V Time Synchronization Service will adjust the system clock in the virtual machine. However, if the system clock in the VM is ahead for more than five seconds, the Hyper-V Time Synchronization Service will NOT adjust the system clock and there's no way to achieve time adjustment by changing integration service setting.

## Workaround

There's no flag/property/setting that you can set to work around the timesync logic. However, below are a few workarounds that you may try to sync the time:

1. Pause and resume the virtual machine.
2. Power off and power on the virtual machine.
3. Disable and enable the **Time Synchronization** option in the virtual machine settings (via the Hyper-V Manager console).
4. Disable the Hyper-V **Time Synchronization** option, then use another time sync source and configure the **PhaseCorrectRate**, **MaxPollInterval**, **MinPollInterval**, and **UpdateInterval** values appropriately to get the Time Sync more closely. **MaxpollInterval** and **MinPollInterval** are the minimum and maximum interval between the polls respectively. The value in each is a time in log2 seconds (that is, 2^n, so if you specify 5 then the actual time would be 2^5 = 32 seconds). The default value for domain controllers for each of them respectively is 6 (64 seconds) and 10 (1,024 seconds).

See the below article to know more about Time Sync settings and how to configure them appropriately:

[Windows Time Service Tools and Settings](/previous-versions/windows/it-pro/windows-server-2003/cc773263(v=ws.10))
