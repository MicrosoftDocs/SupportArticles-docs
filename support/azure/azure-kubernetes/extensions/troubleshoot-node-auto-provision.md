---
title: Troubleshoot Node Auto-Provisioning Managed Add-on
description: Troubleshoot node auto-provisioning (NAP) issues in Azure Kubernetes Service (AKS) and fix scaling, networking, and quota errors to restore reliability. Start now.
ms.service: azure-kubernetes-service
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 04/09/2026
editor: bsoghigian
ms.reviewer: wilsondarko, phwilson, v-ryanberg, v-gsitser
#Customer intent: As an Azure Kubernetes Service user, I want to troubleshoot problems that involve node auto-provisioning managed add-ons so that I can successfully provision, scale, and manage my nodes and workloads on Azure Kubernetes Service (AKS).
ms.custom: sap:Extensions, Policies and Add-Ons
---

# Troubleshoot node auto-provisioning (NAP) in Azure Kubernetes Service (AKS)

## Summary

This article discusses how to troubleshoot [node auto-provisioning (NAP)](/azure/aks/node-auto-provisioning). NAP is a managed add-on that's based on the open source [Karpenter](https://karpenter.sh) project. NAP automatically provisions and manages nodes in response to pending pod pressure, and manages scaling events at the virtual machine (VM) or node level.

When you enable NAP, you might encounter issues that are associated with the configuration of the infrastructure autoscaler. This article helps you troubleshoot errors and resolve common issues that affect NAP but aren't covered in the open-source [Karpenter FAQ](https://karpenter.sh/docs/faq/) or [troubleshooting guide](https://karpenter.sh/docs/troubleshooting/).

## Prerequisites

Make sure that the following tools are installed and configured:

- [Azure Command-Line Interface (CLI)](/cli/azure/install-azure-cli). To install kubectl by using the [Azure CLI](/cli/azure/install-azure-cli), run the `[az aks install-cli](/cli/azure/aks#az-aks-install-cli)` command.
- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, a Kubernetes command-line client that's available together with Azure CLI.
- NAP, enabled on your cluster. For more information, see [node auto provisioning documentation](/azure/aks/node-auto-provisioning).

## Common issues

### Nodes aren't removed

**Symptoms**

Underused or empty nodes remain in the cluster longer than you expect.

**Debugging steps**

1. **Check node usage**

Run the following command:

```azurecli-interactive
kubectl top nodes
kubectl describe node <node-name>
```

You can also use the open-source [AKS Node Viewer](https://github.com/Azure/aks-node-viewer) tool to visualize node usage.

1. **Look for blocking pods**

Run the following command:

```azurecli-interactive
kubectl get pods --all-namespaces --field-selector spec.nodeName=<node-name>
```

1. **Check for disruption blocks**

Run the following command:

```azurecli-interactive
kubectl get events | grep -i "disruption\|consolidation"
```

**Cause**

Common causes include:

- Pods that don't have proper tolerations
- DaemonSets that prevent drain
- Pod disruption budgets (PDBs) that aren't correctly set
- Nodes that have a `do-not-disrupt` annotation
- Locks that block changes

**Solution**

Try the following solutions:

- Add proper tolerations to pods.
- Review `DaemonSet` configurations.  
- Adjust PDBs to allow disruption.
- Remove the `do-not-disrupt` annotations, as appropriate.
- Review lock configurations.

## Networking issues

For most networking-related issues, use either of the available levels of networking observability:

- [Container network metrics](/azure/aks/advanced-container-networking-services-overview#container-network-metrics) (default): Enables observation of node-level metrics. 
- [Advanced container network metrics](/azure/aks/advanced-container-networking-services-overview): Enables observation of pod-level metrics, including fully qualified domain name (FQDN) metrics for troubleshooting.

### Pod connectivity problems

**Symptoms**

Pods can't communicate with other pods or external services.

**Debugging steps**

1. **Test basic connectivity**

Run the following command:

```azurecli-interactive
# From within a pod
kubectl exec -it <pod-name> -- ping <target-ip>
kubectl exec -it <pod-name> -- nslookup kubernetes.default
```

Another option is to use the open-source [goldpinger](https://github.com/bloomberg/goldpinger) tool. 

1. **Check network plugin status**

Run the following command:

```azurecli-interactive
kubectl get pods -n kube-system | grep -E "azure-cni|kube-proxy"
```

If you're using Azure Container Networking Interface (CNI) in overlay mode, verify that your nodes have these labels: 

```azurecli-interactive
    kubernetes.azure.com/azure-cni-overlay: "true"
    kubernetes.azure.com/network-name: aks-vnet-<redacted>
    kubernetes.azure.com/network-resourcegroup: <redacted>
    kubernetes.azure.com/network-subscription: <redacted>
```

1. **Verify the CNI configuration files**

The CNI conflist files define network plugin configurations. Check which files are present:

```azurecli-interactive
# List CNI configuration files
ls -la /etc/cni/net.d/

# Example output:
# 10-azure.conflist   15-azure-swift-overlay.conflist
```

**Understanding conflist files**

This scenario includes two kinds of conflist files:

- `10-azure.conflist`: Standard Azure CNI configuration for traditional networking of all CNIs that don't use overlay mode.
- `15-azure-swift-overlay.conflist`: Azure CNI Overlay networking (used by Cilium or in overlay mode).

**Inspect the configuration content**

Run the following command:

```azurecli-interactive
# Check the actual CNI configuration
cat /etc/cni/net.d/*.conflist

# Look for key fields:
# - "type": should be "azure-vnet" for Azure CNI
# - "mode": "bridge" for standard, "transparent" for overlay
# - "ipam": IP address management configuration
```

**Common conflist problems**

Common conflist problems include: 

- Missing or corrupted configuration files
- Incorrect network mode for your cluster setup
- Mismatched IP Address Management (IPAM) configuration
- Wrong plugin order in the configuration chain

1. **Check CNI-to-Advanced Container Networking Services (ACNS) communication**

Run the following command:

```azurecli-interactive
# Check CNS logs for IP allocation requests from CNI
kubectl logs -n kube-system -l k8s-app=azure-cns --tail=100
```

**CNI-to-ACNS troubleshooting**

- **If ACNS logs show "no IPs available"**: Indicates an ACNS or AKS watch that's enacted on the Neural Network Coding (NNC).
- **If CNI calls don't appear in ACNS logs**: Usually indicates that the wrong CNI is installed. Verify that the correct CNI plugin is deployed.

**Causes**

Common causes include:

- Network security group (NSG) rules
- Incorrect subnet configuration
- CNI plugin problems
- DNS resolution problems

**Solution**

Try the following solutions:

- Review the [Network Security Group](/azure/virtual-network/network-security-group-how-it-works) rules for required traffic.
- Verify the subnet configuration in `AKSNodeClass`. For more information, see [AKSNodeClass documentation](/azure/aks/node-auto-provisioning-aksnodeclass#virtual-network-vnet-subnet-configuration).
- Restart the CNI plugin pods.
- Check the `CoreDNS` configuration. For more information, see [CoreDNS documentation](/azure/aks/coredns-troubleshoot).

### Pod CIDR exhausted when using Azure CNI Overlay

**Symptoms**

When you use [Azure CNI Overlay](/azure/aks/concepts-network-azure-cni-overlay) with NAP, certain new nodes stay in a `NotReady` state as shown in the following example.

```yaml
kubectl get nodeclaim
```

Output:

```
NAME            TYPE                CAPACITY    ZONE             NODE                READY     AGE
default-abcde   Standard_D16as_v5   on-demand   eastus-2         aks-default-abcde   Unknown   3m13s
```

The status for the nodeclaim stays `Unknown` while the status for a `kubectl get node` command is `NotReady`.

**Cause**

When you use an Azure CNI Overlay network, each node always preallocates a /24 block (256 IP addresses) from the Pod CIDR. If the Pod CIDR isn't large enough, newly created nodes beyond a certain count can't get an IP address because the Pod CIDR is exhausted. These nodes stay in the `NotReady` state. For requirements for subnet sizing and IP address planning, see [Azure CNI Overlay documentation](/azure/aks/concepts-network-azure-cni-overlay).

**Debugging steps**

You can confirm this problem is happening by checking Kube events by running the following command:

```yaml
$ kubectl get events --field-selector involvedObject.kind=NodeNetworkConfig -A
```

You should find the following two responses included in the error codes:

```yaml
"primaryIP is nil, failed to allocate address for request"
```

```
"Subnet is full"
```

**Solution**

You can expand the pod CIDR range to allow more nodes to join the subnet. For more information, see [Expand pod CIDR space in Azure CNI Overlay](/azure/aks/azure-cni-overlay-pod-expand).

After updating the CIDR space, new nodes can join and their status updates to a `Ready` state as shown in the following example.

```yaml
kubectl get node
```

Output:

```yaml
NAME                                STATUS     ROLES    AGE     VERSION
aks-default-abcde                   Ready      <none>   2m58s   v1.33.7
```

### DNS service IP problems

> [!NOTE]
> The `--dns-service-ip` parameter supports only NAP clusters and isn't available for self-hosted Karpenter installations.

**Symptoms**

Pods can't resolve DNS names, or kubelet doesn't register together with the API server because of DNS resolution failures.

**Debugging steps**

1. **Check kubelet DNS configuration**

Run the following command:

```azurecli-interactive
# SSH to the Karpenter node and check kubelet config
sudo cat /var/lib/kubelet/config.yaml | grep -A 5 clusterDNS

# Expected output should show the correct DNS service IP
# clusterDNS:
# - "10.0.0.10"  # This should match your cluster's DNS service IP
```

1. **Verify DNS service IP matches cluster configuration**

Run the following command:

```azurecli-interactive
# Get the actual DNS service IP from your cluster
kubectl get service -n kube-system kube-dns -o jsonpath='{.spec.clusterIP}'

# Compare with what AKS reports
az aks show --resource-group <rg> --name <cluster-name> --query "networkProfile.dnsServiceIp" -o tsv
```

1. **Test DNS resolution from the node**

Run the following command:

```azurecli-interactive
# SSH to the Karpenter node and test DNS resolution
# Test using the DNS service IP directly
dig @10.0.0.10 kubernetes.default.svc.cluster.local

# Test using system resolver
nslookup kubernetes.default.svc.cluster.local

# Test external DNS resolution
dig azure.com
```

1. **Check DNS pods status**

Run the following command:

```azurecli-interactive
# Verify CoreDNS pods are running
kubectl get pods -n kube-system -l k8s-app=kube-dns

# Check CoreDNS logs for errors
kubectl logs -n kube-system -l k8s-app=kube-dns --tail=50
```

1. **Verify network connectivity to DNS service**

Run the following command:

```azurecli-interactive
# From the Karpenter node, test connectivity to DNS service
telnet 10.0.0.10 53  # Replace with your actual DNS service IP
# Or using nc if telnet isn't available
nc -zv 10.0.0.10 53
```

**Cause**

Common causes include:

- The `--dns-service-ip` parameter in `AKSNodeClass` is incorrect.
- The DNS service IP isn't in the service Classless Inter-Domain Routing (CIDR) range.
- Network connectivity problems exist between the node and DNS service.
- `CoreDNS` pods aren't running or are misconfigured.
- Firewall rules block DNS traffic.

**Solution**

Try the following solutions:

- Verify that the `--dns-service-ip` value matches the actual DNS service. To verify, run the following command: 

```azurecli-interactive
kubectl get svc -n kube-system kube-dns -o jsonpath='{.spec.clusterIP}'
```

- Make sure that the DNS service IP is within the service CIDR range specified during cluster creation.
- Check whether Karpenter nodes can reach the service subnets.
- Restart `CoreDNS pods` if they're in an error state. To restart, run the following command: 

```azurecli-interactive
kubectl rollout restart deployment/coredns -n kube-system
```

- Verify that NSG rules allow traffic on port 53 (TCP/User Datagram Protocol (UDP)).
- Run a connectivity analysis by using the [Azure Virtual Network Verifier](/azure/virtual-network-manager/overview) to verify outbound connectivity.

## Azure-specific issues

### Spot VM issues

**Symptoms**

Unexpected node terminations occur when you use spot instances.

**Debugging steps**

1. **Check node events**

Run the following command:

```azurecli-interactive
kubectl get events | grep -i "spot\|evict"
```

1. **Monitor spot VM pricing**

Run the following command:

```azurecli-interactive
az vm list-sizes --location <region> --query "[?contains(name, 'Standard_D2s_v3')]"
```

**Solution**

Try the following solutions:

- Use diverse instance types for better availability.
- Implement proper pod disruption budgets.
- Consider mixed spot and on-demand strategies.
- Use workloads that are tolerant of node preemption.

### Quota exceeded

**Symptoms**

VM creation fails and generates "quota exceeded" errors.

**Debugging steps**

1. **Check current quota usage**

Run the following command:
 
```azurecli-interactive
az vm list-usage --location <region> --query "[?currentValue >= limit]"
```

**Solution**

Try the following solutions:

- Request quota increases through the Azure portal.
- Expand nodepool custom resource definitions (CRDs) to include more VM sizes. For more information, see [NodePool configuration documentation](/azure/aks/node-auto-provisioning-node-pools). For example, nodepool specification A is less likely than nodepool specification B to trigger quota errors that stop VM creation if A includes D-family VMs and B is specific to only one VM size.

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]

 
