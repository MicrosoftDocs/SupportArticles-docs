---
title: Node Not Ready status after node is in a healthy state
description: Troubleshoot scenarios in which an Azure Kubernetes Service (AKS) cluster node goes to a Not Ready status after is in a healthy state.
ms.date: 08/27/2024
ms.reviewer: rissing, chiragpa, momajed, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to prevent an Azure Kubernetes Service (AKS) cluster node from regressing to a Not Ready status so that I can continue to use the cluster node successfully.
ms.custom: sap:Node/node pool availability and performance, innovation-engine
---

# Troubleshoot a change in a healthy node to Not Ready status

This article discusses a scenario in which the status of an Azure Kubernetes Service (AKS) cluster node changes to **Not Ready** after the node is in a healthy state for some time. This article outlines the particular cause and provides a possible solution.

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl by using Azure CLI, run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
- The Kubernetes [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) tool.
- The Kubernetes [containerd](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#containerd) tool.
- The following Linux tools:
  - [awk](https://man7.org/linux/man-pages/man1/awk.1p.html)
  - [head](https://man7.org/linux/man-pages/man1/head.1.html)
  - [journalctl](https://man7.org/linux/man-pages/man1/journalctl.1.html)
  - [ps](https://man7.org/linux/man-pages/man1/ps.1.html)
  - [sort](https://man7.org/linux/man-pages/man1/sort.1.html)
  - [watch](https://man7.org/linux/man-pages/man1/watch.1.html)

## Connect to the AKS cluster

Before you can troubleshoot the issue, you must connect to the AKS cluster. To do so, run the following commands:

```bash
export RANDOM_SUFFIX=$(head -c 3 /dev/urandom | xxd -p)
export RESOURCE_GROUP="my-resource-group$RANDOM_SUFFIX"
export AKS_CLUSTER="my-aks-cluster$RANDOM_SUFFIX"
az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER --overwrite-existing
```

## Symptoms

The status of a cluster node that has a healthy state (all services running) unexpectedly changes to **Not Ready**. To view the status of a node, run the following [kubectl describe](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#describe) command:

```bash
kubectl describe nodes
```

## Cause

The [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) stopped posting its **Ready** status.

Examine the output of the `kubectl describe nodes` command to find the [Conditions](https://kubernetes.io/docs/reference/node/node-status/#condition) field and the [Capacity and Allocatable](https://kubernetes.io/docs/reference/node/node-status/#capacity) blocks. Do the content of these fields appear as expected? (For example, in the **Conditions** field, does the `message` property contain the "kubelet is posting ready status" string?) In this case, if you have direct Secure Shell (SSH) access to the node, check the recent events to understand the error. Look within the */var/log/syslog* file instead of */var/log/messages* (not available on all distributions). Or, generate the kubelet and container daemon log files by running the following shell commands:

```bash
# First, identify the NotReady node
export NODE_NAME=$(kubectl get nodes --no-headers | grep NotReady | awk '{print $1}' | head -1)

if [ -z "$NODE_NAME" ]; then
    echo "No NotReady nodes found"
    kubectl get nodes
else
    echo "Found NotReady node: $NODE_NAME"
    
    # Use kubectl debug to access the node
    kubectl debug node/$NODE_NAME -it --image=mcr.microsoft.com/dotnet/runtime-deps:6.0 -- chroot /host bash -c "
        echo '=== Checking syslog ==='
        if [ -f /var/log/syslog ]; then
            tail -100 /var/log/syslog
        else
            echo 'syslog not found'
        fi
        
        echo '=== Checking kubelet logs ==='
        journalctl -u kubelet --no-pager | tail -100
        
        echo '=== Checking containerd logs ==='
        journalctl -u containerd --no-pager | tail -100
    "
fi
```

After you run these commands, examine the syslog and daemon log files for more information about the error.

## Solution

### Step 1: Check for changes in network-level

If all cluster nodes regressed to a **Not Ready** status, check whether any changes occurred at the network level. Examples of network-level changes include:

- Domain name system (DNS) changes
- Firewall rule changes, such as port, fully qualified domain names (FQDNs), and so on.
- Added network security groups (NSGs)
- Applied or changed route table configurations for AKS traffic

If there were changes at the network level, make any necessary corrections. If you have direct Secure Shell (SSH) access to the node, you can use the `curl` or `telnet` command to check the connectivity to [AKS outbound requirements](/azure/aks/outbound-rules-control-egress). After you've fixed the issues, stop and restart the nodes. If the nodes stay in a healthy state after these fixes, you can safely skip the remaining steps.

### Step 2: Stop and restart the nodes

If only a few nodes regressed to a **Not Ready** status, simply stop and restart the nodes. This action alone might return the nodes to a healthy state. Then, check [Azure Kubernetes Service diagnostics overview](/azure/aks/concepts-diagnostics) to determine whether there are any issues, such as the following issues:

- Node faults
- Source network address translation (SNAT) failures
- Node input/output operations per second (IOPS) performance issues
- Other issues

If the diagnostics don't discover any underlying issues and the nodes returned to Ready status, you can safely skip the remaining steps.

### Step 3: Fix SNAT issues for public AKS API clusters

Did AKS diagnostics uncover any SNAT issues? If so, take some of the following actions, as appropriate:

- Check whether your connections remain idle for a long time and rely on the default idle time-out to release its port. If the connections exhibit this behavior, you might have to reduce the default time-out of 30 minutes.

- Determine how your application creates outbound connectivity. For example, does it use code review or packet capture?

- Determine whether this activity represents the expected behavior or, instead, it shows that the application is misbehaving. Use metrics and logs in Azure Monitor to substantiate your findings. For example, you can use the **Failed** category as a SNAT Connections metric.

- Evaluate whether appropriate patterns are followed.

- Evaluate whether you should mitigate SNAT port exhaustion by using extra outbound IP addresses and more allocated outbound ports. For more information, see [Scale the number of managed outbound public IPs](/azure/aks/load-balancer-standard#scale-the-number-of-managed-outbound-public-ips) and [Configure the allocated outbound ports](/azure/aks/load-balancer-standard#configure-the-allocated-outbound-ports).

For more information about how to troubleshoot SNAT port exhaution, see [Troubleshoot SNAT port exhaustion on AKS nodes](../connectivity/snat-port-exhaustion.md?tabs=for-a-linux-pod).

### Step 4: Fix IOPS performance issues

If AKS diagnostics uncover issues that reduce IOPS performance, take some of the following actions, as appropriate:

- To increase IOPS on virtual machine (VM) scale sets, choose a a larger disk size that offers better IOPS performance by deploying a new node pool. Direct resizing VMSS directly isn't supported. For more information on resizing node pools,  see [Resize node pools in Azure Kubernetes Service (AKS)](/azure/aks/resize-node-pool?tabs=azure-cli).

- Increase the node SKU size for more memory and CPU processing capability.

- Consider using [Ephemeral OS](/azure/aks/cluster-configuration#ephemeral-os).

- Limit the CPU and memory usage for pods. These limits help prevent node CPU consumption and out-of-memory situations.

- Use scheduling topology methods to add more nodes and distribute the load among the nodes. For more information, see [Pod topology spread constraints](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/).

### Step 5: Fix threading issues

Kubernetes components such as kubelets and [containerd runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#containerd) rely heavily on threading, and they spawn new threads regularly. If the allocation of new threads is unsuccessful, this failure can affect service readiness, as follows:

- The node status changes to **Not Ready**, but it's restarted by a remediator, and is able to recover.

- In the */var/log/messages* and */var/log/syslog* log files, there are repeated occurrences of the following error entries:

  > pthread_create failed: Resource temporarily unavailable by various processes

  The processes that are cited include containerd and possibly kubelet.

- The node status changes to **Not Ready** soon after the `pthread_create` failure entries are written to the log files.

Process IDs (PIDs) represent threads. The default number of PIDs that a pod can use might be dependent on the operating system. However, the default number is at least 32,768. This amount is more than enough PIDs for most situations. Are there any known application requirements for higher PID resources? If there aren't, then even an eight-fold increase to 262,144 PIDs might not be enough to accommodate a high-resource application.

Instead, identify the offending application, and then take the appropriate action. Consider other options, such as increasing the VM size or upgrading AKS. These actions can mitigate the issue temporarily, but they aren't a guarantee that the issue won't reappear again.

To monitor the thread count for each control group (cgroup) and print the top eight cgroups, run the following shell command:

```bash
# Show current thread count for each cgroup (top 8)
ps -e -w -o "thcount,cgname" --no-headers | awk '{a[$2] += $1} END{for (i in a) print a[i], i}' | sort --numeric-sort --reverse | head --lines=8
```

For more information, see [Process ID limits and reservations](https://kubernetes.io/docs/concepts/policy/pid-limiting/).

Kubernetes offers two methods to manage PID exhaustion at the node level:

1. Configure the maximum number of PIDs that are allowed on a pod within a kubelet by using the `--pod-max-pids` parameter. This configuration sets the `pids.max` setting within the cgroup of each pod. You can also use the `--system-reserved` and `--kube-reserved` parameters to configure the system and kubelet limits, respectively.

1. Configure PID-based eviction.

> [!NOTE]
> By default, neither of these methods are set up. Additionally, you can't currently configure either method by using [Node configuration for AKS node pools](/azure/aks/custom-node-configuration).

### Step 6: Use a higher service tier

You can make sure that the AKS API server has high availability by using a higher service tier. For more information, see the [Azure Kubernetes Service (AKS) Uptime SLA](/azure/aks/uptime-sla).

## More information

- To view the health and performance of the AKS API server and kubelets, see [Managed AKS components](/azure/aks/monitor-aks#level-2---managed-aks-components).

- For general troubleshooting steps, see [Basic troubleshooting of node not ready failures](node-not-ready-basic-troubleshooting.md).