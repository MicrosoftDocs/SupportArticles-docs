---
title: Supportability of adding Azure VMs to an existing availability set
description: This article provides a supportability matrix about which VM series you can mix in the same availability set
documentationcenter: ''
author: JarrettRenshaw
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 12/07/2021
ms.author: jarrettr
ms.custom: sap:Cannot create a VM
---
# Supportability of adding Azure VMs to an existing availability set

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

You may occasionally encounter limitations when you add new virtual machines (VMs) to an existing availability set. Now, you can use the following REST API service to find what VM sizes are supported in your availability set. Select **Try it**, and then sign in with your Azure account to run the REST API.

[Availability Sets - List Available Sizes - REST API](/rest/api/compute/availability-sets/list-available-sizes)

## Reference

The following chart shows some common VM series you can mix in the same availability set.

Series & Availability Set|Second VM|B-Series|D-Series v2|D-Series v3|D-Series v4|D-Series v5|
|---|---|---|---|---|---|---|
|First VM|||||||
|B-Series||OK|OK|OK|OK|OK|
|D-Series v2||OK|OK|OK|OK|OK|
|D-Series v3||OK|OK|OK|OK|OK|
|D-Series v4||OK|OK|OK|OK|OK|
|D-Series v5||OK|OK|OK|OK|OK|

All other series could not be in the same availability set because they require a specific hardware.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
