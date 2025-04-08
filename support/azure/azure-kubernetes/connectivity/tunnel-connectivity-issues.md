---
title: Tunnel connectivity issues
description: Resolve communication issues that are related to tunnel connectivity in an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/23/2025
ms.reviewer: chiragpa, andbar, v-leedennis, v-weizhu, albarqaw
ms.service: azure-kubernetes-service
keywords: Azure Kubernetes Service, AKS cluster, Kubernetes cluster, tunnels, connectivity, tunnel-front, aks-link, Konnectivity agent, Cluster Proportional Autoscaler, CPA, Resource allocation, Performance bottlenecks, Networking reliability, Azure Kubernetes troubleshooting, AKS performance issues
#Customer intent: As an Azure Kubernetes user, I want to avoid tunnel connectivity issues so that I can use an Azure Kubernetes Service (AKS) cluster successfully.
ms.custom: sap:Connectivity
---
# Tunnel connectivity issues

Microsoft Azure Kubernetes Service (AKS) uses a specific component for tunneled, secure communication between the nodes and the control plane. The tunnel consists of a server on the control plane side and a client on the cluster nodes side. This article discusses how to troubleshoot and resolve issues that relate to tunnel connectivity in AKS.

:::image type="content" source="./media/tunnel-connectivity-issues/kubernetes-tunnel-architecture.png" alt-text="Diagram of the Azure-managed AKS underlay, customer-managed Azure virtual network and subnet, and the tunnel from the API to the tunnel pod." border="false" lightbox="./media/tunnel-connectivity-issues/kubernetes-tunnel-architecture.png":::

> [!NOTE]
> Previously, the AKS tunnel component was `tunnel-front`. It has now been migrated to the [Konnectivity service](https://kubernetes.io/docs/concepts/architecture/control-plane-node-communication/#konnectivity-service), an upstream Kubernetes component. For more information about this migration, see the [AKS release notes and changelog](https://github.com/Azure/AKS/blob/master/CHANGELOG.md).

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)

## Symptoms

You receive an error message that resembles the following examples about port 10250:

> Error from server: Get "https\://\<aks-node-name>:10250/containerLogs/\<namespace>/\<pod-name>/\<container-name>": dial tcp \<aks-node-ip>:10250: i/o timeout

> Error from server: error dialing backend: dial tcp \<aks-node-ip>:10250: i/o timeout

> Error from server: Get "https\://\<aks-node-name>:10250/containerLogs/\<namespace>/\<pod-name>/\<container-name>": http: server gave HTTP response to HTTPS client

The Kubernetes API server uses port 10250 to connect to a node's kubelet to retrieve the logs. If port 10250 is blocked, the kubectl logs and other features will only work for pods that run on the nodes in which the tunnel component is scheduled. For more information, see [Kubernetes ports and protocols: Worker nodes](https://kubernetes.io/docs/reference/ports-and-protocols/#node).

Because the tunnel components or the connectivity between the server and client can't be established, functionality such as the following won't work as expected:

- Admission controller webhooks

- Ability of log retrieval (using the [kubectl logs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs) command)

- Running a command in a container or getting inside a container (using the [kubectl exec](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec) command)

- Forwarding one or more local ports of a pod (using the [kubectl port-forward](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#port-forward) command)

## Cause 1: A network security group (NSG) is blocking port 10250

> [!NOTE]
> This cause is applicable to any tunnel components that you might have in your AKS cluster.

You can use an [Azure network security group](/azure/virtual-network/network-security-groups-overview) (NSG) to filter network traffic to and from Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound and outbound network traffic between several types of Azure resources. For each rule, you can specify source and destination, port, and protocol. For more information, see [How network security groups filter network traffic](/azure/virtual-network/network-security-group-how-it-works).

If the NSG blocks port 10250 at the virtual network level, tunnel functionalities (such as logs and code execution) will work for only the pods that are scheduled on the nodes where tunnel pods are scheduled. The other pods won't work because their nodes won't be able to reach the tunnel, and the tunnel is scheduled on other nodes. To verify this state, you can test the connectivity by using [netcat](https://nc110.sourceforge.io/) (`nc`) or telnet commands. You can run the [az vmss run-command invoke](/cli/azure/vmss/run-command#az-vmss-run-command-invoke) command to conduct the connectivity test and verify whether it succeeds, times out, or causes some other issue:

```azurecli
az vmss run-command invoke --resource-group <infra-or-MC-resource-group> \
    --name <virtual-machine-scale-set-name> \
    --command-id RunShellScript \
    --instance-id <instance-id> \
    --scripts "nc -v -w 2 <ip-of-node-that-schedules-the-tunnel-component> 10250" \
    --output tsv \
    --query 'value[0].message'
```

### Solution 1: Add an NSG rule to allow access to port 10250

If you use an NSG, and you have specific restrictions, make sure that you add a security rule that allows traffic for port 10250 at the virtual network level. The following [Azure portal](https://portal.azure.com) image shows an example security rule:

:::image type="content" source="./media/tunnel-connectivity-issues/add-inbound-security-rule.png" alt-text="Screenshot of the Add inbound security rule pane in the Azure portal. The Destination port ranges box is set to 10250 for the new security rule.":::

If you want to be more restrictive, you can allow access to port 10250 at the subnet level only.

> [!NOTE]
> - The **Priority** field must be adjusted accordingly. For example, if you have a rule that denies multiple ports (including port 10250), the rule that's shown in the image should have a lower priority number (lower numbers have higher priority). For more information about **Priority**, see [Security rules](/azure/virtual-network/network-security-groups-overview#security-rules).
>
> - If you don't see any behavioral change after you apply this solution, you can re-create the tunnel component pods. Deleting these pods causes them to be re-created.

## Cause 2: The Uncomplicated Firewall (UFW) tool is blocking port 10250

> [!NOTE]
> This cause applies to any tunnel component that you have in your AKS cluster.

[Uncomplicated Firewall](https://wiki.ubuntu.com/UncomplicatedFirewall) (UFW) is a command-line program for managing a [netfilter](https://www.netfilter.org/) firewall. AKS nodes use Ubuntu. Therefore, UFW is installed on AKS nodes by default, but UFW is disabled.

By default, if UFW is enabled, it will block access to all ports, including port 10250. In this case, it's unlikely that you can use Secure Shell (SSH) to [connect to AKS cluster nodes for troubleshooting](/azure/aks/node-access). This is because UFW might also be blocking port 22. To troubleshoot, you can run the [az vmss run-command invoke](/cli/azure/vmss/run-command#az-vmss-run-command-invoke) command to invoke a [ufw command](https://manpages.ubuntu.com/manpages/lunar/en/man8/ufw.8.html) that checks whether UFW is enabled:

```azurecli
az vmss run-command invoke --resource-group <infra-or-MC-resource-group> \
    --name <virtual-machine-scale-set-name> \
    --command-id RunShellScript \
    --instance-id <instance-id> \
    --scripts "ufw status" \
    --output tsv \
    --query 'value[0].message'
```

What if the results indicate that UFW is enabled, and it doesn't specifically allow port 10250? In this case, tunnel functionalities (such as logs and code execution) won't work for the pods that are scheduled on the nodes that have UFW enabled. To fix the problem, apply one of the following solutions on UFW.

> [!IMPORTANT]
> Before you use this tool to make any changes, review the [AKS support policy](/azure/aks/support-policies) (especially [node maintenance and access](/azure/aks/support-policies#node-maintenance-and-access)) to prevent your cluster from entering into an unsupported scenario.

> [!NOTE]
> If you don't see any behavioral change after you apply a solution, you can re-create the tunnel component pods. Deleting these pods will cause them to be re-created.

### Solution 2a: Disable Uncomplicated Firewall

Run the following `az vmss run-command invoke` command to disable UFW:

```azurecli
az vmss run-command invoke --resource-group <infra-or-MC-resource-group> \
    --name <virtual-machine-scale-set-name> \
    --command-id RunShellScript \
    --instance-id <instance-id> \
    --scripts "ufw disable" \
    --output tsv \
    --query 'value[0].message'
```

### Solution 2b: Configure Uncomplicated Firewall to permit access to port 10250

To force UFW to allow access to port 10250, run the following `az vmss run-command invoke` command:

```azurecli
az vmss run-command invoke --resource-group <infra-or-MC-resource-group> \
    --name <virtual-machine-scale-set-name> \
    --command-id RunShellScript \
    --instance-id <instance-id> \
    --scripts "ufw allow 10250" \
    --output tsv \
    --query 'value[0].message'
```

## Cause 3: The iptables tool is blocking port 10250

> [!NOTE]
> This cause applies to any tunnel component that you have in your AKS cluster.

The [iptables](https://www.netfilter.org/projects/iptables/) tool lets a system administrator configure the IP packet filter rules of a Linux firewall. You can configure the `iptables` rules to block communication on port 10250.

You can view the rules for your nodes to check whether port 10250 is blocked or the associated packets are dropped. To do this, run the following `iptables` command:

```bash
iptables --list --line-numbers
```

In the output, the data is grouped into several *chains*, including the `INPUT` chain. Each chain contains a table of rules under the following column headings:

- `num` (rule number)
- `target`
- `prot` (protocol)
- `opt`
- `source`
- `destination`

Does the `INPUT` chain contain a rule in which the target is `DROP`, the protocol is `tcp`, and the destination is `tcp dpt:10250`? If it does, `iptables` is blocking access to destination port 10250.

### Solution 3: Delete the iptables rule that blocks access on port 10250

Run one of the following commands to delete the `iptables` rule that prevents access to port 10250:

```bash
iptables --delete INPUT --jump DROP --protocol tcp --source <ip-number> --destination-port 10250
```

```bash
iptables --delete INPUT <input-rule-number>
```

To address your exact or potential scenario, we recommend that you check the [iptables manual](https://ipset.netfilter.org/iptables.man.html) by running the `iptables --help` command.

> [!IMPORTANT]
> Before you use this tool to make any changes, review the [AKS support policy](/azure/aks/support-policies) (especially [node maintenance and access](/azure/aks/support-policies#node-maintenance-and-access)) to prevent your cluster from entering into an unsupported scenario.

## Cause 4: Egress port 1194 or 9000 isn't opened

> [!NOTE]
> This cause applies to only the `tunnel-front` and `aks-link` pods.

Are there any egress traffic restrictions, such as from an AKS firewall? If there are, port 9000 is required in order to enable correct functionality of the `tunnel-front` pod. Similarly, port 1194 is required for the `aks-link` pod.

Konnectivity relies on port 443. By default, this port is open. Therefore, you don't have to worry about connectivity issues on that port.

### Solution 4: Open port 9000

Although `tunnel-front` has been moved to the [Konnectivity service](https://kubernetes.io/docs/concepts/architecture/control-plane-node-communication/#konnectivity-service), some AKS clusters still use `tunnel-front`, which relies on port 9000. Make sure that the virtual appliance or any network device or software allows access to port 9000. For more information about the required rules and dependencies, see [Azure Global required network rules](/azure/aks/limit-egress-traffic#azure-global-required-network-rules).

## Cause 5: Source Network Address Translation (SNAT) port exhaustion

> [!NOTE]
> This cause applies to any tunnel component that you have in your AKS cluster. However, it doesn't apply to [private AKS clusters](/azure/aks/private-clusters). Source Network Address Translation (SNAT) port exhaustion can occur for public communication only. For private AKS clusters, the API server is inside the AKS virtual network or subnet.

If [SNAT port exhaustion](/azure/load-balancer/load-balancer-outbound-connections#port-exhaustion) occurs (failed [SNAT ports](/azure/load-balancer/load-balancer-outbound-connections#what-are-snat-ports)), the nodes can't connect to the API server. The tunnel container is on the API server side. Therefore, tunnel connectivity won't be established.

If the SNAT port resources are exhausted, the outbound flows fail until the existing flows release some SNAT ports. Azure Load Balancer reclaims the SNAT ports when the flow closes. It uses a four-minute idle time-out to reclaim the SNAT ports from the idle flows.

You can view the SNAT ports from either the AKS load balancer metrics or the service diagnostics, as described in the following sections. For more information about how to view SNAT ports, see [How do I check my outbound connection statistics?](/azure/load-balancer/load-balancer-standard-diagnostics#how-do-i-check-my-outbound-connection-statistics).

<details>
<summary>AKS load balancer metrics</summary>

To use AKS load balancer metrics to view the SNAT ports, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Kubernetes services**.

1. In the list of Kubernetes services, select the name of your cluster.

1. In the menu pane of the cluster, find the **Settings** heading, and then select **Properties**.

1. Select the name that's listed under **Infrastructure resource group**.

1. Select the **kubernetes** load balancer.

1. In the menu pane of the load balancer, find the **Monitoring** heading, and then select **Metrics**.

1. For the metric type, select **SNAT Connection Count**.

1. Select **Apply splitting**.

1. Set **Split by** to **Connection State**.

</details>

<details>
<summary>Service diagnostics</summary>

To use service diagnostics to view the SNAT ports, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Kubernetes services**.

1. In the list of Kubernetes services, select the name of your cluster.

1. In the menu pane of the cluster, select **Diagnose and solve problems**.

1. Select **Connectivity Issues**.

1. Under **SNAT Connection and Port Allocation**, select **View details**.

1. If necessary, use the **Time Range** button to customize the time frame.

</details>

### Solution 5a: Make sure the application is using connection pooling

This behavior might occur because an application isn't reusing existing connections. We recommend that you don't create one outbound connection per request. Such a configuration can cause connection exhaustion. Check whether the application code is following best practices and using connection pooling. Most libraries support connection pooling. Therefore, you shouldn't have to create a new outbound connection per request.

### Solution 5b: Adjust the allocated outbound ports

If everything is OK within the application, you'll have to adjust the allocated outbound ports. For more information about outbound port allocation, see [Configure the allocated outbound ports](/azure/aks/load-balancer-standard#configure-the-allocated-outbound-ports).

### Solution 5c: Use a Managed Network Address Translation (NAT) Gateway when you create a cluster

You can set up a new cluster to use a Managed Network Address Translation (NAT) Gateway for outbound connections. For more information, see [Create an AKS cluster with a Managed NAT Gateway](/azure/aks/nat-gateway#create-an-aks-cluster-with-a-managed-nat-gateway).

## Cause 6: Konnectivity Agents performance issues with Cluster growth

As the cluster grows, the performance of Konnectivity Agents may degrade due to increased network traffic, higher numbers of requests, or resource constraints.

> [!NOTE]
> This cause applies to only the `Konnectivity-agent` pods.

### Solution 6: Cluster Proportional Autoscaler for Konnectivity Agent

 To address scalability challenges in large clusters, we have implemented the Cluster Proportional Autoscaler for our Konnectivity Agents. This approach aligns with industry standards and best practices. It ensures optimal resource usage and enhanced performance.

**Why was this change made?**
Previously, the Konnectivity agent had a fixed replica count, which could create a bottleneck as the cluster grew. With the implementation of the Cluster Proportional Autoscaler, the replica count now dynamically adjusts based on node-scaling rules, ensuring optimal performance and resource usage.

**How does the Cluster Proportional Autoscaler work?**
The Cluster Proportional Autoscaler work uses a ladder configuration to determine the number of Konnectivity agent replicas based on the cluster size. The ladder configuration is defined in the konnectivity-agent-autoscaler configmap in the kube-system namespace. Here is an example of the ladder configuration:

```
nodesToReplicas": [
    [1, 2],
    [100, 3],
    [250, 4],
    [500, 5],
    [1000, 6],
    [5000, 10]
]
```

This configuration ensures that the number of replicas scales appropriately with the number of nodes in the cluster, providing optimal resource allocation and improved networking reliability.

**How to use the Cluster Proportional Autoscaler?**
You can override default values by updating the konnectivity-agent-autoscaler configmap in the kube-system namespace. Here is a sample command to update the configmap:

```bash
kubectl edit configmap <pod-name> -n kube-system
```
This command opens the configmap in an editor where you can make the necessary changes.

**What should be checked?** 

You need to monitor for Out Of Memory (OOM) kills on the nodes because misconfiguration of the Cluster Proportional Autoscaler can lead to insufficient memory allocation for the Konnectivity agents. Here are the key reasons:

**High Memory Usage:** As the cluster grows, the memory usage of Konnectivity agents can increase significantly, especially during peak loads or when handling large numbers of connections. If the Cluster Proportional Autoscaler configuration does not scale the replicas appropriately, the agents may run out of memory.

**Fixed Resource Limits:** If the resource requests and limits for the Konnectivity agents are set too low, they may not have enough memory to handle the workload, leading to OOM kills. Misconfigured Cluster Proportional Autoscaler settings can exacerbate this issue by not providing enough replicas to distribute the load.

**Cluster Size and Workload Variability:** The CPU and memory needed by the Konnectivity agents can vary widely depending on the size of the cluster and the workload. If the Cluster Proportional Autoscaler ladder configuration is not right-sized and adaptively resized for the cluster's usage patterns, it can lead to memory overcommitment and OOM kills.

Here are the steps to identify and troubleshoot OOM Kills:

1. Check for OOM Kills on Nodes: Use the following command to check for OOM Kills on your nodes:

```
kubectl get events --all-namespaces | grep -i 'oomkill'
```

2. Inspect Node Resource Usage: Verify the resource usage on your nodes to ensure they are not running out of memory:

```
kubectl top nodes
```

3.  Review Pod Resource Requests and Limits: Ensure that the Konnectivity agent pods have appropriate resource requests and limits set to prevent OOM Kills:

```
kubectl get pod <pod-name> -n kube-system -o yaml | grep -A5 "resources:"
```

4.  Adjust Resource Requests and Limits: If necessary, adjust the resource requests and limits for the Konnectivity agent pods by editing the deployment:

```
kubectl edit deployment konnectivity-agent -n kube-system
```

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
