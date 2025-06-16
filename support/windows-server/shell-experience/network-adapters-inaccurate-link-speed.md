---
title: High-Speed Network Adapters Show Inaccurate Link Speeds
description: Describes a limitation in Windows user interfaces where the link speed might not be displayed correctly for high-speed network adapters.
ms.date: 06/16/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, sheiroqi, v-lianna
ms.custom:
- sap:windows desktop and shell experience\file explorer (app only,folders,quick access,file explorer search)
- pcy:WinComm User Experience
---
# High-speed network adapters show inaccurate link speeds

This article describes a limitation in Windows user interfaces where the link speed might not be displayed correctly for high-speed network adapters.

On devices using high-speed network adapters (for example, 400 Gbps or higher), the link speed displayed in Windows user interfaces like Network Connections (**ncpa.cpl**) might be lower than the actual configured speed.

For example, you might observe a displayed speed of 170.5 Gbps even though the hardware is correctly configured for 600 Gbps.

## The link speed exceeds the representable range

This issue is due to a limitation in how certain legacy components query and report link speed information.

Specifically, the Windows user interface retrieves the link speed using a method that returns the result as a 32-bit value, measured in 100-bps units. If the actual link speed exceeds approximately 429.5 Gbps, the value might exceed the representable range and be truncated in the display.

> [!NOTE]
> This issue doesn't indicate a malfunction of the hardware or system and doesn't affect the actual performance or functionality of the network adapter.
>
> The system continues to operate at the correct speed as configured at the hardware level.
>
> No action is required unless the display discrepancy causes confusion.

## Verify the accurate link speed

To retrieve the accurate link speed, run the following Windows PowerShell cmdlet:

```powershell
Get-NetAdapter | Select Name, LinkSpeed
```

This cmdlet returns the accurate speed as reported by modern networking application programming interfaces (APIs), which support higher-capacity adapters.

## Status

Microsoft is aware of this limitation and is exploring possible improvements in future updates.
