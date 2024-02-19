---
title: Wake on LAN behavior
description: Describes the different behaviors of the Wake on LAN (WOL) technology in Windows 7 and Windows 10.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:power-management, csstroubleshoot
---
# Wake on LAN (WOL) behavior in Windows 10

This article provides information on how to enable Wake on LAN behavior in different versions of Windows.

_Applies to:_ &nbsp; Windows 10, version 1903, Windows 10, version 1809, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2776718

## Summary

The Wake on LAN (WOL) feature wakes a computer from a low-power state when a network adapter detects a WOL event. Typically, such an event is a specially constructed Ethernet packet. The default behavior in response to WOL events has changed from Windows 7 to Windows 10.

### Windows 7

In Windows 7, the default shutdown operation puts the system into the classic shutdown state (S5). And all devices are put into the lowest power state (D3). WOL from S5 isn't officially supported in Windows 7. However, some network adapters can be left armed for waking if enough residual power is available. So waking from S5 is possible on some systems if enough residual power is supplied to the network adapter, even though the system is in the S5 state and devices are in D3.

### Windows 10

In Windows 10, the default shutdown behavior puts the system into the hybrid shutdown (also known as Fast Startup) state (S4). And all devices are put into D3. In this scenario, WOL from S4 or S5 is unsupported. Network adapters are explicitly not armed for WOL in these cases, because users expect zero power consumption and battery drain in the shutdown state. This behavior removes the possibility of invalid wake-ups when an explicit shutdown is requested. So WOL is supported only from sleep (S3), or when the user explicitly requests to enter hibernate (S4) state in Windows 10. Although the target system power state is the same between hybrid shutdown and hibernates (S4), Windows will only explicitly disable WOL when it's a hybrid shutdown transition, and not during a hibernate transition.

> [!NOTE]
> the firmware and hardware on some systems may support arming Network Interface Cards (NIC) for wake from S4 or S5, even though Windows isn't involved in the process.

## More information

In Windows 10, hybrid shutdown (also known as Fast Startup) (S4) stops user sessions but lets the contents of kernel sessions be written to the hard disk. It enables faster startups.

To disable the S4 state in Windows 10, follow these steps.

> [!NOTE]
> We don't recommend that you disable the hybrid shutdown (S4) state.

1. In **Control Panel**, open the **Power Options** item.
2. Select the **Choose what the power buttons do** link.
3. Clear the **Turn on fast startup (recommended)** check box.
4. Select **Save Settings**.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

## References

For more information, see:

- [System Power Actions](/windows-hardware/drivers/kernel/system-power-actions)
- [System Power States](/windows/win32/power/system-power-states)
