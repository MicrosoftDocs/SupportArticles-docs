---
title: Capacity Reservation billing scenarios
description: This article discusses billing scenarios as they apply to a Capacity Reservation
ms.date: 08/26/2021
ms.reviewer: 
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:Cannot create a VM
---

# Capacity Reservation billing scenarios

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Summary

This article discusses billing scenarios as they apply to a Capacity Reservation.

## Billing for Capacity Reservation

Capacity Reservations are priced at the same rate as the underlying virtual machine (VM) size.

### Example 1

If a customer creates a reservation for 10 quantities of a *D2s_v3* VM, when the reservation is created, the customer is billed for 10 *D2s_v3* VMs, regardless of whether or not the reservation is being used.

If the customer then deploys a D2s_v3 VM and specifies reservation as its property, the capacity reservation gets used. Once in use, customer pays only for the VM and nothing extra for the capacity reservation. For instance, let's say a customer deploys 5 D2s_v3 VMs against the capacity reservation. In this case, they see a bill for five D2s_v3 VMs and five unused capacity reservations, both charged at the same rate as a D2s_v3 VM.

Both used and unused capacity reservation are eligible for Reserved Instances term commitment discounts. In the above example, if the customer has Reserved Instances for two D2s_v3 VMs in the same Azure region, the billing for two resources (either VM or unused capacity reservation) is zeroed out as it's already been paid through Reserved Instances and the customer will only pay for rest of the eight resources, like five unused capacity reservations and three D2s_v3 VMs. In this case, the term commitment discounts could be applied on either the VM or the unused capacity reservation. It shouldn't matter as both are charged at the same pay-as-you-go (pay-as-you-go) rate.

### Example 2

If a Capacity Reservation with a reserved quantity of two has been created, the subscription has access to one matching Reserved VM Instance of the same size. Two usage streams for the Capacity Reservation result, and one is covered by the Reserved Instance.

In this diagram, the VM Reserved Instance discount is applied to one of the unused instances, and the cost for that instance is reduced to zero. For the other instance, the pay-as-you-go rate is charged for the reserved VM size.

:::image type="content" source="media/capacity-reservation-billing-scenerios/capacity-reservation-pricing.png" alt-text="Diagram of capacity reservation pricing.":::
other VM components, such as disks, network, extensions, and any other requested components, must also be allocated. In this state, the usage reflects one allocated VM and one unused capacity instance. The Reserved VM Instance negates the cost of either the VM or the unused capacity instance. The other charges for items such as disks and networking, associated with the allocated VM, also appear on the bill.

The following screenshot is an example of such a billing:

:::image type="content" source="media/capacity-reservation-billing-scenerios/capacity-reservation-pricing-vm-zero-highlighted.png" alt-text="Diagram of capacity reservation pricing, with VM zero highlighted.":::

As show in this example, the VM Reserved Instance discount is applied to VM 0. For that VM, the customer is only being charged for other components such as disks and networking. The other unused instance is charged at the pay-as-you-go rate for the VM size reserved.

 
