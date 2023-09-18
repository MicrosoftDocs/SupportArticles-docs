---
title: Basic troubleshooting of outbound connections from an AKS cluster
description: Do basic troubleshooting of outbound connections that originate from an Azure Kubernetes Service (AKS) cluster.
ms.date: 11/04/2022
ms.reviewer: chiragpa, rissing, v-leedennis
editor: v-jsitser
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-outbound-connections
#Customer intent: As an Azure Kubernetes user, I want to perform basic troubleshooting of outbound connections from an Azure Kubernetes Service (AKS) cluster so that I don't experience connection issues when I use AKS.
---
# Basic troubleshooting of outbound connections from an AKS cluster

This article discusses how to do basic troubleshooting of outbound connections from a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- The [apt-get](https://linux.die.net/man/8/apt-get) command-line tool for handling packages.

- The Client URL ([cURL](https://www.tecmint.com/install-curl-in-linux/)) tool, or a similar command-line tool.

- The [host](https://linux.die.net/man/1/host) command-line tool for DNS lookups.

- The [Netcat](https://linux.die.net/man/1/nc) (`nc`) command-line tool for TCP connections.

- The [traceroute](https://linux.die.net/man/8/traceroute) command-line tool for printing the trace of routing packets to the network host.

## Scenarios for outbound traffic in Azure Kubernetes Service

In any networking scenario, you should consider the following factors when troubleshooting:

- The source and the destination for the request.
- The hops in between the source and the destination.
- The request-response flow.
- The hops that are enhanced by extra security layers, such as the following layers:

  - Firewall
  - Network security group (NSG)
  - Network policy

When you check each component, [get and analyze HTTP response codes](get-and-analyze-http-response-codes.md). These codes are useful to identify the nature of the issue. The codes are especially helpful in scenarios in which the application responds to HTTP requests.

If other troubleshooting steps don't provide any conclusive outcome, take packet captures from the client and server. Packet captures are also useful when non-HTTP traffic is involved between the client and server. For more information about how to collect packet captures for AKS environment, see the following articles in the data collection guide:

- [Capture a TCP dump from a Linux node in an AKS cluster](capture-tcp-dump-linux-node-aks.md)

- [Capture a TCP dump from a Windows node in an AKS cluster](capture-tcp-dump-windows-node-aks.md)

- [Capture TCP packets from a pod on an AKS cluster](packet-capture-pod-level.md)

If you know how to get the HTTP response codes and take packet captures, it's easier to troubleshoot a network connectivity issue.

Traffic that originates from within the AKS cluster, whether it's from a pod or a worker node, is considered the outbound traffic from the cluster. What if there's an issue in the outbound flow for an AKS cluster? Before you troubleshoot, first understand the nature of the request-response flow.

The outbound traffic from an AKS cluster can be classified within the following categories:

1. Traffic to a pod or service in the same cluster (internal traffic)

1. Traffic to a device or endpoint in the same virtual network or a different virtual network (that uses virtual network peering)

1. Traffic to an on-premises environment through a VPN connection or an Azure ExpressRoute connection

1. Traffic outside the AKS network (public outbound traffic)

In this document, we cover basic troubleshooting steps for issues that affect outbound connectivity:

- Within the cluster
- Within the virtual networks
- To the outside world (public traffic)

When you troubleshoot outbound traffic in AKS, it's also important to know what your egress device is (that is, the device through which the traffic passes). Here, the egress device could be one of the following components:

- Azure Load Balancer
- Azure Firewall or a custom firewall
- A network address translation (NAT) gateway
- A proxy server

The flow could also differ based on the destination. For example, internal traffic (that is, within the cluster) doesn't go through the egress device. The internal traffic would use only the cluster networking.

### Internal traffic

A basic request flow for internal traffic from an AKS cluster would resemble the flow that's shown in the following diagram.

:::image type="content" source="./media/basic-troubleshooting-outbound-connections/internal-traffic-aks-cluster.svg" alt-text="Diagram of a basic request flow for internal traffic from a Microsoft Azure Kubernetes Service (AKS) cluster." lightbox="./media/basic-troubleshooting-outbound-connections/internal-traffic-aks-cluster.svg" border="false":::

### External traffic through Azure Load Balancer

If the traffic is for a destination on the internet, the default method is to send the traffic through the Azure Load Balancer.

:::image type="content" source="./media/basic-troubleshooting-outbound-connections/external-traffic-load-balancer.svg" alt-text="Diagram of a request flow for external internet traffic through Azure Load Balancer from a Microsoft Azure Kubernetes Service (AKS) cluster." lightbox="./media/basic-troubleshooting-outbound-connections/external-traffic-load-balancer.svg" border="false":::

### External traffic through Azure Firewall or a proxy server

In some cases, the egress traffic has to be filtered, and it might require Azure Firewall.

:::image type="content" source="./media/basic-troubleshooting-outbound-connections/external-traffic-firewall.svg" alt-text="Diagram of a request flow for external internet traffic through Azure Firewall from a Microsoft Azure Kubernetes Service (AKS) cluster." lightbox="./media/basic-troubleshooting-outbound-connections/external-traffic-firewall.svg" border="false":::

Instead of a firewall, a user might want to add a proxy server. Or, the user might want to set up an NAT gateway for egress traffic. The basic flow remains the same as shown in the diagram.

It's important to understand the nature of egress flow for your cluster so that you can continue troubleshooting.

## Troubleshooting checklist

For basic troubleshooting for egress traffic from an AKS cluster, follow these steps:

1. [Make sure that the Domain Name System (DNS) resolution for the endpoint works correctly](#check-whether-the-cluster-can-reach-the-endpoint-through-the-network).

1. Make sure that you can reach the endpoint through an IP address.

1. [Make sure that you can reach the endpoint from another source](./troubleshoot-connection-pods-services-same-cluster.md).

1. [Make sure that the endpoint is working](./troubleshoot-connections-endpoints-same-virtual-network.md).

1. [Check whether the cluster can reach any other external endpoint](./troubleshoot-connections-endpoints-outside-virtual-network.md).

1. [Check whether a network policy is blocking the traffic](./troubleshoot-dns-failure-from-pod-but-not-from-worker-node.md).

1. [Check whether an NSG is blocking the traffic](./traffic-between-node-pools-is-blocked.md).

1. Check whether a firewall or proxy is blocking the traffic.

1. Check whether the AKS service principal or managed identity has the required [AKS service permissions](/azure/aks/concepts-identity#aks-service-permissions) to make the network changes to Azure resources.

### Check whether the DNS resolution is successful for the endpoint

From within the pod, you can run a DNS lookup to the endpoint.

What if you can't run the [kubectl exec](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec) command to connect to the pod and install the DNS Utils package? In this situation, you can [start a test pod in the same namespace as the problematic pod](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/#create-a-simple-pod-to-use-as-a-test-environment), and then run the tests.

> [!NOTE]
>
> If the DNS resolution or egress traffic doesn't let you install the necessary network packages, you can use the `rishasi/ubuntu-netutil:1.0` docker image. In this image, the required packages are already installed.

Here's an example procedure for checking DNS resolution:

1. Start a test pod in the same namespace as the problematic pod:

   ```bash
   kubectl run -it --rm aks-ssh --namespace <namespace> --image=debian:stable
   ```

   After the test pod is running, you'll gain access to the pod.

1. Run the following `apt-get` commands to install other tool packages:

   ```bash
   apt-get update -y
   apt-get install dnsutils -y
   apt-get install curl -y
   apt-get install netcat -y
   ```

1. After the packages are installed, run the [nslookup](/windows-server/administration/windows-commands/nslookup) command to test the DNS resolution to the endpoint:

   ```console
   $ nslookup microsoft.com
   Server:         10.0.0.10
   Address:        10.0.0.10#53
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

1. Run the `host` command to check whether the DNS requests are routed to the upstream server:

   ```console
   $ host -a microsoft.com
   Trying "microsoft.com.default.svc.cluster.local"
   Trying "microsoft.com.svc.cluster.local"
   Trying "microsoft.com.cluster.local"
   Trying "microsoft.com.00idcnmrrm4edot5s2or1onxsc.bx.internal.cloudapp.net"
   Trying "microsoft.com"
   Trying "microsoft.com"
   ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 62884
   ;; flags: qr rd ra; QUERY: 1, ANSWER: 27, AUTHORITY: 0, ADDITIONAL: 5
   
   ;; QUESTION SECTION:
   ;microsoft.com.                 IN      ANY
   
   ;; ANSWER SECTION:
   microsoft.com.          30      IN      NS      ns1-39.azure-dns.com.
   ...
   ...
   ns4-39.azure-dns.info.  30      IN      A       13.107.206.39
   
   Received 2121 bytes from 10.0.0.10#53 in 232 ms
   ```

1. Run a test pod in the Windows node pool:

   ```bash
   # For a Windows environment, use the Resolve-DnsName cmdlet.
   kubectl run dnsutil-win --image='mcr.microsoft.com/windows/servercore:1809' --overrides='{"spec": { "nodeSelector": {"kubernetes.io/os": "windows"}}}' -- powershell "Start-Sleep -s 3600"
   ```

1. Run the [kubectl exec](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec) command to connect to the pod by using PowerShell:

   ```bash
   kubectl exec -it dnsutil-win powershell
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

You should also check whether the endpoint is reachable from the node. Then, verify the DNS settings in the node. Follow these steps:

1. [Connect to Azure Kubernetes Service (AKS) cluster nodes for maintenance or troubleshooting](/azure/aks/node-access).

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

1. Check the *resolv.conf* file to determine whether the expected name servers are added:

   ```bash
   cat /etc/resolv.conf
   cat /run/systemd/resolve/resolv.conf
   ```

In one unusual scenario that involves DNS resolution, the DNS queries get a correct response from the node but fail from the pod. For this scenario, you might consider [checking DNS resolution failures from inside the pod but not from the worker node](troubleshoot-dns-failure-from-pod-but-not-from-worker-node.md).

If the DNS resolution is successful, continue to the network tests. Otherwise, verify the DNS configuration for the cluster.

### Check whether the cluster can reach the endpoint through the network

To determine whether you can reach the endpoint through the network from your cluster, follow these steps:

1. Check the route to the endpoint to determine whether there's a time-out at a specific operation:

   ```bash
   kubectl run -it --rm aks-ssh --namespace <namespace> --image=debian:stable
   apt-get install -y traceroute && apt-get install netcat -y
   traceroute -T microsoft.com -m 50 -p 443
   ```

1. Check whether the desired port is open on the remote host:

   ```bash
   nc -z -v microsoft.com 443
   ```

1. Check the HTTP response code:

   ```bash
   curl -Iv https://microsoft.com
   ```

1. Check whether you can connect to any other endpoint:

   ```bash
   curl -Iv https://kubernetes.io
   ```

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
