---
title: Unowned driver updates are installed unexpectedly
description: This article provides resolutions for the problem that allows driver packages that contain hardware IDs that are not owned by the publisher to be downloaded and installed from Windows Update.
ms.date: 09/04/2020
ms.custom: sap:Other Driver
ms.reviewer: danielwh, davean, delhan, christys
---
# Unowned driver updates are installed unexpectedly from Windows Update

This article helps you resolve the problem that allows driver packages that contain hardware IDs that are not owned by the publisher to be downloaded and installed from Windows Update.

_Original product version:_ &nbsp; Microsoft Update  
_Original KB number:_ &nbsp; 3059232

## Symptoms

Driver packages are submitted to [Microsoft developer center](https://developer.microsoft.com/) for final disposition in the Driver Distribution Center for publishing on Windows Update. However, [Hardware IDs](/windows-hardware/drivers/install/hardware-ids) for devices that are not owned by the publisher may be listed in the devices' INF files. Therefore, incorrect or conflicting drivers may be installed on the devices.

> [!NOTE]
> This issue does not occur on PCI devices.

## Resolution

These drivers should be removed from Windows Update. Processes are being designed to automatically block non-owners' driver packages from publishing on devices.

If a driver package has been identified as referencing hardware that the publisher does not own, the owner can request that those drivers be removed from Windows Update. To do this, contact [DDCHelp@Microsoft.com](mailto:ddchelp@microsoft.com), and reference the hardware ID and vendor ID.
