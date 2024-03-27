---
title: Capacity Reservation billing scenarios
description: This article discusses billing scenarios as they apply to a Capacity Reservation
ms.date: 08/26/2021
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-capacity-reservation
ms.collection: windows
---

# Capacity Reservation billing scenarios

This article discusses billing scenarios as they apply to a Capacity Reservation

## Billing for Capacity Reservation

Capacity Reservations are priced at the same rate as the underlying virtual machine(VM) size.

### Example 1

If a customer creates a reservation for ten quantities of a *D2s_v3* VM, when the reservation is created, the customer will be billed for ten *D2s_v3* VMs, regardless of whether or not the reservation is being used.

If the customer then deploys a D2s_v3 VM and specifies reservation as its property, the capacity reservation gets used. Once in use, customer pays only for the VM and nothing extra for the capacity reservation. For instance, let's say a customer deploys 5 D2s_v3 VMs against the capacity reservation. In this case, they will see a bill for 5 D2s_v3 VMs and 5 unused capacity reservation, both charged at the same rate as a D2s_v3 VM.

Both used and unused capacity reservation are eligible for Reserved Instances term commitment discounts. In the above example, if the customer has Reserved Instances for 2 D2s_v3 VM in the same Azure region, the billing for 2 resources (either VM or unused capacity reservation), will be zeroed out as it's already been paid through Reserved Instances and the customer will only pay for rest of the 8 resources i.e., 5 unused capacity reservations and 3 D2s_v3 VMs. In this case, the term commitment discounts could be applied on either the VM or the unused capacity reservation. It shouldn't matter as both are charged at the same Pay-as-You-Go (PAYG) rate.

### Example 2

If a Capacity Reservation with a reserved quantity of two has been created, the subscription has access to one matching Reserved VM Instance of the same size. Two usage streams for the Capacity Reservation will result, and one is covered by the Reserved Instance.

In this diagram, the VM Reserved Instance discount is applied to one of the unused instances, and the cost for that instance will be reduced to zero. For the other instance, the PAYG rate will be charged for the reserved VM size.

:::image type="content" source="media/capacity-reservation-billing-scenerios/capacity-reservation-pricing.png" alt-text="Diagram of capacity reservation pricing.":::

When a VM is allocated against the Capacity Reservation, the additional VM components, such as disks, network, extensions, and any other requested components, must also be allocated. In this state, the usage will reflect one allocated VM and one unused capacity instance. The Reserved VM Instance will negate the cost of either the VM or the unused capacity instance. The other charges for items such as disks and networking, associated with the allocated VM, will also appear on the bill.

The following screenshot is an example of such a billing:

:::image type="content" source="media/capacity-reservation-billing-scenerios/capacity-reservation-pricing-vm-zero-highlighted.png" alt-text="Diagram of capacity reservation pricing, with VM zero highlighted.":::

As show in this example, the VM Reserved Instance discount is applied to VM 0. For that VM, the customer is only being charged for other components such as disks and networking. The other unused instance is charged at the PAYG rate for the VM size reserved.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
