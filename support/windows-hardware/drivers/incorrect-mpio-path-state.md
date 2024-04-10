---
title: iSCSI initiator shows incorrect MPIO path state
description: This article provides a resolution for the problem that occurs when you use storage arrays that support asymmetric logical unit access (ALUA).
ms.date: 09/02/2020
ms.reviewer: seijit
ms.subservice: storage-driver
---
# The iSCSI initiator may show an incorrect MPIO path state

This article helps you resolve the problem that occurs when you use storage arrays that support asymmetric logical unit access (ALUA).

_Original product version:_ &nbsp; Internet Small Computer System Interface  
_Original KB number:_ &nbsp; 2387367

## Symptoms

The Internet Small Computer System Interface (iSCSI) initiator may show the incorrect Multipath I/O (MPIO) path state when you use storage arrays that support ALUA.

## Cause

iSCSI initiator is not using `MPIO_DSM_Path_V2` WMI Class to show the state, therefore, MPIO setting UI on iSCSI initiator cannot show and set the path state for ALUA.

In Addition, if you set the MPIO load-balancing policy from iSCSI initiator, the state becomes unexpected state. See [MPIO_DSM_Path_V2 WMI Class](/windows-hardware/drivers/storage/mpio-dsm-path-v2-wmi-class).

## Resolution

Use Device Manager to view and set the MPIO load-balancing policy for storage arrays that support ALUA.
