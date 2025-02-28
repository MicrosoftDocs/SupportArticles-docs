---
title: Cloud-init writes virtual machine's host keys as ec2
description: This article describes an issue in which Cloud-init writes virtual machine's host keys as ec2. It provides a workaround.
ms.date: 10/10/2020
ms.custom: sap:VM Extensions not operating correctly, linux-related-content
ms.service: azure-virtual-machines
ms.collection: linux
ms.author: genli
author: genlin
ms.reviewer: Timothy.Basham, Scott.L.Roberts
---
# Cloud-init writes virtual machine's host keys as ec2

**Applies to:** :heavy_check_mark: Linux VMs

_Original KB number:_ &nbsp; 4561944

## Symptoms

Cloud-init intermittently writes SSH Host keys to console as 'ec2'. Azure doesn't use ec2 instances.

## Cause

Cloud-init uses the SSH module to call the write-ssh-key-fingerprints helper script in the final stage. The helper logged these values setting the program name to 'ec2'. The name of the cloud-init project was 'ec2-init' before changing to a platform-agnostic name. Some code paths still include the old name.

## Workaround

Ignore 'ec2' logs during troubleshooting. You'll find more information in the [Bug description](https://bugs.launchpad.net/cloud-init/%2Bbug/1869277) article.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
