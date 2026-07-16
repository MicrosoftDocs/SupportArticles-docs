---
title: Reset a failed circuit - Azure ExpressRoute
description: Learn how to reset a failed ExpressRoute circuit in Azure to quickly restore connectivity and service availability. Follow the steps to resolve issues now.
services: expressroute
author: kaushika-msft
ms.author: kaushika
ms.service: azure-expressroute
ms.topic: troubleshooting
ms.date: 06/30/2023
ms.custom:
  - devx-track-azurepowershell
  - sfi-image-nochange
  - sap:Connectivity & Performance Issues
# Customer intent: As a network administrator, I want to reset a failed ExpressRoute circuit, so that I can restore connectivity and ensure my application services are running smoothly.
---

# Reset a failed Azure ExpressRoute circuit

## Summary

If an operation on an ExpressRoute circuit fails, the circuit can enter a `failed` state. This article shows how to reset a failed Azure ExpressRoute circuit to restore connectivity quickly.

## Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com) with your Azure account.

1. Search for **ExpressRoute circuits** in the search box at the top of the portal.

1. Select the ExpressRoute circuit that you want to reset.

1. Select **Refresh** from the top menu.

    :::image type="content" source="./media/reset-circuit/refresh-circuit.png" alt-text="Screenshot of refresh button for an ExpressRoute circuit."::: 

## Azure PowerShell

The steps and examples in this article use Azure PowerShell Az modules. To install the Az modules locally on your computer, see [Install Azure PowerShell](/powershell/azure/install-azure-powershell). To learn more about the new Az module, see [Introducing the new Azure PowerShell Az module](/powershell/azure/new-azureps-module-az). PowerShell cmdlets are updated frequently. If you're not running the latest version, the values specified in the instructions might not work. To find the installed versions of PowerShell on your system, use the `Get-Module -ListAvailable Az` cmdlet.

1. Install the latest version of the Azure Resource Manager PowerShell cmdlets. For more information, see [Install and configure Azure PowerShell](/powershell/azure/install-azure-powershell).

1. Open your PowerShell console with elevated privileges, and connect to your account. Use the following example to help you connect:

   ```azurepowershell-interactive
   Connect-AzAccount
   ```
1. If you have multiple Azure subscriptions, check the subscriptions for the account.

   ```azurepowershell-interactive
   Get-AzSubscription
   ```
1. Specify the subscription that you want to use.

   ```azurepowershell-interactive
   Select-AzSubscription -SubscriptionName "Replace_with_your_subscription_name"
   ```
1. Run the following commands to reset a circuit that's in a failed state:

   ```azurepowershell-interactive
   $ckt = Get-AzExpressRouteCircuit -Name "ExpressRouteARMCircuit" -ResourceGroupName "ExpressRouteResourceGroup"

   Set-AzExpressRouteCircuit -ExpressRouteCircuit $ckt
   ```

The circuit is now healthy. Open a support ticket with [Microsoft support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) if the circuit is still in a failed state.

## Next steps

Open a support ticket with [Microsoft support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) if you're still experiencing issues.