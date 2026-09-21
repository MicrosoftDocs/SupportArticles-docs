---
title: Troubleshoot NFtable
description: Troubleshooting for nftables configuration in AKS, including steps to verify kube-proxy settings and common issues.
author: sufuf3
ms.author: shanjungfu
ms.topic: troubleshooting 
ms.date: 05/04/2026
---

# Troubleshoot nftables cofiguration

nftables is the third kube-proxy backend mode supported in AKS, alongside iptables (default) and IPVS. It leverages the Linux nftables subsystem—the successor to iptables—to implement Layer 3/Layer 4 service load balancing within the cluster.  
Compared to iptables and IPVS, nftables provides improved performance and scalability, and is recommended as the long-term replacement for IPVS. Additionally, unlike IPVS mode, nftables is fully compatible with Azure Network Policy, making it a more suitable choice for environments requiring network policy enforcement.

## Troubleshooting check list 
<!--- Provide the guidance/instruction about how the customer can troubleshoot the issues and determine the cause of the issue. --->

### Step 1: Confirm the cluster is configured for nftables mode

Check networkProfile.kubeProxyConfig in the cluster properties and ensure the Kubernetes version is >= 1.33.0.

```bash
$ az aks show --resource-group <ResourceGroupName> -n <ClusterName> --query networkProfile.kubeProxyConfig
"networkProfile": {
    "kubeProxyConfig": {
        "enabled": true,
        "mode": "NFTABLES"
    }
}
```

### Step 2: Verify kube-proxy pods are running

Check that all kube-proxy pods are in `Running` state with 0 restarts.
```sh
$ kubectl get pods -n kube-system -owide | grep kube-proxy
```

### Step 3: Verify kube-proxy command-line args

Describe a kube-proxy pod and confirm `--proxy-mode=nftables` is present:

```bash
$ kubectl describe pod -n kube-system <kube-proxy-pod>
```

Expected args for nftables mode:

```yaml
Containers:
  kube-proxy:
    Command:
      kube-proxy
      --conntrack-max-per-core=0
      --metrics-bind-address=0.0.0.0:10249
      --kubeconfig=/var/lib/kubelet/kubeconfig
      --cluster-cidr=10.244.0.0/16
      --detect-local-mode=ClusterCIDR
      --v=3
      --proxy-mode=nftables
```

Note: there should be **no** IPVS-specific args (`--ipvs-scheduler`, `--ipvs-tcp-timeout`, etc.). If `--proxy-mode=nftables` is missing, confirm the Kubernetes version is >= 1.33.0 and that the goal state has the correct mode.

### Step 4: Verify nftables rules on a node or kube-proxy pod

You can inspect the nftables ruleset either by SSH/JIT-ing to a node, or by `kubectl exec`-ing into the kube-proxy pod (which shares the host network namespace):

```bash
# From a node
$ nft list ruleset

# Or from inside the kube-proxy pod
$ kubectl -n kube-system exec -it <kube-proxy-pod> -- nft list ruleset
```

When kube-proxy is running in nftables mode, you should see a table named `ip kube-proxy` containing chains for service routing (e.g., `services`, `service-endpoints`, `filter-prerouting`, `filter-output`, etc.).

Example output (abbreviated):

```text
table ip kube-proxy {
    chain services {
        type nat hook prerouting priority dstnat; policy accept;
        ip daddr . meta l4proto . th dport vmap @service-ips
    }

    chain service-endpoints {
        ...
    }

    chain filter-prerouting {
        type filter hook prerouting priority -110; policy accept;
        ct state new jump firewall-check
    }

    chain masquerading {
        type nat hook postrouting priority srcnat; policy accept;
        ...
    }
}
```

If `nft list ruleset` shows no `kube-proxy` table:

- kube-proxy may not have started in nftables mode — check Step 3.
- The `nft` binary may not be installed — install with `apt install nftables`.
- Check kube-proxy logs for errors: `kubectl logs -n kube-system <kube-proxy-pod>`.

**Tip**: To check rules for a specific service, look for the service's ClusterIP in the nftables maps:

```bash
$ nft list map ip kube-proxy service-ips
```

### Step 5: Verify Calico linuxDataplane (if applicable)

For clusters using Calico network policy (kubenet or Azure CNI with Calico), verify the Calico Installation CR is configured for nftables:

```bash
$ kubectl get installation default -o yaml | grep linuxDataplane
```

Expected output:

```yaml
    linuxDataplane: Nftables
```

If this field is missing or shows a different value, Calico's Felix component may be using the iptables backend, which can cause rule conflicts with kube-proxy in nftables mode. Check:

1. Kubernetes version is >= 1.33.0 (Calico nftables also gates on this).
2. The Calico synth or Helm template rendered the correct value.
3. Calico operator logs: `kubectl logs -n calico-system deployment/tigera-operator`.

### Step 6: Check kube-proxy logs

If service connectivity issues persist, check kube-proxy logs for errors:

```bash
# Current container logs
$ kubectl logs -n kube-system <kube-proxy-pod>

# Previous container logs (useful after a crash)
$ kubectl logs -n kube-system --previous <kube-proxy-pod>
```

Common log messages to look for:

- `"Using nftables Proxier"` — confirms nftables mode is active.
- `"Failed to execute nft"` — indicates an issue running nft commands on the node.
- `"Error syncing proxy rules"` — nftables rule programming failed.


## Issue 1: nftables mode silently not applied (k8s < 1.33.0)
### Symptom
Cluster API shows `mode: NFTABLES` but kube-proxy runs with `--proxy-mode=iptables` (or no `--proxy-mode` flag).
### Cause
The API validator does not enforce a minimum Kubernetes version for nftables mode. The Helm template only renders `--proxy-mode=nftables` when k8s >= 1.33.0. On older versions, the flag is silently omitted.
### Resolution
Upgrade the cluster to Kubernetes >= 1.33.0.

## Issue 2: Feature flag not registered (error 1132)
### Symptom
API call to create or update the cluster returns error code 1132 (`KubeProxyConfigFeatureNotRegistered`).
### Cause
The AFEC feature flag `Microsoft.ContainerService/KubeProxyConfigurationPreview` is not registered on the subscription.
### Resolution
Register the feature flag:
```sh
az feature register --namespace "Microsoft.ContainerService" --name "KubeProxyConfigurationPreview"
# Wait for status to show "Registered", then:
az provider register --namespace Microsoft.ContainerService
```

## Issue 3: IPVS config fields rejected (error 1133)
### Symptom
API returns error code 1133 (`KubeProxyConfigFieldUnsupported`) when creating or updating with nftables mode.
### Cause
The customer included IPVS-specific fields (e.g., `scheduler`, `TCPTimeoutSeconds`, `TCPFINTimeoutSeconds`, U`DPTimeoutSeconds`) in the `kubeProxyConfig` while setting mode to `NFTABLES`.
### Resolution
Remove all `ipvsConfig` fields from the configuration. nftables mode does not accept IPVS-specific settings. Example valid config:
```json
{
  "enabled": true,
  "mode": "NFTABLES"
}
```

## Issue 4: Cilium dataplane conflict
### Symptom
API returns error with SubCode `CiliumDataplaneRequiresKubeProxyConfigDisabled`.
### Cause
Cilium replaces kube-proxy entirely. Any `kubeProxyConfig` with `enabled: true` is rejected on Cilium dataplane clusters.
### Resolution
nftables mode cannot be used with Cilium dataplane. If the customer wants nftables proxy behavior, they need to use a non-Cilium network configuration.

## Issue 5: Service connectivity issues after mode transition
### Symptom
Some services are unreachable briefly after switching from iptables/IPVS to nftables.
### Cause
During the transition, nodes may have stale iptables or IPVS rules until the kube-proxy daemonset rollout completes on all nodes.
### Resolution
Wait for the kube-proxy daemonset rollout to finish:
```sh
$ kubectl rollout status daemonset/kube-proxy -n kube-system
```
kube-proxy cleans up old rules from the previous mode on restart. If connectivity issues persist after rollout completes, cordon and drain affected nodes to force a fresh start.

## Issue 6: Calico/Felix errors after enabling nftables
### Symptom
Calico Felix pods log errors about nftables or iptables rule conflicts. Network policy enforcement may be inconsistent.
### Cause
Calico's Felix was not switched to nftables backend when kube-proxy mode changed. This can happen if the cluster k8s version is below the 1.33.0 gate or the Calico Installation CR was not updated.
### Resolution
Verify `linuxDataplane: Nftables` in the Calico Installation CR (see Step 5). If missing, the Calico chart or synth may need redeployment. Escalate to the networking SIG if the field cannot be set.

## CNI Compatibility

| Network Plugin | nftables Support | Notes |
|----------------|-----------------|-------|
| Azure CNI | Supported | Works directly. |
| Kubenet | Supported | Works with Calico network policy. |
| BYO CNI (`none`) | Supported | If kube-proxy is enabled. |
| Cilium Dataplane | **Not supported** | Cilium replaces kube-proxy. `kubeProxyConfig.enabled` must be `false`. |

Azure Network Policy is **supported** with nftables mode (unlike IPVS, which does not support Azure Network Policy).
