---
title: The IP Address page is missing when creating a cluster
description: Fixes an issue where the IP Address page is missing in the cluster creation wizard.
ms.date: 04/09/2024
ms.reviewer: wenca, alvinm
---
# The IP Address page in the System Center 2012 Virtual Machine Manager cluster creation wizard is missing

This article helps you fix an issue where the IP Address page is missing in the System Center 2012 Virtual Machine Manager cluster creation wizard.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2679673

## Symptoms

When creating a cluster using System Center 2012 Virtual Machine Manager, you don't get the cluster IP Address page during the cluster creation wizard.

## Cause

This can occur if the default gateway is missing. Because the interfaces in the clusters are set with static IP addresses but they do not have a default gateway specified, validation doesn't recognize the interfaces as candidates for client traffic.

## Resolution

Specify a default gateway on each interface that will service client traffic on the cluster, then rerun the wizard.
