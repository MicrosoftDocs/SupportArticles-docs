---
title: Known UI limitation of the CPU information in Windows Server 2016
description: Describes the known UI limitations in Windows Server 2016. The System Information (Msinfo32.exe) tool and the Performance tab of Task Manager display incorrect processor sockets number, cores number, L1 cache and L2 cache sizes.
ms.date: 45286
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-lianna
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# Known UI limitation of the CPU information in Windows Server 2016

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2016 Datacenter, Windows Server 2016 Standard

If more than 64 logical processors are enabled in Windows Server 2016, the System Information (Msinfo32.exe) tool and the **Performance** tab of Task Manager display incorrect processor sockets number, cores number, L1 cache and L2 cache sizes.

Example:

|Correct information|Incorrect information|
|:---------:|:---------:|
|:::image type="content" source="./media/known-ui-limitation-cpu-information/cpu-performance-windows-server-2019.png" alt-text="CPU performance information for Windows Server 2019." border="false":::|:::image type="content" source="./media/known-ui-limitation-cpu-information/cpu-performance-windows-server-2016.png" alt-text="CPU performance information for Windows Server 2016." border="false":::|

In this example, the incorrect CPU information is displayed as follows:

- Four sockets are displayed for a two-socket system.
- 112 cores are displayed instead of 80.
- The cache sizes displayed for L1 and L2 are 8.8 MB and 140 MB respectively, while the actual sizes are 6.3 MB and 100 MB.

> [!NOTE]
> This is a known limitation of Windows Server 2016. This issue is fixed in Windows Server 2019.
