---
title: Can't get private IP address of an Azure Container Registry FQDN
description: Learn how to resolve a scenario in which the fully qualified domain name (FQDN) of an Azure Container Registry can't be resolved to its private IP address.
ms.date: 05/24/2024
author: AndreiBarbu95
ms.author: andbar
editor: v-jsitser
ms.reviewer: v-rekhanain, v-leedennis
ms.service: container-instances
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Connectivity
#Customer intent: As an Azure administrator, I want to learn how to resolve a scenario in which the fully qualified domain name (FQDN) of an Azure Container Registry can't be resolved to its private IP address so that I can successfully use the container registry when I have to rely on only private connectivity.
---
# Can't get private IP address of an Azure Container Registry FQDN

This article provides guidance for troubleshooting the most common situations that can prevent you from resolving the fully qualified domain name (FQDN) of a Microsoft Azure Container Registry to its private IP address.

## Overview

In Azure Container Registry, you can use [Azure Private Link](/azure/private-link/private-link-overview) together with a private endpoint and a [private DNS zone](/azure/dns/private-dns-privatednszone) to assign a virtual network private IP address to the registry FQDN (also known as the login server or REST API endpoint).

Because the Azure Container Registry service is multitenant, it always has a public IP address. If you set your container registry to use the Private Link technology for the registry FQDN, your container registry is issued a public IP address and a private IP address.

After you set up this configuration, there are situations in which the DNS resolution of your container registry FQDN returns the public IP address even though you expect  the DNS resolution to return the private IP address. This scenario can cause many issues, such as pull failure, if public access to your container registry is disabled and you rely on only the private connectivity.

> [!NOTE]
>
> To verify that your container registry is configured for private use, follow these steps:
>
> 1. In the [Azure portal](https://portal.azure.com), search for and select **Container registries**.
>
> 1. In the list of container registries, select the name of your container registry.
>
> 1. In the menu pane of your container registry, select **Settings** > **Networking**.
>
> 1. On the **Public access** tab, verify that the **Public network access** field is set to **Disabled**.
>
> 1. Select the **Private access** tab, and verify that a private endpoint connection is set up.

## Symptoms

You use a Domain Name System (DNS) utility tool to do a DNS query and obtain the *public* IP address of the container registry in the query results. However, the container registry actually is configured for private use, and the DNS query result indicates that the container registry is configured for private use.

> [!NOTE]
> A container registry is configured for private use if the canonical name is in the form, `<container-registry-name>.privatelink.azurecr.io`.

For example, the following [nslookup](/windows-server/administration/windows-commands/nslookup) command does a DNS query on the `acrpe332.azurecr.io` container registry FQDN:

```cmd
nslookup acrpe332.azurecr.io
```

The nslookup output returns a canonical name of `acrpe332.privatelink.azurecr.io`, so you know that the `acrpe332` container registry is configured for private use. However, the output also returns a public IP address of `20.62.128.38` for the `acrpe332` container registry FQDN:

```output
Server:         168.63.129.16
Address:        168.63.129.16#53

Non-authoritative answer:
acrpe332.azurecr.io     canonical name = acrpe332.privatelink.azurecr.io.
acrpe332.privatelink.azurecr.io canonical name = eus1.fe.azcr.io.
eus1.fe.azcr.io canonical name = eus-acr-reg.trafficmanager.net.
eus-acr-reg.trafficmanager.net  canonical name = r0318eus-az.eastus.cloudapp.azure.com.
Name:   r0318eus-az.eastus.cloudapp.azure.com
Address: 20.62.128.38
```

> [!NOTE]
> This example uses the [Azure DNS service (`168.63.129.16`)](/azure/virtual-network/what-is-ip-address-168-63-129-16) as the DNS server. If you use a custom DNS server, the server displays its IP address together with the `Server` and `Address` fields.

## Cause 1: Container registry's private endpoint and the device are on different virtual networks

The network interface of the container registry's private endpoint is on a different virtual network than the device that tries to resolve the container registry FQDN.

### Solution 1: Link to the device's virtual network from the private DNS zone level of the container registry

To successfully query for DNS records in the private DNS zone, add a [virtual network link](/azure/dns/private-dns-virtual-network-links) at the container registry's private DNS zone level for the virtual network on which the device that initiates the DNS query exists. This device can be any of the following items:

- Azure Kubernetes Service (AKS) nodes
- Azure Virtual Machines
- Azure Web App for Containers
- Other type of device

To add the virtual network link to the device's virtual network from the private DNS zone level of the container registry, use one of the following methods:

- Through the Azure portal

  1. In the [Azure portal](https://portal.azure.com), search for and select **Private DNS zones**.

  1. In the list of private DNS zones, select **\<container-registry-name>.privatelink.azurecr.io**.

  1. In the menu pane of your private DNS zone, select **Settings** > **Virtual network link**.

  1. In the **Virtual network links** page of your private DNS zone, select **Add**.

  1. In the **Add virtual network link** page, enter a **Link name**, and then select the **Virtual network** of the device that has to resolve the FQDN of the container registry privately. (The **Enable auto registration** option is optional.)

  1. Select the **OK** button.

- Through Azure CLI

  In Azure CLI, run the [az network private-dns link vnet create](/cli/azure/network/private-dns/link/vnet#az-network-private-dns-link-vnet-create) command.

## Cause 2: Your custom DNS server doesn't forward to the Azure DNS service

By default, Azure virtual networks use the Azure DNS service (`168.63.129.16`) as the DNS server, but you can alternatively use your own custom DNS server. However, when you tried to set up your own custom DNS server, you forgot to set a server-level forwarder to the Azure DNS service at the custom DNS server level.

### Solution 2: Configure a server-level forwarder to the Azure DNS service

If the device that you expect to resolve the container registry's FQDN over a private IP address is part of an Azure virtual network that uses a custom DNS server, you have to configure a server-level forwarder to the Azure DNS service at the custom DNS server. The exact configuration options and steps depend on your existing networks and DNS (for example, Windows Server, CoreDNS, and so on).

## Cause 3: Your custom DNS server doesn't link privately to the container registry

By default, Azure virtual networks use the Azure DNS service (`168.63.129.16`) as the DNS server, but you can alternatively use your own custom DNS server. When you tried to set up your own custom DNS server, you correctly set a server-level forwarder to the Azure DNS service at the custom DNS server level. However, you forgot to add a virtual network link at the private DNS zone level of the container registry for the virtual network on which the custom DNS server exists.

### Solution 3: Link to the custom DNS server from the private DNS zone level of the container registry

To add the virtual network link to the custom DNS server from the private DNS zone level of the container registry, use one of the following methods:

- Through the Azure portal

  1. In the [Azure portal](https://portal.azure.com), search for and select **Private DNS zones**.

  1. In the list of private DNS zones, select **\<container-registry-name>.privatelink.azurecr.io**.

  1. In the menu pane of your private DNS zone, select **Settings** > **Virtual network link**.

  1. In the **Virtual network links** page of your private DNS zone, select **Add**.

  1. In the **Add virtual network link** page, enter a **Link name** value, and then select the appropriate **Virtual network** value for the custom DNS server. (The **Enable auto registration** option is optional.)

  1. Select the **OK** button.

- Through Azure CLI

  In Azure CLI, run the [az network private-dns link vnet create](/cli/azure/network/private-dns/link/vnet#az-network-private-dns-link-vnet-create) command.

## Resources

- [Connect privately to an Azure container registry using Azure Private Link](/azure/container-registry/container-registry-private-link)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
