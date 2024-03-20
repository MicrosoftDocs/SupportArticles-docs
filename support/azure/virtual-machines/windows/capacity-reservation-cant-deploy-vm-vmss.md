---
title: Can't deploy Virtual Machines or Virtual Machine Scale Sets (Uniform) with Capacity Reservation
description: The following article discusses why you may not be able to deploy virtual machines (VMs) or Virtual Machine Scale Sets (VMSS) with Capacity Reservation.
ms.date: 08/26/2021
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-capacity-reservation
ms.collection: windows
---

# Can't deploy Virtual Machines or Virtual Machine Scale Sets (Uniform) with Capacity Reservation

The following article discusses why you may not be able to deploy virtual machines (VMs) or Virtual Machine Scale Sets (VMSS) with Capacity Reservation.

## Reasons why VMs or VMSS won't deploy with Capacity Reservation

If you have an existing Capacity Reservations that you can't use with VMs or VMSS, it could be because of one or more of the following reasons:

- Limitations and restrictions of capacity reservation.

  - Not all deployment constraints are currently supported. Some of the constraints are:

    - Proximity Placement Group

    - Update domains

    - UltraSSD storage

  - Spot VMs and Azure Dedicated Host Nodes are not supported with capacity reservation.

  - For the supported VM series during public preview, up to three Fault Domains (FDs) will be supported. A deployment with more than 3 FDs will fail to deploy against capacity reservation.

  - Availability Sets are not supported with capacity reservation.

  - The scope for capacity reservation is subscription. Only the subscription that created the reservation can use it. If your VM/VMSS is in a different subscription, create a new reservation in that subscription, or create your VM/VMSS in the subscription that has access to the capacity reservation.

- Not deploying explicitly against the reservation.

  To consume Capacity Reservation, the reservation should be explicitly added as a property of the VM or VMSS.
  
  For more information, see the following documentation:

  - [Associate a new Virtual Machine to Capacity Reservation](/azure/virtual-machines/capacity-reservation-associate-vm)
  - [Associate a new Virtual Machine Scale Sets to Capacity Reservation](/azure/virtual-machines/capacity-reservation-associate-virtual-machine-scale-set)

- Trying to attach a running VM/VMSS without first de-allocating the VM/VMSS.

  To attach running VM/VMSS to Capacity Reservation, the VM/VMSS must first be de-allocated. At the time of reallocation, reference Capacity Reservation as a property of the VM/VMSS.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
