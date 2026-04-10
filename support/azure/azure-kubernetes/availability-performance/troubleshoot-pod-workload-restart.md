---
title: Troubleshoot pod workload restarts in AKS    
description: Learn how to troubleshoot and resolve pod workload restarts in Azure Kubernetes Service (AKS) by reviewing and adjusting container health probe configurations.
ms.date: 2/25/2024
ms.reviewer: chiragpa, yangzhe
ms.editor: v-jsitser
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to prevent the Node Not Ready status for faulty nodes that later recover so that I can avoid future errors within an AKS cluster.
ms.custom: sap:Node/node pool availability and performance
---

# Troubleshoot pod workload restarts in AKS

## Summary

This article provides guidance to troubleshoot and resolve pod workload restarts in Azure Kubernetes Service (AKS). It covers common symptoms, causes, and recommended resolutions that are related to container health probe configurations.

## Symptoms

Pod workloads in an AKS cluster restart repeatedly. You might observe one or more of the following symptoms:

- `kubectl get pods` shows pods in a `CrashLoopBackOff` or `Error` state.
- The pod `RESTARTS` count continues to increase over time.
- Events from `kubectl describe pod <pod-name>` show `liveness/readiness` probe failures.
- Application log entries indicate abrupt termination or initialization failures.
 
The following is an example output:

```bash
kubectl get pods 

NAME           READY      STATUS                RESTARTS      AGE 

Example-pod    0/1        CrashLoopBackOff      12            30m 
```

## Causes

Repetitive pod restarts in AKS commonly occur because of one or more of the following reasons:

- Liveness or startup probes are misconfigured so that the probe timeout, failure threshold, or initial delay doesn't account for normal application startup or response time.
- Startup probes are missing for slow‑initializing applications. This condition causes the liveness probe to run before the application is ready to accept requests.
- Probe endpoints depend on external resources, such as databases, storage mounts, and downstream services. These sources might be temporarily unavailable even though the application process is still healthy.
- CPU throttling or resource contention causes probe requests to time out. This behavior causes probe failures and subsequent container restarts.
- Health check logic is overly strict. Therefore, liveness probes perform full application or dependency validation instead of basic process health checks.
 
## Solution

To resolve this problem, review the container health probe configuration to make sure that it aligns with the application's startup and runtime characteristics. Verify the following points:

- Configure startup probes for applications that require extra initialization time. Verify that the `failureThreshold` and `periodSeconds` values provide enough time for the application to start successfully. For more information, see [Pod Lifecycle | Kubernetes](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#when-should-you-use-a-startup-probe).
- Adjust liveness probe thresholds, such as `timeoutSeconds` and `failureThreshold`, to prevent unnecessary container restarts during transient latency or periods of increased load. For more information, see [Configure Liveness, Readiness and Startup Probes | Kubernetes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).
- Keep liveness probes lightweight by validating only that the application process is running and responsive, instead of performing full dependency checks. For more information, see [Liveness, Readiness, and Startup Probes | Kubernetes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).
- Move dependency validation and traffic‑gating logic to the readiness probe instead of using liveness probes to determine overall application health. For more information, see [Configure Liveness, Readiness and Startup Probes | Kubernetes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).
- Check whether container CPU and memory limits are appropriately sized so the application can respond to health probes under normal operating conditions. For more information, see [Pod Lifecycle | Kubernetes](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#when-should-you-use-a-startup-probe).
