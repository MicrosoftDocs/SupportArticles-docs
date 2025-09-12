---
title: Troubleshoot connections to endpoints outside the virtual network
description: Troubleshoot connections to endpoints outside the virtual network (through the public internet) from an Azure Kubernetes Service (AKS) cluster.
ms.date: 10/18/2024
ms.reviewer: chiragpa, rissing, jaewonpark, v-leedennis, v-weizhu
editor: v-jsitser
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot connections to endpoints outside the virtual network so that I don't experience outbound connection issues from an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Connectivity
---
# Troubleshoot connections to endpoints outside the virtual network

This article discusses how to troubleshoot connections to endpoints outside the virtual network (that is, through the public internet) from a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli).

- The client URL ([curl](https://techcommunity.microsoft.com/t5/containers/tar-and-curl-come-to-windows/ba-p/382409)) tool.

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster. To install kubectl by using Azure CLI, run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Troubleshooting checklist

### Is the issue persistent?

#### Step 1: Do basic troubleshooting

Make sure that you can connect to public endpoints on the internet. For instructions, see [Basic troubleshooting of outbound AKS cluster connections](basic-troubleshooting-outbound-connections.md).

#### Step 2: Determine the outbound type for the AKS cluster

To identify the outbound type of the AKS cluster, run the [az aks show](/cli/azure/aks#az-aks-show) command:

```azurecli
az aks show --resource-group <resource_group> --name <cluster_name> --query "networkProfile.outboundType"
```

If the outbound type is `loadBalancer`, there's no route table unless you use *kubenet* network. If you use *kubenet*, make sure that the default route table has no additional configuration that blocks outbound internet connection. If you use another network, such as Azure CNI, Dynamic Allocation, or Azure CNI Overlay, no route table is created by default. In this case, make sure the NSG (network security group) has no custom configuration that blocks outbound internet connection. 

If the outbound type is `userDefinedRouting`, make sure that the following conditions are met:

- The egress device (firewall or proxy) is reachable.

- The egress device allows the [required outbound traffic](/azure/aks/limit-egress-traffic#required-outbound-network-rules-and-fqdns-for-aks-clusters) from the cluster.

  To get the list of FQDNs that are allowed for your AKS cluster, run the [az aks egress-endpoints list](/cli/azure/aks/egress-endpoints#az-aks-egress-endpoints-list) command:

  ```azurecli
  az aks egress-endpoints list --resource-group <resource_group> --name <cluster_name>
  ```

If the outbound type is `managedNATGateway`, check whether the AKS subnet is associated with the NAT gateway by running the [az network nat gateway show](/cli/azure/network/nat/gateway#az-network-nat-gateway-show) command:

```azurecli
az network nat gateway show --resource-group <resource_group> --name <nat_gateway_name> --query "subnets[].id"
```

For more information about how to use a NAT gateway together with AKS, see [Managed NAT gateway](/azure/aks/nat-gateway).

#### Step 3: Examine the curl output when you connect to the application pod

The curl response codes can help you identify the issue type. After the response code becomes available, try to better understand how the issue behaves. For more information about the HTTP status codes and the underlying behavior of the issue, refer to the following table.

| Information source | Link |
|:-|:-|
| Internet Assigned Numbers Authority (IANA) | [Hypertext Transfer Protocol (HTTP) status code registry](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml) |
| Mozilla | [HTTP response status codes](https://developer.mozilla.org/docs/Web/HTTP/Status) |
| Wikipedia | [List of HTTP status codes](https://wikipedia.org/wiki/List_of_HTTP_status_codes) |

The following HTTP status codes might indicate the listed issues.

| HTTP status code | Issue | Example |
|--|--|--|
| `4xx` | <ol> <li>An issue affects the client request.</li> <li>A network blocker exists between the client and the server.</li> </ol> | <ol> <li>The requested page doesn't exist, or the client doesn't have permission to access the page.</li> <li>Traffic is being blocked by a network security group or a firewall.</li> </ol> |
| `5xx` | An issue affects the server. | The application is down, or a gateway isn't working. |

You can try to connect to the application endpoint using curl. Here's an example command and output:

```bash
# 404 error code example
$ curl -vv <host IP address>/test.index

*   Trying <host IP address>:80...
* TCP_NODELAY set
* Connected to <host IP address> (<host IP address>) port 80 (#0)
> GET /test.index HTTP/1.1
> Host: <host IP address>
> User-Agent: curl/7.68.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 404 Not Found
...
* Connection #0 to host <host IP address> left intact
```

#### Step 4: Check what happens if outbound traffic bypasses the virtual appliance temporarily 

For quick testing to determine whether the egress device (virtual appliance) causes the issue, you can temporarily allow all traffic to go through the internet. To configure this setup, you can change the default IP address and port route of `0.0.0.0`/`0` through the virtual appliance to go through the internet instead.

If the egress device works well when bypassing the virtual appliance, check the logs of the virtual appliance to see which packets are denied and add allow rules in the virtual appliance accordingly.

### Is the issue intermittent?

You may experience intermittent outbound issues for many reasons. For troubleshooting intermittent outbound connection issues, try the following steps:

#### Step 1: Check if the pod or node resources are exhausted

Run the following commands to check how much the resources are used:

```bash
kubectl top pods
kubectl top nodes
```

#### Step 2: Check if the operating system disk is used heavily

To check whether the operating system disk is used heavily, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual machine scale sets**.

1. In the list of scale sets, select the scale set that's used for your AKS cluster.

1. In the scale set navigation pane, go to the **Monitoring** section, and then select **Metrics**.

1. View the disk metrics for the scale set from the **Metrics** section by looking for the following fields.

   | Field             | Value                       |
   |-------------------|-----------------------------|
   | Scope             | **VMSS Name**               |
   | Metrics Namespace | **Virtual Machine Host**    |
   | Metrics           | **OS and Data Disk Metric** |

For more information about metrics, see [OS Disk and Data Disk metrics](/azure/virtual-machines/disks-metrics).

To view AKS recommendations about disk utilization, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Kubernetes services**.

1. In the list of Kubernetes services, select the name of your AKS cluster.

1. In the AKS cluster navigation pane, go to the **Monitoring** section, and then select **Advisor recommendations**.

1. Review the listed recommendations about disk usage.

If the OS disk is used heavily, consider using the following remedies:

- Increase the OS disk size.

- Switch to [Ephemeral OS disks](/azure/aks/cluster-configuration#ephemeral-os).

If these remedies don't resolve the issue, analyze the process that does heavy read/write operations on the disk. Then, check whether you can move the actions to a data disk instead of the OS disk.

#### Step 3: Check if the source network address translation port is exhausted

If applications are making many outbound connections, they may exhaust the number of available ports on the outbound device's IP address. Follow [Standard load balancer diagnostics with metrics, alerts, and resource health](/azure/load-balancer/load-balancer-standard-diagnostics) to monitor the usage and allocation of your existing load balancer's [source network address translation (SNAT) port](/azure/load-balancer/load-balancer-outbound-connections#what-are-snat-ports). Monitor to verify or determine the risk of [SNAT port exhaustion](/azure/load-balancer/load-balancer-outbound-connections#port-exhaustion).

Are you reaching or exceeding the maximum number of allocated SNAT ports? In that case, you can check your application to determine whether it's reusing existing connections. For more information, see [Design your applications to use connections efficiently](/azure/load-balancer/troubleshoot-outbound-connection#design-your-applications-to-use-connections-efficiently).

If you feel that the application is configured correctly, and you do need more SNAT ports than the default number of allocated ports, follow these steps:

1. Increase the number of public IPs on the egress device. If the egress device is the load balancer, you can [Increase the number of public IP addresses on the load balancer](/azure/aks/load-balancer-standard#scale-the-number-of-managed-outbound-public-ips).

1. [Increase the ports per node for your AKS worker nodes](/azure/aks/load-balancer-standard#configure-the-allocated-outbound-ports).

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
