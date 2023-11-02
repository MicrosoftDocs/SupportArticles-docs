---
title: Supportability of adding Azure VMs to an existing availability set
description: This article provides a supportability matrix about which VM series you can mix in the same availability set
documentationcenter: ''
author: genlin
manager: dcscontentpm
ms.service: virtual-machines
ms.subservice: vm-deploy
ms.topic: troubleshooting
ms.date: 12/07/2021
ms.author: genli

---
# Supportability of adding Azure VMs to an existing availability set

You may occasionally encounter limitations when you add new virtual machines (VMs) to an existing availability set. Now, you can use the following REST API service to find what VM sizes are supported in your availability set. Select **Try it**, and then sign in with your Azure account to run the REST API.

[Availability Sets - List Available Sizes - REST API](/rest/api/compute/availability-sets/list-available-sizes)

## Reference

The following chart shows some common VM series you can mix in the same availability set.

Series & Availability Set|Second VM|A|Av2|D|Dv2|Dv3|
|---|---|---|---|---|---|---|
|First VM|||||||
|A||OK|OK|OK|OK|OK|
|Av2||OK|OK|OK|OK|OK|
|D||OK|OK|OK|OK|OK|
|Dv2||OK|OK|OK|OK|OK|
|Dv3||OK|OK|OK|OK|OK|

All other series could not be in the same availability set because they require a specific hardware.

A8/A9 VM size can't be mixed due to requirement on dedicated RDMA backend network.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
