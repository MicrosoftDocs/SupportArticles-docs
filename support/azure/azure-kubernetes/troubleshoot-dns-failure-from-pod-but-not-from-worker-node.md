---
title: Troubleshoot DNS resolution failures from inside the pod
description: Troubleshoot DNS resolution failures from inside the pod but not from the worker node within an Azure Kubernetes Service (AKS) cluster.
ms.date: 11/04/2022
ms.reviewer: chiragpa, rissing, v-leedennis
editor: v-jsitser
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-outbound-connections
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot failures of DNS resolution from inside the pod (but not from the worker node) so that I don't experience outbound connection issues from an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot DNS resolution failures from inside the pod but not from the worker node

This article discusses how to troubleshoot Domain Name System (DNS) resolution failures that occur from inside the pod, but not from the worker node, when you try to establish an outbound connection from a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- The [apt-get](https://linux.die.net/man/8/apt-get) command-line tool for handling packages.

- The [host](https://linux.die.net/man/1/host) command-line tool for DNS lookups.

- The [systemctl](https://man7.org/linux/man-pages/man1/systemctl.1.html) command-line tool.

## Background

For DNS resolution, the pods send requests to the CoreDNS pods in the `kube-system` namespace.

If the DNS query is for an internal component, such as a service name, the CoreDNS pod responds by itself. However, if the request is for an external domain, the CoreDNS pod sends the request to the upstream DNS server.

The upstream DNS servers are obtained based on the *resolv.conf* file of the worker node in which the pod is running. The *resolv.conf* file (*/run/systemd/resolve/resolv.conf*) is updated based on the DNS settings of the virtual network on which the worker node is running.

## Troubleshooting checklist

To troubleshoot DNS issues from within the pod, use the instructions in the following sections.

### Step 1: Troubleshoot DNS issues from within the pod

You can use kubectl commands to troubleshoot DNS issues from within the pod, as shown in the following steps:

1. Verify that the CoreDNS pods are running:

   ```bash
   kubectl get pods -l k8s-app=kube-dns -n kube-system
   ```

1. Check whether the CoreDNS pods are overused:

   ```console
   $ kubectl top pods -n kube-system -l k8s-app=kube-dns
   NAME                      CPU(cores)   MEMORY(bytes)
   coredns-dc97c5f55-424f7   3m           23Mi
   coredns-dc97c5f55-wbh4q   3m           25Mi
   ```

1. Verify that the nodes that host the CoreDNS pods aren't overused. Also, get the nodes that are hosting the CoreDNS pods:

   ```bash
   kubectl get pods -n kube-system -l k8s-app=kube-dns -o jsonpath='{.items[*].spec.nodeName}'
   ```

1. Check the usage of these nodes:

   ```bash
   kubectl top nodes
   ```

1. Verify the logs for the CoreDNS pods:

   ```bash
   kubectl logs -l k8s-app=kube-dns -n kube-system
   ```

> [!NOTE]
> To see more debugging information, enable verbose logs in CoreDNS. To enable verbose logging in CoreDNS, see [Troubleshooting CoreDNS customizations in AKS](/azure/aks/coredns-custom#troubleshooting).

### Step 2: Create a test pod to run commands

If DNS resolution is failing, follow these steps:

1. [Run a test pod in the same namespace as the problematic pod](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/#create-a-simple-pod-to-use-as-a-test-environment).

1. Start a test pod in the cluster:

   ```bash
   kubectl run -it --rm aks-ssh --namespace <namespace> --image=debian:stable
   ```

   When the test pod is running, you'll gain access to the pod.

1. Run the following commands to install the required packages:

   ```bash
   apt-get update -y
   apt-get install dnsutils -y
   ```

1. Verify that the *resolv.conf* file has the correct entries:

   ```console
   cat /etc/resolv.conf
   search default.svc.cluster.local svc.cluster.local cluster.local 00idcnmrrm4edot5s2or1onxsc.bx.internal.cloudapp.net
   nameserver 10.0.0.10
   options ndots:5
   ```
  
1. Use the `host` command to determine whether the DNS requests are being routed to the upstream server:

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

1. Check the upstream DNS server from the pod to determine whether the DNS resolution is working correctly. For example, for Azure DNS, run the following [nslookup](/windows-server/administration/windows-commands/nslookup) command:

   ```console
   $ nslookup microsoft.com 168.63.129.16
   Server:         168.63.129.16
   Address:        168.63.129.16#53
   ...
   ...
   Address: 20.81.111.85
   ```

### Step 3: Check whether DNS requests work when the upstream DNS server is explicitly specified

If the DNS requests from pods are working when you specify the upstream DNS server explicitly, verify the following conditions:

1. Check for a custom ConfigMap for CoreDNS:

   ```bash
   kubectl describe cm coredns-custom -n kube-system
   ```

   If a custom ConfigMap is present, verify that the configuration is correct. For more information, see [Customize CoreDNS with Azure Kubernetes Service](/azure/aks/coredns-custom).

1. Check whether a network policy is blocking traffic on User Datagram Protocol (UDP) port 53 to the CoreDNS pods in the `kube-system` namespace.

1. Check whether the CoreDNS pods are on a different node pool (System node pool). If they are, check whether a network security group (NSG) is associated with the System node pool that's blocking traffic on UDP port 53.

1. Check whether the virtual network was updated recently to add the new DNS servers.

   If a virtual network update occurred, check whether one of the following events has also occurred:

   - The nodes were restarted.
   - The network service in the node was restarted.

   For the update in DNS settings to take effect, the network service on the node and the CoreDNS pods have to be restarted. To restart the network service or the pods, use one of the following methods:

   - Restart the node.

   - Scale new nodes. (New nodes will have the updated configuration.)

   - Restart the network service in the nodes, and then restart the CoreDNS pods. Follow these steps:

     1. Make a Secure Shell (SSH) connection to the nodes. For more information, see [Connect to Azure Kubernetes Service (AKS) cluster nodes for maintenance or troubleshooting](/azure/aks/node-access).

     1. From within the node, restart the network service:

        ```bash
        systemctl restart systemd-networkd
        ```

     1. Check whether the settings are updated:

        ```bash
        cat /run/systemd/resolve/resolv.conf
        ```

     1. After the network service is restarted, use kubectl to restart the CoreDNS pods:

        ```bash
        kubectl delete pods -l k8s-app=kube-dns -n kube-system
        ```

1. Check whether more than one DNS server is specified in the virtual network DNS settings.

   If multiple DNS servers are specified in the AKS virtual network, one of the following sequences occurs:

   - The AKS node sends a request to the upstream DNS server as part of a series. In this sequence, the request is sent to the first DNS server that's configured in the virtual network (if the DNS servers are reachable and running). If the first DNS server isn't reachable and isn't responding, the request is sent to the next DNS server.

     AKS nodes use the [resolver](https://man7.org/linux/man-pages/man5/resolv.conf.5.html) command to send requests to the DNS servers. The configuration file for this resolver can be found at */run/systemd/resolve/resolv.conf* in the AKS nodes.

     Are there multiple servers? In this case, the resolver library queries them in the order that's listed. (The strategy used is to try a name server first. If the query times out, try the next name server, and continue until the list of name servers is exhausted. Then, the query continues to try to connect to the name servers until the maximum number of retries are made.)

   - CoreDNS uses the [forward](https://coredns.io/plugins/forward/) plug-in to send requests to upstream DNS servers. This plug-in uses a random algorithm to select the upstream DNS server. In this sequence, the request could go to any of the DNS servers that are mentioned in the virtual network. For example, you might receive the following output:

     ```console
     $ kubectl describe cm coredns -n kube-system
     Name:         coredns
     Namespace:    kube-system
     Labels:       addonmanager.kubernetes.io/mode=Reconcile
                   k8s-app=kube-dns
                   kubernetes.io/cluster-service=true
     Annotations:  <none>
     
     Data
     ====
     Corefile:
     ----
     .:53 {
         errors
         ready
         health
         kubernetes cluster.local in-addr.arpa ip6.arpa {
           pods insecure
           fallthrough in-addr.arpa ip6.arpa
         }
         prometheus :9153
         forward . /etc/resolv.conf                            # Here!
         cache 30
         loop
         reload
         loadbalance
         import custom/*.override
     }
     import custom/*.server
     
     
     BinaryData
     ====
     
     Events:  <none>
     ```

   In the CoreDNS `forward` plugin, `policy` specifies the policy to use for selecting upstream servers. The policies are defined in the following table.

   | Policy name   | Description                                                                            |
   |---------------|----------------------------------------------------------------------------------------|
   | `random`      | A policy that implements random upstream selection. This policy is the default policy. |
   | `round_robin` | A policy that selects hosts based on round robin ordering.                             |
   | `sequential`  | A policy that selects hosts based on sequential ordering.                              |

   If the AKS virtual network contains multiple DNS servers, the requests from the AKS node might go to the first DNS server. However, the requests from the pod might go to second DNS server.

## Cause: Multiple destinations for DNS requests

If two custom DNS servers are specified, and the third DNS server is specified as Azure DNS (168.63.129.16), the node will send requests to the first custom DNS server if it's running and reachable. In this setup, the node can resolve the custom domain. However, some of the DNS requests from the pod might be directed to Azure DNS. This is because CoreDNS can select the upstream server at random. In this scenario, the custom domain can't be resolved. Therefore, the DNS request fails.

## Solution: Remove Azure DNS from virtual network settings

We recommend that you don't combine Azure DNS with custom DNS servers in the virtual network settings. If you want to use the custom DNS servers, add only the custom DNS servers in the virtual network settings. Then, configure Azure DNS in the forwarder settings of your custom DNS servers.

For more information, see [Name resolution that uses your own DNS server](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances#name-resolution-that-uses-your-own-dns-server).

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
