---
title: Troubleshoot Node Auto-Provisioning Managed Add-on
description: Learn how to troubleshoot node auto-provisioning (NAP) in Azure Kubernetes Service (AKS).
ms.service: azure-kubernetes-service
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 09/05/2025
editor: bsoghigian
ms.reviewer: phwilson, v-ryanberg, v-gsitser
#Customer intent: As an Azure Kubernetes Service user, I want to troubleshoot problems that involve node auto-provisioning managed add-ons so that I can successfully provision, scale, and manage my nodes and workloads on Azure Kubernetes Service (AKS).
ms.custom: sap:Extensions, Policies and Add-Ons
---

# Troubleshoot node auto-provisioning (NAP) in Azure Kubernetes Service (AKS)

This article discusses how to troubleshoot node auto-provisioning (NAP). NAP is a managed add-on that's based on the open source [Karpenter](https://karpenter.sh) project. NAP automatically provisions and manages nodes in response to pending pod pressure, and manages scaling events at the virtual machine (VM) or node level.

When you enable NAP, you might encounter issues that are associated with the configuration of the infrastructure autoscaler. This article helps you troubleshoot errors and resolve common issues that affect NAP but aren't covered in the Karpenter [FAQ][karpenter-faq] or [troubleshooting guide][karpenter-troubleshooting].

## Prerequisites

Make sure that the following tools are installed and configured:

- [Azure Command-Line Interface (CLI)](/cli/azure/install-azure-cli). To install kubectl by using the [Azure CLI](/cli/azure/install-azure-cli), run the `[az aks install-cli](/cli/azure/aks#az-aks-install-cli)` command.
- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, a Kubernetes command-line client that's available together with Azure CLI.
- NAP, enabled on your cluster. For more information, see [node auto provisioning documentation][nap-main-docs].

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

2. **Look for blocking pods**

Run the following command:

```azurecli-interactive
kubectl get pods --all-namespaces --field-selector spec.nodeName=<node-name>
```

3. **Check for disruption blocks**

Run the following command:

```azurecli-interactive
kubectl get events | grep -i "disruption\|consolidation"
```

**Cause**

Common causes include:

- Pods that have no proper tolerations
- DaemonSets that prevent drain
- Pod disruption budgets (PDBs) that aren't correctly set
- Nodes that are marked by a `do-not-disrupt` annotation
- Locks that block changes

**Solution**

Possible solutions include:

- Add proper tolerations to pods.
- Review `DaemonSet` configurations.  
- Adjust PDBs to allow disruption.
- Remove the `do-not-disrupt` annotations, as appropriate.
- Review lock configurations.

## Networking issues

For most networking-related issues, you can use either of the available levels of networking observability:

- [Container network metrics][aks-container-metrics] (default): Enables observation of node-level metrics. 
- [Advanced container network metrics][advanced-container-network-metrics]: Enables observation of pod-level metrics, including fully qualified domain name (FQDN) metrics for troubleshooting.

### Pod connectivity issues

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

2. **Check network plugin status**

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

4. **Verify the CNI configuration files**

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

**Common conflist issues**

Common conflist issues include: 

- Missing or corrupted configuration files
- Incorrect network mode for your cluster setup
- Mismatched IP Address Management (IPAM) configuration
- Wrong plugin order in the configuration chain

5. **Check CNI-to-Advanced Container Networking Services (ACNS) communication**

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
- CNI plugin issues
- DNS resolution problems

**Solution**

Possible solutions include:

- Review the [Network Security Group][network-security-group-docs] rules for required traffic.
- Verify the subnet configuration in `AKSNodeClass`. For more information, see [AKSNodeClass documentation][aksnodeclass-subnet-config].
- Restart the CNI plugin pods.
- Check the `CoreDNS` configuration. For more information, see [CoreDNS documentation][coredns-troubleshoot].

### DNS service IP issues

> [!NOTE]
> The `--dns-service-ip` parameter is supported for only NAP clusters and isn't available for self-hosted Karpenter installations.

**Symptoms**

Pods can't resolve DNS names or kubelet doesn't register together with the API server because of DNS resolution failures.

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

2. **Verify DNS service IP matches cluster configuration**

Run the following command:

```azurecli-interactive
# Get the actual DNS service IP from your cluster
kubectl get service -n kube-system kube-dns -o jsonpath='{.spec.clusterIP}'

# Compare with what AKS reports
az aks show --resource-group <rg> --name <cluster-name> --query "networkProfile.dnsServiceIp" -o tsv
```

3. **Test DNS resolution from the node**

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

4. **Check DNS pods status**

Run the following command:

```azurecli-interactive
# Verify CoreDNS pods are running
kubectl get pods -n kube-system -l k8s-app=kube-dns

# Check CoreDNS logs for errors
kubectl logs -n kube-system -l k8s-app=kube-dns --tail=50
```

5. **Verify network connectivity to DNS service**

Run the following command:

```azurecli-interactive
# From the Karpenter node, test connectivity to DNS service
telnet 10.0.0.10 53  # Replace with your actual DNS service IP
# Or using nc if telnet is not available
nc -zv 10.0.0.10 53
```

**Cause**

Common causes include:

- The `--dns-service-ip` parameter in `AKSNodeClass` is incorrect.
- The DNS service IP isn't in the service Classless Inter-Domain Routing (CIDR) range.
- Network connectivity issues exist between the node and DNS service.
- `CoreDNS` pods aren't running or are misconfigured.
- Firewall rules block DNS traffic.

**Solution**

Possible solutions include:

- Verify that the `--dns-service-ip` value matches the actual DNS service. To verify, run the following command: 

```azurecli-interactive
kubectl get svc -n kube-system kube-dns -o jsonpath='{.spec.clusterIP}'
```

- Make sure that the DNS service IP is within the service CIDR range specified during cluster creation.
- Check whether Karpenter nodes can reach the service subnets
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

2. **Monitor spot VM pricing**

Run the following command:

```azurecli-interactive
az vm list-sizes --location <region> --query "[?contains(name, 'Standard_D2s_v3')]"
```

**Solution**

Possible solutions include:

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

Possible solutions include:

- Request quota increases through the Azure portal.
- Expand nodepool custom resource definitions (CRDs) to include more VM sizes. For more information, see [NodePool configuration documentation][nap-nodepool-docs]. For example, nodepool specification A is less likely than nodepool specification B to trigger quota errors that stop VM creation if A includes D-family VMs and B is specific to only one VM size.

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](~/includes/azure-help-support.md)]
