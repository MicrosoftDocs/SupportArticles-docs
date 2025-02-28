---
title: Can't delete a Capacity Reservation or Group
description: The following article discusses why you may not be able to delete a Capacity Reservation or Group

ms.date: 08/26/2021
ms.reviewer: 
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:Cannot create a VM
---
# Can't delete a Capacity Reservation or Group

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

The following article discusses why you may not be able to delete a Capacity Reservation or Group

## Unable to delete a Capacity Reservation or Group

Capacity Reservations can be deleted only when no Virtual Machines (VMs) or Virtual Machine Scale Sets (VMSS) VMs are associated to the group.

- [Delete capacity reservation](/azure/virtual-machines/capacity-reservation-modify)

Azure will only allow a Capacity Reservation Group to be deleted when all member Capacity Reservations are deleted.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
