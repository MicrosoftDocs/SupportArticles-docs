---
title: Request canceled while waiting for connection
description: Learn to resolve a scenario in which a request is canceled while waiting for a connection when you pull an image or artifact from Azure Container Registry.
ms.date: 07/08/2024
author: AndreiBarbu95
ms.author: andbar
editor: v-jsitser
ms.reviewer: v-rekhanain, v-leedennis
ms.service: container-instances
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Image Pull Issues
#Customer intent: As an Azure user, I want to fix a "net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)" error so that I can successfully pull a container image or artifact from Azure Container Registry.
---
# "Request canceled while waiting for connection" error

This article discusses how to fix a time-out scenario that occurs when you try to pull a container image or artifact from Azure Container Registry.

## Prerequisites

- The [telnet](/windows-server/administration/windows-commands/telnet) tool
- The [NetCat](https://linux.die.net/man/1/nc) (`nc`) tool

## Symptoms

You receive the following error message:

> Get "https\://\<container-registry-name>.azurecr.io/v2/": net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)

## Cause 1: Port 443 is unavailable on the sign-in server

Authentication and registry management operations are handled through the registry's public sign-in server, but communication through port 443 doesn't work successfully.

> [!NOTE]
> The Azure Container Registry sign-in server is also known as the Registry REST API endpoint. This sign-in server has a domain name format of `<container-registry-name>.azurecr.io`.

To manually test the connectivity between your device and the Azure Container Registry sign-in server on port 443, run the telnet or NetCat command:

```cmd
telnet <container-registry-name>.azurecr.io 443
```

```cmd
nc -vz <container-registry-name>.azurecr.io 443
```

### Solution 1: Make port 443 available for communication between the device and the sign-in server

Make sure that networking connectivity exists between the device and the Azure Container Registry sign-in server over port 443.

If your device is part of a restricted network architecture, make sure that it has networking connectivity with the Azure Container Registry sign-in server over port 443. You can consider checking potential existing firewalls, proxy servers, access control lists, internet service provider (ISP) restrictions, and so on.

## Cause 2: Communication is blocked by an NSG that's associated with the network adapter or subnet of a VM

If you're using an Azure virtual machine (VM) to pull from Azure Container Registry, a [network security group](/azure/virtual-network/network-security-groups-overview) (NSG) might be blocking communication between the device and the sign-in server. The blocking NSG is associated with the network adapter or subnet of the Azure VM.

Run the telnet or NetCat command that's shown in [Cause 1](#cause-1-port-443-is-unavailable-on-the-sign-in-server). If the command output shows that a time-out occurred, check whether the NSG configuration blocks the IP address of the storage account. To do this, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select [Network Watcher](/azure/network-watcher/network-watcher-overview).
1. In the **Network Watcher** menu pane, select **Network diagnostic tools** > **NSG Diagnostics**.
1. On the **Network Watcher | NSG diagnostics** page, complete the form by following the instructions in the following table.

   | Field                      | Action                                                          |
   |----------------------------|-----------------------------------------------------------------|
   | **Target resource type**   | Select **Virtual machine** in the list.                         |
   | **Virtual machine**        | Enter or select the name of your Azure VM in the list.          |
   | **Protocol**               | Select **TCP** in the list.                                     |
   | **Direction**              | Select the **Outbound** option.                                 |
   | **Source type**            | Select **IPv4 address/CIDR** in the list.                       |
   | **IPv4 address/CIDR**      | Enter the IP address of the Azure VM.                           |
   | **Destination IP address** | Enter the IP address of the Azure Container Registry.           |
   | **Destination port**       | Enter **443**.                                                  |

1. Select the **Run NSG diagnostic** button.
1. In the **Results** box, check the value of the **Traffic status** field.

The **Traffic status** field can have a value of **Allowed** or **Denied**. The **Denied** status means that the NSG is blocking the traffic between the Azure VM and the Azure Container Registry. In this case, the name of the blocking NSG is also shown in the **Results** box. In the result table, locate the **NSG name** column for the row in which the corresponding **Applied action** column's value is **Deny**.

### Solution 2: Modify the NSG configuration to allow connectivity between the VM and the Azure Container Registry

Make changes at the NSG level so that connectivity is allowed between the Azure VM and the Azure Container Registry on port 443. Specifically, make sure that the following conditions are met.

| Condition | More information |
|--|--|
| The route table doesn't drop traffic toward the Azure Container Registry sign-in server. The traffic is dropped if the next hop is set to **None** for a route that's associated with the Azure Container Registry sign-in server. | [Virtual network traffic routing](/azure/virtual-network/virtual-networks-udr-overview) |
| If the route table sends the traffic toward a virtual appliance, such as a firewall that's associated with the Azure VM subnet, make sure that the firewall doesn't block traffic to the Azure Container Registry sign-in server on port 443. | [Configure rules to access an Azure container registry behind a firewall](/azure/container-registry/container-registry-firewall-access-rules) |

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
