---
title: Can't delete a virtual network in Azure
description: Learn how to troubleshoot the issue in which you can't delete a virtual network in Azure.
services: virtual-network
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.service: azure-virtual-network
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom:
  - fasttrack-edit
  - sfi-image-nochange
  - = sap:Connectivity
# Customer intent: As a cloud administrator, I want to troubleshoot the deletion of a virtual network, so that I can resolve any issues preventing its removal and maintain the efficiency of my cloud resources.
---

# Troubleshooting: Failed to delete a virtual network in Azure

## Summary

You might receive errors when you try to delete a virtual network in Microsoft Azure. This article provides troubleshooting steps to help you resolve this problem.

If your Azure issue is not addressed in this article, visit the Azure forums on [Microsoft Q & A](https://azure.microsoft.com/support/forums) and [Stack Overflow](https://stackoverflow.com/questions/tagged/azure). You can post your issue in these forums, or post to [@AzureSupport](https://twitter.com/AzureSupport) on Twitter. You also can submit an Azure support request. To submit a support request, on the [Azure support page](https://azure.microsoft.com/en-us/support), select **Get support**.

## Troubleshooting guidance 

1. [Check whether a virtual network gateway is running in the virtual network](#check-whether-a-virtual-network-gateway-is-running-in-the-virtual-network).
2. [Check whether an application gateway is running in the virtual network](#check-whether-an-application-gateway-is-running-in-the-virtual-network).
3. [Check whether Azure container instances still exist in the virtual network](#check-whether-azure-container-instances-still-exist-in-the-virtual-network).
4. [Check whether Microsoft Entra Domain Service is enabled in the virtual network](#check-whether-azure-active-directory-domain-service-is-enabled-in-the-virtual-network).
5. [Check whether the virtual network is connected to other resources](#check-whether-the-virtual-network-is-connected-to-other-resources).
6. [Check whether a virtual machine is still running in the virtual network](#check-whether-a-virtual-machine-is-still-running-in-the-virtual-network).
7. [Check whether the virtual network is stuck in migration](#check-whether-the-virtual-network-is-stuck-in-migration).
8. [Check whether the virtual network was used by a web app for virtual network integration](#check-whether-the-virtual-network-was-used-by-a-web-app-for-virtual-network-integration).

## Troubleshooting steps

### Check whether a virtual network gateway is running in the virtual network

To remove the virtual network, you must first remove the virtual network gateway.

For classic virtual networks, go to the **Overview** page of the classic virtual network in the Azure portal. In the **VPN connections** section, if the gateway is running in the virtual network, the IP address of the gateway is shown. 

![Check whether gateway is running](media/virtual-network-troubleshoot-cannot-delete-vnet/classic-gateway.png)

For virtual networks, go to the **Overview** page of the virtual network. Check **Connected devices** for the virtual network gateway.

![Screenshot of the list of Connected devices for a virtual network in Azure portal. The Virtual network gateway is highlighted in the list.](media/virtual-network-troubleshoot-cannot-delete-vnet/vnet-gateway.png)

Before you can remove the gateway, first remove any **Connection** objects in the gateway. 

### Check whether an application gateway is running in the virtual network

Go to the **Overview** page of the virtual network. Check the **Connected devices** for the application gateway.

![Screenshot of the list of Connected devices for a virtual network in Azure portal. The Application gateway is highlighted in the list.](media/virtual-network-troubleshoot-cannot-delete-vnet/app-gateway.png)

If there's an application gateway, you must remove it before you can delete the virtual network.

### Check whether Azure container instances still exist in the virtual network

1. In the Azure portal, go to the resource group's **Overview** page.
1. In the header for the list of the resource group's resources, select **Show hidden types**. The network profile type is hidden in the Azure portal by default.
1. Select the network profile related to the container groups.
1. Select **Delete**.

   ![Screenshot of the list of hidden network profiles.](media/virtual-network-troubleshoot-cannot-delete-vnet/container-instances.png)

1. Delete the subnet or virtual network again.

If these steps don't resolve the issue, use these [Azure CLI commands](/azure/container-instances/container-instances-vnet#clean-up-resources) to clean up resources. 

<a name='check-whether-azure-active-directory-domain-service-is-enabled-in-the-virtual-network'></a>

### Check whether Microsoft Entra Domain Service is enabled in the virtual network

If the Active Directory Domain Service is enabled and connected to the virtual network, you can't delete this virtual network. 

To disable the service, see [Disable Microsoft Entra Domain Services using the Azure portal](/entra/identity/domain-services/delete).

### Check whether the virtual network is connected to other resources

Check for Circuit Links, connections, and virtual network peerings. Any of these can cause a virtual network deletion to fail. 

The recommended deletion order is as follows:

1. Gateway connections
2. Gateways
3. IPs
4. Virtual network peerings
5. App Service Environment (ASE)

### Check whether a virtual machine is still running in the virtual network

Make sure that no virtual machine is in the virtual network.

### Check whether the virtual network is stuck in migration

If the virtual network is stuck in a migration state, it can't be deleted. Run the following command to abort the migration, and then delete the virtual network.

```azurepowershell
Move-AzureVirtualNetwork -VirtualNetworkName "Name" -Abort
```

### Check whether the virtual network was used by a web app for virtual network integration

If the virtual network was integrated with a web app in the past, then the web app was deleted without disconnecting the virtual network integration, see [Deleting the App Service plan or web app before disconnecting the virtual network integration](/azure/azure-functions/functions-networking-options?tabs=azure-portal#troubleshooting).

## Next steps

- [Azure Virtual Network](/azure/virtual-network/virtual-networks-overview)
- [Azure Virtual Network frequently asked questions (FAQ)](/azure/virtual-network/virtual-networks-faq)