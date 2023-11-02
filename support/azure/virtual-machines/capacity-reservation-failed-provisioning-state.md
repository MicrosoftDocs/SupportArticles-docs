---
title: A Capacity Reservation is in a "Failed" provisioning state
description: The following article discusses how to resolve the situation of a Capacity Reservation being in a "failed" provisioning state.
ms.date: 08/26/2021
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-capacity-reservation
ms.collection: windows
---

# A Capacity Reservation is in a "Failed" provisioning state

The following article discusses how to resolve the situation of a Capacity Reservation being in a "failed" provisioning state.

## Why Capacity Reservation in "failed" provisioning State

In a rare circumstance, it's possible that an existing Capacity Reservation enters a "Failed" provisioning state. This situation occurs as a result of a system error or a customer-initiated action such as modifying the quantity reserved. In most situations, re-trying the reservation can fix the issue. However, in case the Capacity Reservation enters a "failed" provisioning state as a result of increasing the quantity reserved, re-trying the reservation may not fix the issue. In this situation, follow the steps below to restore the reservation:

## Steps to resolve the issue

1. In the [Microsoft Azure portal](https://ms.portal.azure.com/), go to the [Application Change Analysis](https://ms.portal.azure.com/#blade/Microsoft_Azure_ChangeAnalysis/ChangeAnalysisBaseBlade) screen.

1. Select the subscription, resource group, and time range from the filters at the top of the page.

   > [!NOTE]
   > You can only view up to 14 days in the past.

1. In the search box, type in the name of the capacity reservation and look for the change in `sku.capacity` property for that reservation. Find the original Capacity Reservation quantity reserved. This value is located in the *Old Value* column.

   :::image type="content" source="media/capacity-reservation-failed-provisioning-state/options-sku-capacity.png" alt-text="Screenshot of the Application Change Analysis blade, with both the options and sku capacity highlighted.":::

1. Follow the steps at [Modify Capacity Reservations](/azure/virtual-machines/capacity-reservation-modify) to update the Capacity Reservation to the previous reserved quantity. Once updated, the reservation will be immediately available for use with virtual machines (VMs).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
