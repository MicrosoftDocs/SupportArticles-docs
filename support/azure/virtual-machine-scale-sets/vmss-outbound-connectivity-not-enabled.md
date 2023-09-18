---
title: No outbound connectivity configured for virtual machine
description: Learn how to resolve the OutboundConnectivityNotEnabledOnVM error when you deploy a Virtual Machine Scale Set by using Flexible orchestration mode.
ms.date: 01/31/2023
ms.service: virtual-machine-scale-sets
ms.subservice: troubleshoot-deployment-errors
ms.reviewer: mimckitt, v-leedennis
---
# "OutboundConnectivityNotEnabledOnVM. No outbound connectivity configured for virtual machine"

This article discusses how to resolve the `OutboundConnectivityNotEnabledOnVM` error that occurs when you deploy a Microsoft Azure Virtual Machine Scale Set by using Flexible orchestration mode.

## Symptoms

When you deploy a [Virtual Machine Scale Set by using Flexible orchestration mode](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes#scale-sets-with-flexible-orchestration), you receive the following error message:

> OutboundConnectivityNotEnabledOnVM. No outbound connectivity configured for virtual machine.

## Cause

You tried to create a Virtual Machine Scale Set in Flexible orchestration mode without having an outbound internet connection.

## Solution

Enable secure outbound access for your Virtual Machine Scale Set by using a method that's best suited for your application. Outbound access can be enabled by using one of the following methods:

- Use a [Network Address Translation (NAT) Gateway](/azure/virtual-network/nat-gateway/nat-gateway-resource) on your subnet.

- Add [scale set instances to a Load Balancer backend pool](/azure/load-balancer/load-balancer-multiple-virtual-machine-scale-set#add-virtual-machine-scale-set-to-an-azure-load-balancers-backend-pool).

- Add an explicit [public IP address](/azure/virtual-network/ip-services/public-ip-addresses) per scale set instance.

For highly secure applications, you can specify custom [user-defined routes](/azure/virtual-network/virtual-networks-udr-overview#user-defined) through your firewall or virtual network applications. For more information, see [Default outbound access in Azure](/azure/virtual-network/ip-services/default-outbound-access).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
