---
title: Validate Disk Failover test fails
description: Provides a solution to an issue where validation fails when you run the Disk Failover test on a Windows Server 2012 failover cluster.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-when-running-the-validation-wizard, csstroubleshoot
---
# Validation fails when you run the Disk Failover test on a Windows Server 2012 failover cluster

This article provides a solution to an issue where validation fails when you run the Disk Failover test on a Windows Server 2012 failover cluster.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3020013

## Symptoms

When you run the Cluster Validation report on a Windows Server 2012 failover cluster, the Validate Disk Failover test may fail, and you may receive errors that resemble the following:

> Node `2012N2.burragevmlab.com` holds the SCSI PR on Test Disk 1 but has failed in its attempt to bring the disk online. The device is not ready.

## Cause

This issue occurs because the `Automount` feature is turned off. To determine whether this option is turned off, follow these steps:

1. Open an administrative command prompt, and then run the following command: `Diskpart`
2. At the `Diskpart` prompt, run the following command: `Automount`

The results will tell you whether `Automount` is enabled or disabled.

## Resolution

To resolve this issue, enable `Automount`. To do this, run the following command from an administrative command prompt: `Mountvol.exe /E`

No restart is required for this to take effect.

> [!NOTE]
> Make sure that you verify this information on all nodes that you will be adding to the cluster.
