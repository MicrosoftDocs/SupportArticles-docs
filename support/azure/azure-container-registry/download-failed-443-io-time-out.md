---
title: I/O time-out error message in Azure Container Registry
description: Learn how to resolve an I/O time-out error that occurs when you try to access Azure Container Registry to pull a container image or artifact.
ms.date: 07/08/2024
author: AndreiBarbu95
ms.author: andbar
editor: v-jsitser
ms.reviewer: v-rekhanain, v-leedennis
ms.service: container-instances
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Image Pull Issues
#Customer intent: As an Azure user, I want to fix an I/O time-out error so that I can successfully pull a container image or artifact from Azure Container Registry.
---
# "I/O time-out" error when trying to access Azure Container Registry

This article discusses how to resolve an I/O time-out error that occurs when you try to access Azure Container Registry to pull a container image or artifact.

## Symptoms

You receive the following error message:

> error pulling image configuration: download failed after attempts=6: dial tcp \<storage-endpoint-ip-address>:443: i/o timeout

## Cause 1: Port 443 is unavailable on the storage (data) endpoint

> [!NOTE]
> Don't assume that the storage endpoint IP address that's shown in the error message is the IP address that's always used during pull operations. Other IP addresses are also involved, and you have to allow the traffic accordingly. We recommend that you don't allow traffic based on specific IP addresses. This is because IP addresses are dynamic, and the list of used IP addresses changes. We recommend that you allow the `<storage-account-name>.blob.core.windows.net` domain. Alternatively, you can use [Azure Container Registry data endpoints](/azure/container-registry/container-registry-dedicated-data-endpoints) and allow those data endpoints in the client network rules. If (and only if) there aren't any other options, we recommend that you allow traffic based on IP addresses.

Azure [allocates blob storage](/azure/container-registry/container-registry-storage) in Azure Storage accounts on behalf of each registry to manage data for container images and other artifacts. When a client accesses image layers in a container registry, it makes requests by using a storage account endpoint that the registry provides.

The domain name of the default storage (data) endpoint depends on whether you're using [dedicated data endpoints](/azure/container-registry/container-registry-dedicated-data-endpoints), as shown in the following table.

| Dedicated data endpoints in use? | Domain name format of default storage (data) endpoint     |
|----------------------------------|-----------------------------------------------------------|
| Yes                              | `<container-registry-name>.<region-name>.data.azurecr.io` |
| No                               | `<storage-account-name>.blob.core.windows.net`            |

To manually test the connectivity between your device and the storage (data) endpoint on port 443, run the telnet or NetCat command. If dedicated data endpoints are used, choose one of the following commands:

- Telnet command:

  ```cmd
  telnet <container-registry-name>.<region-name>.data.azurecr.io 443
  ```

- NetCat command:

  ```cmd
  nc -vz <container-registry-name>.<region-name>.data.azurecr.io 443
  ```

If dedicated data endpoints aren't used, choose one of the following commands:

- Telnet command:

  ```cmd
  telnet <storage-account-name>.blob.core.windows.net 443
  ```

- NetCat command:

  ```cmd
  nc -vz <storage-account-name>.blob.core.windows.net 443
  ```

### Solution 1: Make port 443 available for communication between the device and the storage (data) endpoint

Make sure that there's networking connectivity between the device and the storage (data) endpoint over port 443.

If your device is part of a restricted network architecture, make sure that it has networking connectivity with the storage (data) endpoint over port 443. You can consider checking potential existing firewalls, proxy servers, access control lists, internet service provider (ISP) restrictions, and so on.

> [!NOTE]
> The storage (data) endpoint includes many IP address ranges. You have to allow all of them, not just a few. You can allow all the IP address ranges or use a [service tag](/azure/virtual-network/service-tags-overview). For example, the service tag `Storage` represents Azure Storage for the entire cloud, but `Storage.<region-name>` (such as `Storage.WestUS`) narrows the range to only the storage IP address ranges from the named region.

## Cause 2: Communication is blocked by an NSG that's associated with the NIC or subnet of a VM

If you're using an Azure virtual machine (VM) to pull from Azure Container Registry, a [network security group](/azure/virtual-network/network-security-groups-overview) (NSG) might be blocking communication between the device and the sign-in server. The blocking NSG is associated with the network adapter or subnet of the Azure VM.

Run the telnet or NetCat command that's shown in [Cause 1](#cause-1-port-443-is-unavailable-on-the-storage-data-endpoint). If the command output shows that a time-out occurred, check whether the NSG configuration blocks the IP address of the storage account. To do this, follow these steps:

1. Go to [Azure IP Ranges and Service Tags – Public Cloud](https://www.microsoft.com/download/details.aspx?id=56519), and then select the **Download** button to download the list of service tags as a JSON file.
1. Open the downloaded JSON file in a text editor, and then search for `Storage.<region-name>`. (Replace the `<region-name>` placeholder with the name of the region that contains your container registry, such as `BrazilSoutheast`.)
1. Choose an IP address that's allowable for use in that region. (You'll use this IP address in step 6 as the associated storage (data) endpoint IP address.)
1. In the [Azure portal](https://portal.azure.com), search for and select [Network Watcher](/azure/network-watcher/network-watcher-overview).
1. In the **Network Watcher** menu pane, select **Network diagnostic tools** > **NSG Diagnostics**.
1. In the **Network Watcher | NSG diagnostics** page, complete the form by following the instructions in the following table.

   | Field                      | Action                                                                            |
   |----------------------------|-----------------------------------------------------------------------------------|
   | **Target resource type**   | Select **Virtual machine** in the list.                                           |
   | **Virtual machine**        | Enter or select the name of your Azure VM in the list.                            |
   | **Protocol**               | Select **TCP** in the list.                                                       |
   | **Direction**              | Select the **Outbound** option.                                                   |
   | **Source type**            | Select **IPv4 address/CIDR** in the list.                                         |
   | **IPv4 address/CIDR**      | Enter the IP address of the Azure VM.                                             |
   | **Destination IP address** | Enter the associated storage (data) endpoint IP address that you chose in step 3. |
   | **Destination port**       | Enter **443**.                                                                    |

1. Select the **Run NSG diagnostic** button.
1. In the **Results** box, check the value of the **Traffic status** field.

The **Traffic status** field can have a value of **Allowed** or **Denied**. The **Denied** status means that the NSG is blocking the traffic between the Azure VM and the associated storage (data) endpoint IP address that you chose. In this case, the name of the blocking NSG is also shown in the **Results** box. In the result table, locate the **NSG name** column for the row in which the corresponding **Applied action** column's value is **Deny**.

> [!NOTE]
> This procedure can give you a better, but still incomplete, assessment of what's causing the issue. Thsi is because it instructs you to test the connectivity by using a single IP address of Azure Storage from the associated region. However, because the storage (data) endpoint must allow access for many IP address ranges, a successful test of a single IP address doesn't mean that communication is successful for all IP address ranges.

### Solution 2: Modify the NSG configuration to allow connectivity between the VM and the associated storage (data) endpoint

Make changes at the NSG level so that connectivity is allowed on port 443 between the Azure VM and the associated storage (data) endpoint (all the IP address ranges or the associated service tag). Specifically, make sure that the following conditions are met.

| Condition | More information |
|--|--|
| The route table doesn't drop traffic toward the storage (data) endpoint. The traffic is dropped if the next hop is set to **None** for a route that's associated with the storage (data) endpoint. | [Virtual network traffic routing](/azure/virtual-network/virtual-networks-udr-overview) |
| If the route table sends the traffic toward a virtual appliance, such as a firewall that's associated with the Azure VM subnet, make sure that the firewall doesn't block traffic to the storage (data) endpoint on port 443. | [Configure rules to access an Azure container registry behind a firewall](/azure/container-registry/container-registry-firewall-access-rules) |

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
