---
title: Troubleshoot Node Auto-Provisioning Managed Add-on
description: Learn how to troubleshoot node auto-provisisioning (NAP) in Azure Kubernetes Service (AKS).
ms.service: azure-kubernetes-service
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 09/05/2025
editor: bsoghigian
ms.reviewer: phwilson, v-ryanberg, v-gsitser
#Customer intent: As an Azure Kubernetes Service user, I want to troubleshoot problems that involve Node Auto Provisioining managed add-on so that I can successfully provision, scale, and manage my nodes and workloads on Azure Kubernetes Service (AKS).
ms.custom: sap:Extensions, Policies and Add-Ons
---

# Troubleshoot node auto-provisioning (NAP) in Azure Kubernetes Service (AKS)

This article discusses how to troubleshoot node auto-provisioning (NAP), a managed add-on based on the open source [Karpenter](https://karpenter.sh) project. NAP automatically provisions and manages nodes in response to pending pod pressure and manages scaling events at the virtual machine or node level.

When you enable NAP, you can experience problems associated with the configuration of the infrastructure autoscaler. This article  helps you troubleshoot errors and resolve common problems that affect NAP but aren't covered in Karpenter [FAQ][karpenter-faq] or [troubleshooting guide][karpenter-troubleshooting].

## Prerequisites

Ensure the following tools are installed and configured. They're used in the following sections.

- [Azure Command-Line Interface (CLI)](/cli/azure/install-azure-cli). To install kubectl by using the [Azure CLI](/cli/azure/install-azure-cli), run the `[az aks install-cli](/cli/azure/aks#az-aks-install-cli)` command.
- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, a Kubernetes command-line client. This is available with Azure CLI.
- Confirm you have NAP enabled on your cluster. For more information, see [node auto provisioning documentation][nap-main-docs].

## Common issues

### Nodes not being removed

**Symptoms**

Underutilized or empty nodes remain in the cluster longer than expected.

**Debugging steps**

1. **Check node utilization**

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

**Common causes**

Common causes include:

- Pods without proper tolerations.
- DaemonSets preventing drain.
- Pod disruption budgets (PDBs) aren't properly set.
- Nodes are marked with `do-not-disrupt` annotation.
- Locks blocking changes.

**Solutions**

Solutions include:

- Adding proper tolerations to pods.
- Reviewing DaemonSet configurations.  
- Adjusting PDBs to allow disruption
- Removing `do-not-disrupt` annotations if appropriate.
- Reviewing lock configurations.

## Networking issues

For most networking-related issues, there are two levels available for networking observability:

- [Container network metrics][aks-container-metrics] (default): Allows for node level metrics. 
- [Advanced container network metrics][advanced-container-network-metrics]: In addition to node level metrics, you can also observe pod-level metrics including fully qualified domain name (FQDN) metrics for troubleshooting.

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

Another option to test node-to-node or pod-to-pod connectivity is with the open-source [goldpinger](https://github.com/bloomberg/goldpinger) tool. 

2. **Check network plugin status**

Run the following command:

```azurecli-interactive
kubectl get pods -n kube-system | grep -E "azure-cni|kube-proxy"
```

If you're using Azure Container Networking Interface (CNI) with overlay, verfify your nodes have these labels: 

```azurecli-interactive
    kubernetes.azure.com/azure-cni-overlay: "true"
    kubernetes.azure.com/network-name: aks-vnet-<redacted>
    kubernetes.azure.com/network-resourcegroup: <redacted>
    kubernetes.azure.com/network-subscription: <redacted>
```

4. **Validate the CNI configuration files**

The CNI conflist files define network plugin configurations. Check which files are present:

```azurecli-interactive
# List CNI configuration files
ls -la /etc/cni/net.d/

# Example output:
# 10-azure.conflist   15-azure-swift-overlay.conflist
```

**Understanding conflist files**

For this scenario, there are two types of conflist files:

- `10-azure.conflist`: Standard Azure CNI configuration for traditional networking with all CNIs not using overlay.
- `15-azure-swift-overlay.conflist`: Azure CNI with overlay networking (used with Cilium or overlay mode).

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

- Missing or corrupted configuration files.
- Incorrect network mode for your cluster setup.
- Mismatched IP Address Management (IPAM) configuration.
- Wrong plugin order in the configuration chain.

5. **Check CNI-to-Advanced Container Networking Services (ACNS) communication**

Run the following command:

```azurecli-interactive
# Check CNS logs for IP allocation requests from CNI
kubectl logs -n kube-system -l k8s-app=azure-cns --tail=100
```

**CNI-to-ACNS troubleshooting**

- **If ACNS logs show "no IPs available"**: This indicates an ACNS or AKS watch on the Neural Network Coding (NNC).
- **If CNI calls don't appear in ACNS logs**: You likely have the wrong CNI installed. Verify the correct CNI plugin is deployed.

**Common causes**

Common causes include:

- Network security group rules.
- Incorrect subnet configuration.
- CNI plugin issues.
- DNS resolution problems.

**Solutions**

Solutions include:

- Reviewing [Network Sescurity Group][network-security-group-docs] rules for required traffic.
- Verifying subnet configuration in `AKSNodeClass`. For more information, see [AKSNodeClass documentation][aksnodeclass-subnet-config].
- Restarting CNI plugin pods.
- Checking `CoreDNS` configuration. For more information, see [CoreDNS documentation][coredns-troubleshoot].

### DNS service IP issues

>[!NOTE]
>The `--dns-service-ip` parameter is only supported for NAP (Node Auto Provisioning) clusters and is not available for self-hosted Karpenter installations.

**Symptoms**: Pods can't resolve DNS names or kubelet fails to register with API server due to DNS resolution failures.

**Debugging Steps**:

1. **Check kubelet DNS configuration**:
```azurecli-interactive
# SSH to the Karpenter node and check kubelet config
sudo cat /var/lib/kubelet/config.yaml | grep -A 5 clusterDNS

# Expected output should show the correct DNS service IP
# clusterDNS:
# - "10.0.0.10"  # This should match your cluster's DNS service IP
```

2. **Verify DNS service IP matches cluster configuration**:
```azurecli-interactive
# Get the actual DNS service IP from your cluster
kubectl get service -n kube-system kube-dns -o jsonpath='{.spec.clusterIP}'

# Compare with what AKS reports
az aks show --resource-group <rg> --name <cluster-name> --query "networkProfile.dnsServiceIp" -o tsv
```

3. **Test DNS resolution from the node**:
```azurecli-interactive
# SSH to the Karpenter node and test DNS resolution
# Test using the DNS service IP directly
dig @10.0.0.10 kubernetes.default.svc.cluster.local

# Test using system resolver
nslookup kubernetes.default.svc.cluster.local

# Test external DNS resolution
dig azure.com
```

4. **Check DNS pods status**:
```azurecli-interactive
# Verify CoreDNS pods are running
kubectl get pods -n kube-system -l k8s-app=kube-dns

# Check CoreDNS logs for errors
kubectl logs -n kube-system -l k8s-app=kube-dns --tail=50
```

5. **Validate network connectivity to DNS service**:
```azurecli-interactive
# From the Karpenter node, test connectivity to DNS service
telnet 10.0.0.10 53  # Replace with your actual DNS service IP
# Or using nc if telnet is not available
nc -zv 10.0.0.10 53
```

**Common Causes**:
- Incorrect `--dns-service-ip` parameter in AKSNodeClass
- DNS service IP not in the service CIDR range
- Network connectivity issues between node and DNS service
- CoreDNS pods not running or misconfigured
- Firewall rules blocking DNS traffic

**Solutions**:
- Verify `--dns-service-ip` matches the actual DNS service: `kubectl get svc -n kube-system kube-dns -o jsonpath='{.spec.clusterIP}'`
- Ensure DNS service IP is within the service CIDR range specified during cluster creation
- Check that Karpenter nodes can reach the service subnet
- Restart CoreDNS pods if they're in error state: `kubectl rollout restart deployment/coredns -n kube-system`
- Verify NSG rules allow traffic on port 53 (TCP/UDP)
- Run a connectivity analysis with the [Azure Virtual Network Verifier][connectivity-tool] tool to validate outbound connectivity

## Azure-Specific Issues

### Spot VM Issues

**Symptoms**: Unexpected node terminations when using spot instances.

**Debugging Steps**:

1. **Check node events**:

```azurecli-interactive
kubectl get events | grep -i "spot\|evict"
```

2. **Monitor spot VM pricing**:

```azurecli-interactive
az vm list-sizes --location <region> --query "[?contains(name, 'Standard_D2s_v3')]"
```

**Solutions**:
- Use diverse instance types for better availability
- Implement proper pod disruption budgets
- Consider mixed spot/on-demand strategies
- Use workloads tolerant of node preemption

### Quota Exceeded

**Symptoms**: VM creation fails with quota exceeded errors.

**Debugging Steps**:

1. **Check current quota usage**:
```azurecli-interactive
az vm list-usage --location <region> --query "[?currentValue >= limit]"
```

**Solutions**:
- Request quota increases through Azure portal
- Expand NodePool CRD to more VM sizes. See [NodePool configuration documentation][nap-nodepool-docs] for details. For example, A NodePool specification which allows for D-family virtual machines is less likely to hit quota errors that stop VM creation, compared to a NodePool specification specific to only one exact VM Size. 

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]


[aks-firewall-requirements]: /azure/aks/limit-egress-traffic#azure-global-required-network-rules
[karpenter-troubleshooting]: https://karpenter.sh/docs/troubleshooting/
[karpenter-faq]: https://karpenter.sh/docs/faq/
[network-security-group-docs]: /azure/virtual-network/network-security-groups-overview
[aksnodeclass-subnet-config]: /azure/aks/node-autoprovision-aksnodeclass#virtual-network-subnet-configuration
[nap-nodepool-docs]: /azure/aks/node-autoprovision-node-pools
[nap-main-docs]: /azure/aks/node-autoprovision
[coredns-troubleshoot]: /azure/aks/coredns-custom#troubleshooting
[aks-container-metrics]: /azure/aks/container-network-observability-metrics
[advanced-container-network-metrics]: /azure/aks/advanced-container-networking-services-overview
[connectivity-tool]: /azure/azure-kubernetes/connectivity/basic-troubleshooting-outbound-connections#check-if-azure-network-resources-are-blocking-traffic-to-the-endpoint

