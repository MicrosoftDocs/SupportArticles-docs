---
title: Basic troubleshooting of outbound connections from an AKS cluster
description: Do basic troubleshooting of outbound connections that originate from an Azure Kubernetes Service (AKS) cluster.
ms.date: 11/28/2024
ms.reviewer: chiragpa, rissing, jopalhei, jaewonpark, v-leedennis, v-weizhu, juliayin
editor: v-jsitser
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to perform basic troubleshooting of outbound connections from an Azure Kubernetes Service (AKS) cluster so that I don't experience connection issues when I use AKS.
ms.custom: sap:Connectivity
---
# Basic troubleshooting of outbound connections from an AKS cluster

This article discusses how to do basic troubleshooting of outbound connections from a Microsoft Azure Kubernetes Service (AKS) cluster and identify faulty components.

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- The [apt-get](https://linux.die.net/man/8/apt-get) command-line tool for handling packages.

- The Client URL ([cURL](https://www.tecmint.com/install-curl-in-linux/)) tool, or a similar command-line tool.

- The `nslookup` command-line ([dnsutils](https://www.tecmint.com/install-dig-and-nslookup-in-linux/)) tool for checking DNS resolution.

## Scenarios for outbound traffic in Azure Kubernetes Service

Traffic that originates from within the AKS cluster, whether it's from a pod or a worker node, is considered as outbound traffic from the cluster. If there's an issue in the outbound flow for an AKS cluster, before you troubleshoot, first look at the scenarios for outbound traffic flow.

The outbound traffic from an AKS cluster can be classified into the following categories:

1. [Traffic to a pod or service in the same cluster (internal traffic)](#internal-traffic).

1. Traffic to a network resource or endpoint in the same virtual network or a different virtual network that uses virtual network peering.

1. Traffic to an on-premises environment through a VPN connection or an Azure ExpressRoute connection.

1. [Traffic outside the AKS network through Azure Load Balancer (public outbound traffic)](#public-outbound-traffic-through-azure-load-balancer).

1. [Traffic outside the AKS network through Azure Firewall or a proxy server (public outbound traffic)](#public-outbound-traffic-through-azure-firewall-or-a-proxy-server).

#### Internal traffic

A basic request flow for internal traffic from an AKS cluster resembles the flow shown in the following diagram.

:::image type="content" source="./media/basic-troubleshooting-outbound-connections/internal-traffic-aks-cluster.svg" alt-text="Diagram of a basic request flow for internal traffic from an AKS cluster." lightbox="./media/basic-troubleshooting-outbound-connections/internal-traffic-aks-cluster.svg" border="false":::

#### Public outbound traffic through Azure Load Balancer

If the traffic is for a destination on the internet, the default method is to send the traffic through the Azure Load Balancer.

:::image type="content" source="./media/basic-troubleshooting-outbound-connections/external-traffic-load-balancer.svg" alt-text="Diagram of a request flow for external internet traffic through Azure Load Balancer from an AKS cluster." lightbox="./media/basic-troubleshooting-outbound-connections/external-traffic-load-balancer.svg" border="false":::

#### Public outbound traffic through Azure Firewall or a proxy server

In some cases, the egress traffic has to be filtered, and it might require Azure Firewall.

:::image type="content" source="./media/basic-troubleshooting-outbound-connections/external-traffic-firewall.svg" alt-text="Diagram of a request flow for external internet traffic through Azure Firewall from an AKS cluster." lightbox="./media/basic-troubleshooting-outbound-connections/external-traffic-firewall.svg" border="false":::

A user might want to add a proxy server instead of a firewall, or set up a NAT gateway for egress traffic. The basic flow remains the same as shown in the diagram.

It's important to understand the nature of egress flow for your cluster so that you can continue troubleshooting.

## Considerations when troubleshooting

#### Check your network resources within traffic flow

When you troubleshoot outbound traffic in AKS, it's important to know what network resources are present (that is, the hops through which the traffic passes). Here, the network resource could be one of the following components:

- Azure Load Balancer
- Azure Firewall or a custom firewall
- A network address translation (NAT) gateway
- A proxy server
- Network security group (NSG)
- Network policy

The flow could also differ based on the destination. For example, internal traffic (that is, within the cluster) doesn't go through the external network resources and only uses the cluster networking. For public outbound traffic, determine which network resources are implemented for your cluster.

#### Check outbound connectivity path and blockers with Azure Virtual Network Verifier (Preview)
To check where traffic is blocked within your network resources to specific endpoints (for example, `mcr.microsoft.com`), you can use the [Azure Virtual Network Verifier (Preview)](/azure/virtual-network-manager/concept-virtual-network-verifier) tool. By running a connectivity analysis, you can visualize the hops within the traffic flow and any misconfigurations within Azure networking resources that are blocking traffic. We recommend using the Virtual Network Verifier tool as a first step in troubleshooting outbound connectivity issues to isolate the issue and detect problematic network configuration. For more instructions, [check if Azure network resources are blocking traffic to the endpoint using Azure Virtual Network Verifier (Preview)](#check-if-azure-network-resources-are-blocking-traffic-to-the-endpoint).

#### Manual troubleshooting
For manual troubleshooting, we recommend you check the following items:

- The source and the destination for the request.
- The hops in between the source and the destination.
- The request-response flow.
- The hops enhanced by extra security layers, such as the following layers:

  - Firewall
  - Network security group (NSG)
  - Network policy

To identify a problematic hop, [check the HTTP response codes before and after it](get-and-analyze-http-response-codes.md). These codes are useful to identify the nature of the issue. The codes are especially helpful in scenarios in which the application responds to HTTP requests. To check whether the packets arrive properly in a specific hop, you can proceed with packet captures.

#### Take packet captures from the client and server

If other troubleshooting steps don't provide any conclusive outcome, take packet captures from the client and server. Packet captures are also useful when non-HTTP traffic is involved between the client and server. For more information about how to collect packet captures for AKS environment, see the following articles in the data collection guide:

- [Capture a TCP dump from a Linux node in an AKS cluster](../logs/capture-tcp-dump-linux-node-aks.md)

- [Capture a TCP dump from a Windows node in an AKS cluster](../logs/capture-tcp-dump-windows-node-aks.md)

- [Capture TCP packets from a pod on an AKS cluster](../logs/packet-capture-pod-level.md)

## Troubleshooting checklists

For basic troubleshooting for egress traffic from an AKS cluster, follow these steps:

1. [Check if Azure network resources are blocking traffic to the endpoint using Azure Virtual Network Verifier (Preview)](#check-if-azure-network-resources-are-blocking-traffic-to-the-endpoint).

1. [Make sure that the Domain Name System (DNS) resolution for the endpoint works correctly](#check-whether-the-pod-and-node-can-reach-the-endpoint).

1. Make sure that you can reach the endpoint through an IP address.

1. [Make sure that you can reach the endpoint from another source](./troubleshoot-connection-pods-services-same-cluster.md).

1. [Make sure that the endpoint is working](./troubleshoot-connections-endpoints-same-virtual-network.md).

1. [Check whether the cluster can reach any other external endpoint](./troubleshoot-connections-endpoints-outside-virtual-network.md).

1. [Check whether a network policy is blocking the traffic](./dns/troubleshoot-dns-failure-from-pod-but-not-from-worker-node.md).

1. [Check whether an NSG is blocking the traffic](./traffic-between-node-pools-is-blocked.md).

1. Check whether a firewall or proxy is blocking the traffic.

1. Check whether the AKS service principal or managed identity has the required [AKS service permissions](/azure/aks/concepts-identity#aks-service-permissions) to make the network changes to Azure resources.

> [!NOTE]
>
> Assumes no service mesh when you do basic troubleshooting. If you use a service mesh such as Istio, it produces unusual outcomes for TCP based traffic.

#### Check if Azure network resources are blocking traffic to the endpoint

To determine if traffic is blocked to the endpoint due to Azure network resources, run a connectivity analysis from your AKS cluster nodes to the endpoint using the Azure Virtual Network Verifier (Preview) tool. The connectivity analysis covers the following resources:

- Azure Load Balancer
- Azure Firewall
- A network address translation (NAT) gateway
- Network security group (NSG)
- Network policy

> [!NOTE]
>
> Azure Virtual Network Verifier (Preview) doesn't look at any external or third-party networking resources, such as a custom firewall. If the connectivity analysis doesn't detect any blocked traffic, we recommend that you perform a manual check of any external networking to cover all hops in the traffic flow.
> 
> Currently, clusters using Azure CNI Overlay aren't supported for this feature. Support for CNI Overlay is planned for August 2025.

1. Navigate to your cluster in the Azure portal. In the sidebar, navigate to the Settings -> Node pools blade.
2. Identify the nodepool you want to run a connectivity analysis from. Click on the nodepool to select it as the scope.
3. Select "Connectivity analysis (Preview)" from the toolbar at the top of the page. If you don't see it, click on the three dots "..." in the toolbar at the top of the page to open the expanded menu. <img width="626" alt="image" src="https://github.com/user-attachments/assets/b2f05947-f753-49b9-9536-98d0b998ab52" />
4. Select a Virtual Machine Scale Set (VMSS) instance as the source. The source IP addresses are populated automatically.
5. Select a public domain name/endpoint as the destination for the analysis, one example is `mcr.microsoft.com`. The destination IP addresses are also populated automatically.
6. Run the analysis and wait up to 2 minutes for the results. In the resulting diagram, identify the associated Azure network resources and where traffic is blocked. To view the detailed analysis output, click on the "JSON output" tab or click into the arrows in the diagram.


#### Check that the Domain Name Service (DNS) resolution for the endpoint works correctly

You can run a DNS lookup to the endpoint by running a debugging pod on one of your AKS nodes. If the issue is isolated to a specific problematic pod or namespace, run the DNS lookup from within the same namespace where you notice the problem.

If you can't run the [kubectl exec](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec) command to connect to an existing pod, you can [start a test pod in the same namespace as the problematic pod](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/#create-a-simple-pod-to-use-as-a-test-environment) to run the tests.

> [!NOTE]
>
> If the DNS resolution or egress traffic doesn't let you install the necessary network packages, you can use the `rishasi/ubuntu-netutil:1.0` docker image. In this image, the required packages are already installed.

##### Example procedure for checking DNS resolution

1. Start a test pod in the problematic namespace:

   ```bash
   kubectl run -it --rm aks-ssh --namespace <namespace> --image=debian:stable --overrides='{"spec": { "nodeSelector": {"kubernetes.io/os": "linux"}}}'
   ```

   After the test pod is running, you'll gain access to the pod.

1. Run the following `apt-get` commands to install other tool packages:

   ```bash
   # Update and install tool packages
   apt-get update && apt-get install -y dnsutils curl
   ```

1. After the packages are installed, run the [nslookup](/windows-server/administration/windows-commands/nslookup) command to test the DNS resolution to the endpoint:

   ```console
   $ nslookup microsoft.com # Microsoft.com is used as an example
   Server:         <server>
   Address:        <server IP address>#53
   ...
   ...
   Name:   microsoft.com
   Address: 20.53.203.50
   ```

1. Try the DNS resolution from the upstream DNS server directly. This example uses Azure DNS:

   ```console
   $ nslookup microsoft.com 168.63.129.16
   Server:         168.63.129.16
   Address:        168.63.129.16#53
   ...
   ...
   Address: 20.81.111.85
   ```

Sometimes, there's a problem with the endpoint itself rather than a cluster DNS. In such cases, consider the following checks:

1. Check whether the desired port is open on the remote host:

   ```bash
   curl -Ivm5 telnet://microsoft.com:443
   ```

1.  Check the HTTP response code:

     ```bash
     curl -Ivm5 https://microsoft.com
     ```

1. Check whether you can connect to any other endpoint:

   ```bash
   curl -Ivm5 https://kubernetes.io
   ```

To verify that the endpoint is reachable and DNS is functioning from the node hosting the problematic pod, follow these steps:

1. Enter the node hosting the problematic pod using the debug pod. For more information, see [Connect to Azure Kubernetes Service (AKS) cluster nodes for maintenance or troubleshooting](/azure/aks/node-access).

1. Test the DNS resolution to the endpoint:

   ```console
   $ nslookup  microsoft.com
   Server:         168.63.129.16
   Address:        168.63.129.16#53
   
   Non-authoritative answer:
   Name:   microsoft.com
   Address: 20.112.52.29
   Name:   microsoft.com
   Address: 20.81.111.85
   Name:   microsoft.com
   Address: 20.84.181.62
   Name:   microsoft.com
   Address: 20.103.85.33
   Name:   microsoft.com
   Address: 20.53.203.50
   ```

1. Check the **resolv.conf** file to determine whether the expected name servers are added:

   ```bash
   cat /etc/resolv.conf
   cat /run/systemd/resolve/resolv.conf
   ```
   
##### Example procedure for checking DNS resolution of a Windows pod

1. Run a test pod in the Windows node pool:

   ```bash
   # For a Windows environment, use the Resolve-DnsName cmdlet.
   kubectl run dnsutil-win --image='mcr.microsoft.com/windows/servercore:ltsc2022' --overrides='{"spec": { "nodeSelector": {"kubernetes.io/os": "windows"}}}' -- powershell "Start-Sleep -s 3600"
   ```

1. Run the [kubectl exec](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec) command to connect to the pod by using PowerShell:

   ```bash
   kubectl exec -it dnsutil-win -- powershell
   ```

1. Run the [Resolve-DnsName](/powershell/module/dnsclient/resolve-dnsname) cmdlet in PowerShell to check whether the DNS resolution is working for the endpoint:

   ```console
   PS C:\> Resolve-DnsName www.microsoft.com 
   
   Name                           Type   TTL   Section    NameHost
   ----                           ----   ---   -------    --------
   www.microsoft.com              CNAME  20    Answer     www.microsoft.com-c-3.edgekey.net
   www.microsoft.com-c-3.edgekey. CNAME  20    Answer     www.microsoft.com-c-3.edgekey.net.globalredir.akadns.net
   net
   www.microsoft.com-c-3.edgekey. CNAME  20    Answer     e13678.dscb.akamaiedge.net
   net.globalredir.akadns.net
   
   Name       : e13678.dscb.akamaiedge.net 
   QueryType  : AAAA
   TTL        : 20
   Section    : Answer
   IP6Address : 2600:1408:c400:484::356e   
   
   
   Name       : e13678.dscb.akamaiedge.net 
   QueryType  : AAAA
   TTL        : 20
   Section    : Answer
   IP6Address : 2600:1408:c400:496::356e 
   
   
   Name       : e13678.dscb.akamaiedge.net
   QueryType  : A
   TTL        : 12
   Section    : Answer
   IP4Address : 23.200.197.152
   ```

In one unusual scenario that involves DNS resolution, the DNS queries get a correct response from the node but fail from the pod. For this scenario, you might consider [checking DNS resolution failures from inside the pod but not from the worker node](./dns/troubleshoot-dns-failure-from-pod-but-not-from-worker-node.md). If you want to inspect DNS resolution for an endpoint across the cluster, you can consider [checking DNS resolution status across the cluster](./dns/troubleshoot-dns-failures-across-an-aks-cluster-in-real-time.md#step-3-verify-the-health-of-the-upstream-dns-servers).

If the DNS resolution is successful, continue to the network tests. Otherwise, verify the DNS configuration for the cluster.

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
