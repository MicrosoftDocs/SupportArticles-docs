---
title: Can't create a Capacity Reservation
description: The following article discusses the reasons why you are not able to create Capacity Reservation.
ms.date: 08/26/2021
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-capacity-reservation
ms.collection: windows
---

# Can't create a Capacity Reservation

The following article discusses the reasons why you are not able to create Capacity Reservation.

## Reasons why Capacity Reservation can't be created

1. There is a lack of capacity in the Region/Availability zone.

   Azure doesn't have capacity for the combination of requested VM size, location, and quantity. Either wait and retry later, when new capacity becomes available, or try a different combination of VM size, location, and quantity.

   > [!NOTE]
   > Capacity Reservation creation succeeds or fails in its entirety. For a request to reserve ten instances, success is returned only if all ten instances are allocated. Otherwise, the capacity reservation creation will fail.

1. The VM size is unsupported.

   Not all VM sizes are supported with Capacity Reservation. During Public Preview, Azure supports only Av2, B, D, E, & F VM series. Support for other VM series is in progress and will be announced when they're available.

1. The subscription doesn't have the required quota.

   Creating capacity reservations requires quota in the same manner as it does for creating virtual machines. If you get insufficient quota error while creating capacity reservation, visit [Standard quota: Increase limits by VM series](/azure/azure-portal/supportability/per-vm-quota-requests) to request additional quota, or try a different combination of VM size/location/Qty.

1. You don’t have access to create reservation.

   Reservations are only available to paid Azure customers. Sponsored accounts such as *Free Trial* and *Azure for Students* aren't eligible to use this feature. To create a new paid Azure subscription, visit [Create an additional Azure subscription](/azure/cost-management-billing/manage/create-subscription).

## Steps to create Capacity Reservation

- [Create a Capacity Reservation in Azure (preview)](/azure/virtual-machines/capacity-reservation-create)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
