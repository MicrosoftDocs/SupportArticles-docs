---
title: Troubleshoot API server and etcd problems in AKS
description: Provides a troubleshooting guide for API server and etcd problems in Azure Kubernetes Services.
author: seguler
ms.author: segule
ms.date: 11/15/2024
ms.service: azure-kubernetes-service
ms.reviewer: mikerooney, v-weizhu, axelg, josebl, aritraghosh, v-leedennis
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot API server and etcd problems in Azure Kubernetes Services

This guide is designed to help you identify and resolve any unlikely problems that you might encounter within the API server in large Microsoft Azure Kubernetes Services (AKS) deployments.

Microsoft has tested the reliability and performance of the API server at a scale of 5,000 nodes and 200,000 pods. The cluster that contains the API server has the ability to automatically scale out and deliver [Kubernetes Service Level Objectives (SLOs)](https://github.com/kubernetes/community/blob/master/sig-scalability/slos/slos.md). If you experience high latencies or time-outs, it's probably because there's a resource leakage on the distributed `etc` directory (etcd), or an offending client has excessive API calls.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli).

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl by using Azure CLI, run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- AKS diagnostics logs (specifically, kube-audit events) that are enabled and sent to a [Log Analytics workspace](/azure/aks/monitor-apiserver). To determine if logs are collected using [resource-specific](/azure/azure-monitor/essentials/resource-logs#resource-specific) or [Azure diagnostics](/azure/azure-monitor/essentials/resource-logs#azure-diagnostics-mode) mode, check the **Diagnostic Settings** blade in the Azure portal.

- The Standard tier for AKS clusters. If you're using the Free tier, the API server and etcd contain limited resources. AKS clusters in the Free tier don't provide high availability. This is often the root cause of API server and etcd problems.

- The [kubectl-aks](https://go.microsoft.com/fwlink/p/?linkid=2259767#install) plugin for running commands directly on AKS nodes without using the Kubernetes control plane.

## Basic health checks

- Resource health events

  AKS provides Resource health events for critical component downtime. Before proceeding, ensure there are no critical events reported in [Resource Health](/azure/service-health/resource-health-overview).

   :::image type="content" source="media/troubleshoot-apiserver-etcd/resource-health-event.png" alt-text="Screenshot that shows a resource health event." lightbox="media/troubleshoot-apiserver-etcd/resource-health-event.png":::

- Diagnose and solve problems

  AKS provides a dedicated troubleshooting category for **Cluster and Control Plane Availability and Performance**.

  :::image type="content" source="media/troubleshoot-apiserver-etcd/cluster-control-plane-availability-performance.png" alt-text="Screenshot that shows the 'Cluster and Control Plane Availability and Performance' category." lightbox="media/troubleshoot-apiserver-etcd/cluster-control-plane-availability-performance.png":::

## Symptoms

The following table outlines the common symptoms of API server failures:

| Symptom | Description |
|---|---|
| Time-outs from the API server | Frequent time-outs that are beyond the guarantees in [the AKS API server SLA](/azure/aks/free-standard-pricing-tiers#uptime-sla-terms-and-conditions). For example, `kubectl` commands time-out. |
| High latencies | High latencies that make the Kubernetes SLOs fail. For example, the `kubectl` command takes more than 30 seconds to list pods. |
| API server pod in `CrashLoopbackOff` status or facing webhook call failures | Verify that you don't have any custom admission webhook (such as the [Kyverno](https://kyverno.io/docs/introduction/) policy engine) that's blocking the calls to the API server. |

## Troubleshooting checklist

If you are experiencing high latency times, follow these steps to pinpoint the offending client and the types of API calls that fail.

### <a id="identifytopuseragents"></a> Step 1: Identify top user agents by the number of requests

To identify which clients generate the most requests (and potentially the most API server load), run a query that resembles the following code. The following query lists the top 10 user agents by the number of API server requests sent.

### [Resource-specific](#tab/resource-specific)

```kusto
AKSAudit
| where TimeGenerated between(now(-1h)..now()) // When you experienced the problem
| summarize count() by UserAgent
| top 10 by count_
| project UserAgent, count_
```

### [Azure diagnostics](#tab/azure-diagnostics)

```kusto
AzureDiagnostics
| where TimeGenerated between(now(-1h)..now())  // When you experienced the problem
| where Category == "kube-audit" 
| extend event = parse_json(log_s) 
| extend User = tostring(event.user.username) 
| summarize count() by User 
| top 10 by count_ 
| project User, count_ 
```
---

> [!NOTE]
> If your query returns no results, you may have selected the wrong table to query diagnostics logs. In resource-specific mode, data is written to individual tables depending on the category of the resource. Diagnostics logs are written to the `AKSAudit` table. In Azure diagnostics mode, all data is written to the `AzureDiagnostics` table. For more information, see [Azure resource logs](/azure/azure-monitor/essentials/resource-logs).

Although it's helpful to know which clients generate the highest request volume, high request volume alone might not be a cause for concern. A better indicator of the actual load that each client generates on the API server is the response latency that they experience.

### Step 2: Identify and chart the average latency of API server requests per user agent

To identify the average latency of API server requests per user agent as plotted on a time chart, run the following query:

### [Resource-specific](#tab/resource-specific)

```kusto
AKSAudit
| where TimeGenerated between(now(-1h)..now()) // When you experienced the problem
| extend start_time = RequestReceivedTime
| extend end_time = StageReceivedTime
| extend latency = datetime_diff('millisecond', end_time, start_time)
| summarize avg(latency) by UserAgent, bin(start_time, 5m)
| render timechart
```

### [Azure diagnostics](#tab/azure-diagnostics)

```kusto
AzureDiagnostics
| where TimeGenerated between(now(-1h)..now())  // When you experienced the problem
| where Category == "kube-audit" 
| extend event = parse_json(log_s) 
| extend User = tostring(event.user.username)
| extend start_time = todatetime(event.requestReceivedTimestamp)
| extend end_time = todatetime(event.stageTimestamp)
| extend latency = datetime_diff('millisecond', end_time, start_time)
| summarize avg(latency) by User, bin(start_time, 5m) 
| render timechart 
```
---

This query is a follow-up to the query in the ["Identify top user agents by the number of requests"](#identifytopuseragents) section. It might give you more insights into the actual load that's generated by each user agent over time.

> [!TIP]
> By analyzing this data, you can identify patterns and anomalies that can indicate problems on your AKS cluster or applications. For example, you might notice that a particular user is experiencing high latency. This scenario can indicate the type of API calls that are causing excessive load on the API server or etcd.

### Step 3: Identify bad API calls for a given user agent

Run the following query to tabulate the 99th percentile (P99) latency of API calls across different resource types for a given client:

### [Resource-specific](#tab/resource-specific)

```kusto
AKSAudit
| where TimeGenerated between(now(-1h)..now()) // When you experienced the problem
| extend HttpMethod = Verb
| extend Resource = tostring(ObjectRef.resource)
| where UserAgent == "DUMMYUSERAGENT" // Filter by name of the useragent you are interested in
| where Resource != ""
| extend start_time = RequestReceivedTime
| extend end_time = StageReceivedTime
| extend latency = datetime_diff('millisecond', end_time, start_time)
| summarize p99latency=percentile(latency, 99) by HttpMethod, Resource
| render table
```

### [Azure diagnostics](#tab/azure-diagnostics)

```kusto
AzureDiagnostics
| where TimeGenerated between(now(-1h)..now())  // When you experienced the problem
| where Category == "kube-audit" 
| extend event = parse_json(log_s) 
| extend HttpMethod = tostring(event.verb) 
| extend Resource = tostring(event.objectRef.resource) 
| extend User = tostring(event.user.username) 
| where User == "DUMMYUSERAGENT"  // Filter by name of the useragent you are interested in
| where Resource != ""
| extend start_time = todatetime(event.requestReceivedTimestamp)
| extend end_time = todatetime(event.stageTimestamp)
| extend latency = datetime_diff('millisecond', end_time, start_time)
| summarize p99latency=percentile(latency, 99) by HttpMethod, Resource 
| render table  
```
---

The results from this query can be useful to identify the kinds of API calls that fail the upstream Kubernetes SLOs. In most cases, an offending client might be making too many `LIST` calls on a large set of objects or objects that are too large. Unfortunately, no hard scalability limits are available to guide users about API server scalability. API server or etcd scalability limits depend on various factors that are explained in [Kubernetes Scalability thresholds](https://github.com/kubernetes/community/blob/master/sig-scalability/configs-and-limits/thresholds.md).

## Cause 1: A network rule blocks the traffic from agent nodes to the API server

A network rule can block traffic between the agent nodes and the API server.

To verify whether a misconfigured network policy is blocking communication between the API server and agent nodes, run the following [kubectl-aks](https://go.microsoft.com/fwlink/p/?linkid=2259767) commands:

```bash
kubectl aks config import \
    --subscription <mySubscriptionID> \
    --resource-group <myResourceGroup> \
    --cluster-name <myAKSCluster>

kubectl aks check-apiserver-connectivity --node <myNode>
```

The [config import](https://go.microsoft.com/fwlink/p/?linkid=2259867#importing-configuration) command retrieves the Virtual Machine Scale Set information for all the nodes in the cluster. Then, the [check-apiserver-connectivity](https://go.microsoft.com/fwlink/p/?linkid=2259674) command uses this information to verify the network connectivity between the API server and a specified node, specifically for its underlying scale set instance.

> [!NOTE]
> If the output of the `check-apiserver-connectivity` command contains the `Connectivity check: succeeded` message, then the network connectivity is unimpeded.

### Solution 1: Fix the network policy to remove the traffic blockage

If the command output indicates that a connection failure occurred, reconfigure the network policy so that it doesn't unnecessarily block traffic between the agent nodes and the API server.

## Cause 2: An offending client leaks etcd objects and results in a slowdown of etcd

A common problem is continuously creating objects without deleting unused ones in the etcd database. This can cause performance problems when etcd deals with too many objects (more than 10,000) of any type. A rapid increase of changes on such objects could also cause the etcd database size (4 gigabytes by default) to be exceeded.

To check the etcd database usage, navigate to **Diagnose and Solve problems** in the Azure portal. Run the **Etcd Availability Issues** diagnosis tool by searching for "_etcd_" in the search box. The diagnosis tool shows you the usage breakdown and the total database size.

:::image type="content" source="media/troubleshoot-apiserver-etcd/etcd-detector.png" alt-text="Azure portal screenshot that shows the Etcd Availability Diagnosis for Azure Kubernetes Service (AKS)." lightbox="media/troubleshoot-apiserver-etcd/etcd-detector.png":::

If you just want a quick way to view the current size of your etcd database in bytes, run the following command:

```bash
kubectl get --raw /metrics | grep -E "etcd_db_total_size_in_bytes|apiserver_storage_size_bytes|apiserver_storage_db_total_size_in_bytes"
```

> [!NOTE]
> The metric name in the previous command is different for different Kubernetes versions. For Kubernetes 1.25 and earlier, use `etcd_db_total_size_in_bytes`. For Kubernetes 1.26 to 1.28, use `apiserver_storage_db_total_size_in_bytes`.

### Solution 2: Define quotas for object creation, delete objects, or limit object lifetime in etcd

To prevent etcd from reaching capacity and causing cluster downtime, you can limit the maximum number of resources that are created. You can also slow the number of revisions that are generated for resource instances. To limit the number of objects that can be created, you can [define object quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/#object-count-quota).

If you have identified objects that are no longer in use but are taking up resources, consider deleting them. For example, you can delete completed jobs to free up space:

```bash
kubectl delete jobs --field-selector status.successful=1
```

For objects that support [automatic cleanup](https://kubernetes.io/docs/concepts/architecture/garbage-collection/), you can set Time to Live (TTL) values to limit the lifetime of these objects. You can also label your objects so that you can bulk delete all the objects of a specific type by using label selectors. If you establish [owner references](https://kubernetes.io/docs/concepts/overview/working-with-objects/owners-dependents/) among objects, any dependent objects are automatically deleted after the parent object is deleted.

## Cause 3: An offending client makes excessive LIST or PUT calls

If you determine that etcd isn't overloaded with too many objects, an offending client might be making too many `LIST` or `PUT` calls to the API server.

### Solution 3a: Tune your API call pattern

Consider tuning your client's API call pattern to reduce the pressure on the control plane.

### Solution 3b: Throttle a client that's overwhelming the control plane

If you can't tune the client, you can use the [Priority and Fairness](https://kubernetes.io/docs/concepts/cluster-administration/flow-control/) feature in Kubernetes to throttle the client. This feature can help preserve the health of the control plane and prevent other applications from failing.

The following procedure shows you how to throttle an offending client's LIST Pods API set to five concurrent calls:

1. Create a [FlowSchema](https://kubernetes.io/docs/concepts/cluster-administration/flow-control/#flowschema) that matches the API call pattern of the offending client:

    ```yaml
    apiVersion: flowcontrol.apiserver.k8s.io/v1beta2
    kind: FlowSchema
    metadata:
      name: restrict-bad-client
    spec:
      priorityLevelConfiguration:
        name: very-low-priority
      distinguisherMethod:
        type: ByUser
      rules:
      - resourceRules:
        - apiGroups: [""]
          namespaces: ["default"]
          resources: ["pods"]
          verbs: ["list"]
        subjects:
        - kind: ServiceAccount
          serviceAccount:
            name: bad-client-account
            namespace: default 
    ```

2. Create a lower priority configuration to throttle bad API calls of the client:

    ```yaml
    apiVersion: flowcontrol.apiserver.k8s.io/v1beta2
    kind: PriorityLevelConfiguration
    metadata:
      name: very-low-priority
    spec:
      limited:
        assuredConcurrencyShares: 5
        limitResponse:
          type: Reject
      type: Limited
    ```

3. Observe the throttled call in the API server metrics.

    ```bash
    kubectl get --raw /metrics | grep "restrict-bad-client"
    ```

### Solution 3c: Use the API Server Resource Intensive Listing Detector in Azure Portal

> **New:** Azure Kubernetes Service now provides a built-in analyzer to help you identify agents making resource-intensive LIST calls, which are a leading cause of API server and etcd performance issues.

**How to access the detector:**

1. Open your AKS cluster in the Azure portal.
2. Go to **Diagnose and solve problems**.
3. Click **Cluster and Control Plane Availability and Performance**.
4. Select **API server resource intensive listing detector**.

This detector analyzes recent API server activity and highlights agents or workloads generating large or frequent LIST calls. It provides a summary of potential impacts, such as request timeouts, increased 408/503 errors, node instability, health probe failures, and OOM-Kills in API server or etcd.

#### How to interpret the detector output

- **Summary:**  
  Indicates if resource-intensive LIST calls were detected and describes possible impacts on your cluster.
- **Analysis window:**  
  Shows the 30-minute window analyzed, with peak memory and CPU usage.
- **Read types:**  
  Explains whether LIST calls were served from the API server cache (preferred) or required fetching from etcd (most impactful).
- **Charts and tables:**  
  Identify which agents, namespaces, or workloads are generating the most resource-intensive LIST calls.

> Only successful LIST calls are counted. Failed or throttled calls are excluded.

The analyzer also provides actionable recommendations directly in the Azure portal, tailored to the detected patterns, to help you remediate and optimize your cluster.

> **Note:**
> The API server resource intensive listing detector is available to all users with access to the AKS resource in the Azure portal. No special permissions or prerequisites are required.
> 
> After identifying the offending agents and applying the above recommendations, you can further use [Priority and Fairness](https://kubernetes.io/docs/concepts/cluster-administration/flow-control/) to throttle or isolate problematic clients.

## Cause 4: A custom webhook might cause a deadlock in API server pods

A custom webhook, such as Kyverno, might be causing a deadlock within API server pods.

Check the events that are related to your API server. You might see event messages that resemble the following text:

> Internal error occurred: failed calling webhook "mutate.kyverno.svc-fail": failed to call webhook: Post "https\://kyverno-system-kyverno-system-svc.kyverno-system.svc:443/mutate/fail?timeout=10s": write unix @->/tunnel-uds/proxysocket: write: broken pipe

In this example, the validating webhook is blocking the creation of some API server objects. Because this scenario might occur during bootstrap time, the API server and Konnectivity pods can't be created. Therefore, the webhook can't connect to those pods. This sequence of events causes the deadlock and the error message.

### Solution 4: Delete webhook configurations

To fix this problem, delete the validating and mutating webhook configurations. To delete these webhook configurations in Kyverno, review the [Kyverno troubleshooting article](https://kyverno.io/docs/troubleshooting/).

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
