---
title: Troubleshoot the Node Auto-provisioning managed add-on
description: Learn how to troubleshoot Node Auto-provisisioning in Azure Kubernetes Service (AKS).
ms.service: azure-kubernetes-service
ms.date: 09/05/2025
editor: bsoghigian
ms.reviewer: 
#Customer intent: As an Azure Kubernetes Service user, I want to troubleshoot problems that involve Node Auto-provisioining managed add-on so that I can successfully provision, scale, and manage my nodes and workloads on Azure Kubernetes Service (AKS).
ms.custom: sap:Extensions, Policies and Add-Ons
---

# Troubleshoot node auto provisioning (NAP) in Azure Kubernetes Service (AKS)

This article discusses how to troubleshoot Node auto provisioning(NAP), a managed add-on based on the open source [Karpenter](https://karpenter.sh) project. NAP automatically provisions and manages nodes in response to pending pod pressure, and manages scaling events at the virtual machine, or node level.
 When you enable Node Auto-provisioning, you might experience problems that are associated with the configuration of the infrastructure autoscaler. This article will help you troubleshoot errors and resolve common problems that affect NAP but aren't covered in the official Karpenter [FAQ][karpenter-faq] and [troubleshooting guide][karpenter-troubleshooting].

## Prerequisites

Ensure the following tools are installed and configured. They're used in the following sections.

- [Azure CLI](/cli/azure/install-azure-cli). To install kubectl by using the [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, a Kubernetes command-line client. This is available with the Azure CLI.
- Confirm you have Node Auto-provisioning enabled on your cluster.

## Common Issues

### Nodes Not Being Removed

**Symptoms**: Underutilized or empty nodes remain in the cluster longer than expected.

**Debugging Steps**:

1. **Check node utilization**:
```azurecli-interactive
kubectl top nodes
kubectl describe node <node-name>
```
You can also use the open-source [AKS Node Viewer](https://github.com/Azure/aks-node-viewer) tool to visualize node usage.

2. **Look for blocking pods**:
```azurecli-interactive
kubectl get pods --all-namespaces --field-selector spec.nodeName=<node-name>
```

3. **Check for disruption blocks**:
```azurecli-interactive
kubectl get events | grep -i "disruption\|consolidation"
```

**Common Causes**:
- Pods without proper tolerations
- DaemonSets preventing drain
- Pod disruption budgets(PDBs) are not properly set
- Nodes are marked with `do-not-disrupt` annotation
- Locks blocking changes

**Solutions**:
- Add proper tolerations to pods
- Review DaemonSet configurations  
- Adjust pod disruption budgets to allow disruption
- Remove `do-not-disrupt` annotations if appropriate
- Review lock configurations


## Networking Issues

### Pod Connectivity Problems

**Symptoms**: Pods can't communicate with other pods or external services.

**Debugging Steps**:

1. **Test basic connectivity**:
```azurecli-interactive
# From within a pod
kubectl exec -it <pod-name> -- ping <target-ip>
kubectl exec -it <pod-name> -- nslookup kubernetes.default
```

Another option to test node to node or pod to pod connectivity is with the open-source [goldpinger](https://github.com/bloomberg/goldpinger) tool. 

2. **Check network plugin status**:
```azurecli-interactive
kubectl get pods -n kube-system | grep -E "azure-cni|kube-proxy"
```
3. **If using azure cni with overlay or cilium** 
Validate your nodes have these labels 

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

**Understanding conflist files**:
- `10-azure.conflist`: Standard Azure CNI configuration for traditional networking with all CNI's not using overlay
- `15-azure-swift-overlay.conflist`: Azure CNI with overlay networking (used with Cilium or overlay mode)

**Inspect the configuration content**:
```azurecli-interactive
# Check the actual CNI configuration
cat /etc/cni/net.d/*.conflist

# Look for key fields:
# - "type": should be "azure-vnet" for Azure CNI
# - "mode": "bridge" for standard, "transparent" for overlay
# - "ipam": IP address management configuration
```

**Common conflist issues**:
- Missing or corrupted configuration files
- Incorrect network mode for your cluster setup
- Mismatched IPAM configuration
- Wrong plugin order in the configuration chain

5. **Check CNI to CNS communication**:
```azurecli-interactive
# Check CNS logs for IP allocation requests from CNI
kubectl logs -n kube-system -l k8s-app=azure-cns --tail=100
```

**CNI to CNS Troubleshooting**:
- **If CNS logs show "no IPs available"**: This indicates a CNS or aks's watch on the NNCs.
- **If CNI calls don't appear in CNS logs**: You likely have the wrong CNI installed. Verify the correct CNI plugin is deployed.

**Common Causes**:
- Network security group(NSG) rules
- Incorrect subnet configuration
- CNI plugin issues
- DNS resolution problems

**Solutions**:
- Review [Network Sescurity Group][network-security-group-docs] rules for required traffic
- Verify subnet configuration in AKSNodeClass. See [AKSNodeClass documentation][aksnodeclass-subnet-config] on subnet configuration
- Restart CNI plugin pods
- Check CoreDNS configuration. See [CoreDNS documentation][coredns-troubleshoot]

### DNS Service IP Issues

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
dig google.com
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
- Use different VM sizes with available quota

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]


[aks-firewall-requirements]: /azure/aks/limit-egress-traffic#azure-global-required-network-rules
[karpenter-troubleshooting]: https://karpenter.sh/docs/troubleshooting/
[karpenter-faq]: https://karpenter.sh/docs/faq/
[network-security-group-docs]: /azure/virtual-network/network-security-groups-overview
[aksnodeclass-subnet-config]: /azure/aks/node-autoprovision-aksnodeclass#virtual-network-subnet-configuration
[coredns-troubleshoot]: /azure/aks/coredns-custom#troubleshooting

