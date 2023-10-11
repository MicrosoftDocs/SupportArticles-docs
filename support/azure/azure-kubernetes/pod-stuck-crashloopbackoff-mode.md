---
title: Pod is stuck in CrashLoopBackOff mode
description: Troubleshoot a scenario in which a pod is stuck in CrashLoopBackOff mode on an Azure Kubernetes Service (AKS) cluster.
ms.date: 09/07/2023
author: VikasPullagura-MSFT
ms.author: vipullag
editor: v-jsitser
ms.reviewer: chiragpa, nickoman, cssakscic, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# Pod is stuck in CrashLoopBackOff mode

If a pod has a `CrashLoopBackOff` status, then the pod probably failed or exited unexpectedly, and the log contains an exit code that isn't zero. There are several possible reasons why your pod is stuck in `CrashLoopBackOff` mode. Consider the following options and their associated [kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands) commands.

| Option | kubectl command |
|--|--|
| [Debug the pod](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/#debugging-pods) itself | `kubectl describe pod <pod-name>` |
| [Debug the replication controllers](https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/#debugging-replication-controllers) | `kubectl describe replicationcontroller <controller-name>` |
| [Read the termination message](https://kubernetes.io/docs/tasks/debug/debug-application/determine-reason-pod-failure/#writing-and-reading-a-termination-message) | `kubectl get pod <pod-name> --output=yaml` |
| [Examine the logs](https://kubernetes.io/docs/concepts/cluster-administration/logging/) | `kubectl logs <pod-name>` |

> [!NOTE]  
> A pod can also have a `CrashLoopBackOff` status if it has finished deployment, but it's configured to keep restarting even if the exit code is zero. For example, if you deploy a busybox image without specifying any arguments, the image starts, runs, finishes, and then restarts in a loop:
>
> ```console
> $ kubectl run nginx --image nginx
> pod/nginx created
> 
> $ kubectl run busybox --image busybox
> pod/busybox created
> 
> $ kubectl get pods --watch
> NAME     READY  STATUS             RESTARTS  AGE
> busybox  0/1    ContainerCreating  0         3s
> nginx    1/1    Running            0         11s
> busybox  0/1    Completed          0         3s
> busybox  0/1    Completed          1         4s
> busybox  0/1    CrashLoopBackOff   1         5s
> 
> $ kubectl describe pod busybox
> Name:         busybox
> Namespace:    default
> Priority:     0
> Node:         aks-nodepool<number>-<resource-group-hash-number>-vmss<number>/<ip-address-1>
> Start Time:   Wed, 16 Aug 2023 09:56:19 +0000
> Labels:       run=busybox
> Annotations:  <none>
> Status:       Running
> IP:           <ip-address-2>
> IPs:
>   IP:  <ip-address-2>
> Containers:
>   busybox:
>     Container ID:   containerd://<64-digit-hexadecimal-value-1>
>     Image:          busybox
>     Image ID:       docker.io/library/busybox@sha256:<64-digit-hexadecimal-value-2>
>     Port:           <none>
>     Host Port:      <none>
>     State:          Waiting
>       Reason:       CrashLoopBackOff
>     Last State:     Terminated
>       Reason:       Completed
>       Exit Code:    0
>       Started:      Wed, 16 Aug 2023 09:56:37 +0000
>       Finished:     Wed, 16 Aug 2023 09:56:37 +0000
>     Ready:          False
>     Restart Count:  2
> ```

If you don't recognize the issue after you create more pods on the node, then run a pod on a single node to determine how many resources the pod actually uses.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
