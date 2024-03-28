---
title: HPC Node Manager Service Unreachable error
description: Provides a solution for an issue where HPC Management console shows the HPC Node Manager Service Unreachable error.
ms.date: 09/19/2022
ms.service: hpcpack
ms.author: genli
author: genlin
ms.reviewer: hclvteam
---

# Node error "HPC Node Manager Service Unreachable"

This article provides a solution for an issue where the HPC Management console shows the "HPC Node Manager Service Unreachable" error.

## Symptoms

A compute node's health is in an error state, and the node connectivity shows the "HPC Node Manager Service Unreachable" error in the HPC management console.

The [HPC service log](/powershell/high-performance-computing/using-service-log-files-for-hpc-pack?view=hpc19-ps#BKMK_loc&preserve-view=true) shows the following error:

> Can not find cert with thumbprint &lt;thumbprint-id&gt; in store My, LocalMachine.

## Cause

This issue occurs if the certificates installed on the head node and compute node aren't matched.

## Resolution

To resolve the issue, verify that the certificate on the head node and compute node meet the [requirements](/powershell/high-performance-computing/manage-hpc-pack-certificates?view=hpc19-ps&preserve-view=true). Then, import the certificate from the head node to the compute node. You can find the certificate with public key from the HPC file share on head node `\\<headnode>\REMINST\Certificates`.

Alternatively, you may generate a new self-signed certificate, then rotate the certificate in the cluster. For more information, see [Rotate HPC Pack Node communication certificates](/powershell/high-performance-computing/manage-hpc-pack-certificates?view=hpc19-ps#rotate-hpc-pack-node-communication-certificates&preserve-view=true).
