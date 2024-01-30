---
title: Mitigation for AMD Family 17h Models 30h-3Fh/Rome Erratum 1474
description: Introduces the Windows mitigation for AMD Family 17h Models 30h-3Fh/Rome Erratum 1474.
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
ms.date: 07/30/2023
ms.service: windows-server
ms.subservice: deployment
ms.custom: sap:setup, csstroubleshoot
ROBOTS: NOINDEX
---
# Mitigation for AMD Family 17h Models 30h-3Fh/Rome Erratum 1474: A CPU core may hang after about 1044 days

This article introduces how to fix the AMD Rome Erratum 1474: A CPU core may hang after about 1,044 days. The erratum is documented in the [Revision Guide for AMD Family 17h Models 30h-3Fh Processors](https://www.amd.com/system/files/TechDocs/56323-PUB_1.01.pdf).

## More about AMD Rome Erratum 1474

An active processor runs in power state C0 when there's work to complete. However, if the processor isn't doing any work, it may go into an idle sleep state. There are different levels or depths of sleep. The deeper the sleep, the more power savings, and the longer it takes to return to C0.

This issue is due to a processor core failing to exit the hardware CC6 idle sleep state approximately 1,044 days after the last system restart.

Suggested workarounds include rebooting the system before the projected time of failure (and then potentially disabling CC6 in BIOS), or disabling the deep CC6 idle sleep state by programming MSRC001_0296 (using system-OEM-supported methods).

## Using powercfg to fix the issue in Windows

We recommend using the Windows native [powercfg](/windows-hardware/design/device-experiences/powercfg-command-line-options) utility to fix the issue in Windows. The `powercfg` utility ships as part of Windows and is used to control power schemes on the system. The utility can be used to control processor idle or sleep states.

The `powercfg` utility has an `IDLESTATEMAX` (processor idle state maximum) parameter. An `IDLESTATEMAX` value of 0 indicates no limit imposed on the maximum processor sleep level/c-state depth. A value of 1 allows depths to C1, the shallowest sleep state.

By using the `powercfg` utility, we can prevent the processor from entering its deeper C2 (corresponding to hardware CC6) idle sleep state, thus mitigating the errata. To do so, run the following command in an elevated Command Prompt window:

```console
powercfg -setacvalueindex scheme_current sub_processor IDLESTATEMAX 1
powercfg -setactive scheme_current
```

## Reference

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
