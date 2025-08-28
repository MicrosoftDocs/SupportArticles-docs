---
title: Troubleshoot API Server and ETCD Problems in AKS
description: Provides a troubleshooting guide for API server and etcd problems in Azure Kubernetes Services.
author: seguler
ms.author: segule
ms.date: 07/22/2025
ms.service: azure-kubernetes-service
ms.reviewer: kthakar1990, v-weizhu, axelg, josebl, aritraghosh, v-leedennis, v-liuamson
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot API server and etcd problems in AKS

This article helps you identify and resolve problems that you might encounter within the API server in large Microsoft Azure Kubernetes Services (AKS) deployments.

Microsoft has tested the reliability and performance of the API server at a scale of 5,000 nodes and 200,000 pods. The cluster that contains the API server can automatically scale out and deliver [Kubernetes Service Level Objectives (SLOs)](https://github.com/kubernetes/community/blob/master/sig-scalability/slos/slos.md). If you experience high latencies or timeouts, the cause is likely a resource leakage on the distributed `etc` directory (etcd), or an offending client that has excessive API calls.

## Prerequisites

- The [Azure CLI](/cli/azure/install-azure-cli).

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl by using Azure CLI, run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- AKS diagnostics logs (specifically, kube-audit events) that are enabled and sent to a [Log Analytics workspace](/azure/aks/monitor-apiserver). To determine whether logs are collected by using [resource-specific](/azure/azure-monitor/essentials/resource-logs#resource-specific) or [Azure diagnostics](/azure/azure-monitor/essentials/resource-logs#azure-diagnostics-mode) mode, check the **Diagnostic Settings** blade in the Azure portal.

- The Standard tier for AKS clusters. If you're using the Free tier, the API server and etcd contain limited resources. AKS clusters in the Free tier don't provide high availability. This condition is often the root cause of API server and etcd problems.

- The [kubectl-aks](https://go.microsoft.com/fwlink/p/?linkid=2259767#install) plugin for running commands directly on AKS nodes without using the Kubernetes control plane.

## Basic health checks

- Check resource health events

  AKS provides Resource health events for critical component downtime. Before you proceed, make sure that no critical events are reported in [Resource Health](/azure/service-health/resource-health-overview).

   :::image type="content" source="media/troubleshoot-apiserver-etcd/resource-health-event.png" alt-text="Screenshot that shows a resource health event." lightbox="media/troubleshoot-apiserver-etcd/resource-health-event.png":::

- Diagnose and solve problems

  AKS provides a dedicated troubleshooting category for **Cluster and Control Plane Availability and Performance**.

  :::image type="content" source="media/troubleshoot-apiserver-etcd/cluster-control-plane-availability-performance.png" alt-text="Screenshot that shows the 'Cluster and Control Plane Availability and Performance' category." lightbox="media/troubleshoot-apiserver-etcd/cluster-control-plane-availability-performance.png":::

## Symptoms

The following table outlines the common symptoms of API server failures.

| Symptom | Description |
|---|---|
| Timeouts from the API server | Frequent timeouts that are beyond the guarantees in [the AKS API server SLA](/azure/aks/free-standard-pricing-tiers#uptime-sla-terms-and-conditions). For example, `kubectl` commands timeout. |
| High latencies | High latencies that make the Kubernetes SLOs fail. For example, the `kubectl` command takes more than 30 seconds to list pods. |
| API server pod in `CrashLoopbackOff` status or facing webhook call failures | Verify that you don't have any custom admission webhook (such as the [Kyverno](https://kyverno.io/docs/introduction/) policy engine) that's blocking the calls to the API server. |

## Troubleshooting checklist

If you experience high latency times, follow these steps to pinpoint the offending client and the types of API calls that fail.

### <a id="identifytopuseragents"></a> Step 1: Identify top user agents by the number of requests

To identify which clients generate the most requests (and potentially the most API server load), run a query that resembles the following code. This query lists the top 10 user agents by the number of API server requests sent.

#### [Resource-specific](#tab/resource-specific)

```kusto
AKSAudit
| where TimeGenerated between(now(-1h)..now()) // When you experienced the problem
| summarize count() by UserAgent
| top 10 by count_
| project UserAgent, count_
```

#### [Azure diagnostics](#tab/azure-diagnostics)

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
> If your query returns no results, you might have selected the wrong table to query diagnostics logs. In resource-specific mode, data is written to individual tables, depending on the category of the resource. Diagnostics logs are written to the `AKSAudit` table. In Azure diagnostics mode, all data is written to the `AzureDiagnostics` table. For more information, see [Azure resource logs](/azure/azure-monitor/essentials/resource-logs).

Although it's helpful to know which clients generate the highest request volume, high request volume alone might not be a cause for concern. The response latency that clients experience is a better indicator of the actual load that each one generates on the API server.

### Step 2a: Identify and chart the average latency of API server requests per user agent

AKS now provides a built-in analyzer, the API Server Resource Intensive Listing Detector, to help you identify agents that make resource-intensive LIST calls. These calls are a leading cause of API server and etcd performance issues.

To access the detector, follow these steps:

1. Open your AKS cluster in the Azure portal.
2. Go to **Diagnose and solve problems**.
3. Select **Cluster and Control Plane Availability and Performance**.
4. Select **API server resource intensive listing detector**.

The detector analyzes recent API server activity and highlights agents or workloads that generate large or frequent LIST calls. It provides a summary of potential effects, such as request timeouts, increased numbers of "408" and "503" errors, node instability, health probe failures, and OOM-Kills in API server or etcd.

 :::image type="content" source="media/troubleshoot-apiserver-etcd/cluster-control-plane-availability-performance.png" alt-text="Screenshot that shows the Cluster and Control Plane Availability and Performance category." lightbox="media/troubleshoot-apiserver-etcd/resource-intensive-listing-analyzer-1.png":::

:::image type="content" source="media/troubleshoot-apiserver-etcd/cluster-control-plane-availability-performance.png" alt-text="Screenshot that shows the Cluster and Control Plane Availability and Performance category." lightbox="media/troubleshoot-apiserver-etcd/resource-intensive-listing-analyzer-2.png":::

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

The analyzer also provides recommendations directly in the Azure portal. These recommendations are tailored to the detected patterns to help you remediate and optimize your cluster.

> [!NOTE]
> The API server resource intensive listing detector is available to all users who have access to the AKS resource in the Azure portal. No special permissions or prerequisites are required.
> 
> After you identify the offending agents and apply the recommendations, you can use [the API Priority and Fairness feature](https://kubernetes.io/docs/concepts/cluster-administration/flow-control/) to throttle or isolate problematic clients. Alternatively, refer to the "Cause 3" section of [Troubleshoot API server and etcd problems in Azure Kubernetes Services](/troubleshoot/azure/azure-kubernetes/create-upgrade-delete/troubleshoot-apiserver-etcd?branch=pr-en-us-9260&tabs=resource-specific#cause-3-an-offending-client-makes-excessive-list-or-put-calls).

### Step 2.b: Identify the average latency

To identify the average latency of API server requests per user agent, as plotted on a time chart, run the following query.

#### [Resource-specific](#tab/resource-specific)

```kusto
AKSAudit
| where TimeGenerated between(now(-1h)..now()) // When you experienced the problem
| extend start_time = RequestReceivedTime
| extend end_time = StageReceivedTime
| extend latency = datetime_diff('millisecond', end_time, start_time)
| summarize avg(latency) by UserAgent, bin(start_time, 5m)
| render timechart
```

#### [Azure diagnostics](#tab/azure-diagnostics)

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

This query is a follow-up to the query in the ["Identify top user agents by the number of requests"](#identifytopuseragents) section. It might give you more insights into the actual load that each user agent generates over time.

> [!TIP]
> By analyzing this data, you can identify patterns and anomalies that can indicate problems on your AKS cluster or applications. For example, you might notice that a particular user is experiencing high latency. This scenario can indicate the type of API calls that are causing excessive load on the API server or etcd.

### Step 3: Identify bad API calls for a given user agent

Run the following query to tabulate the 99th percentile (P99) latency of API calls across different resource types for a given client.

#### [Resource-specific](#tab/resource-specific)

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

#### [Azure diagnostics](#tab/azure-diagnostics)

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

## Cause and Resolution

### Cause 1: A network rule blocks the traffic from agent nodes to the API server

A network rule can block traffic between the agent nodes and the API server.

To check whether a misconfigured network policy is blocking communication between the API server and agent nodes, run the following [kubectl-aks](https://go.microsoft.com/fwlink/p/?linkid=2259767) commands:

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

### Cause 2: An offending client leaks etcd objects and causes a slowdown of etcd

A common situation is that objects are continuously created even though existing unused objects in the etcd database aren't removed. This situation can cause performance problems if etcd handles too many objects (more than 10,000) of any type. A rapid increase of changes on such objects could also cause the default size of the etcd database (by default, 4 gigabytes) to be exceeded.

To check the etcd database usage, navigate to **Diagnose and Solve problems** in the Azure portal. Run the **Etcd Availability Issues** diagnosis tool by searching for "_etcd_" in the Search box. The diagnosis tool shows the usage breakdown and the total database size.

:::image type="content" source="media/troubleshoot-apiserver-etcd/etcd-detector.png" alt-text="Azure portal screenshot that shows the Etcd Availability Diagnosis for Azure Kubernetes Service (AKS)." lightbox="media/troubleshoot-apiserver-etcd/etcd-detector.png":::

To get a quick view of the current size of your etcd database in bytes, run the following command:

```bash
kubectl get --raw /metrics | grep -E "etcd_db_total_size_in_bytes|apiserver_storage_size_bytes|apiserver_storage_db_total_size_in_bytes"
```

> [!NOTE]
> The metric name in the previous command is different for different Kubernetes versions. For Kubernetes 1.25 and earlier versions, use `etcd_db_total_size_in_bytes`. For Kubernetes 1.26 to 1.28, use `apiserver_storage_db_total_size_in_bytes`.

### Solution 2: Define quotas for object creation, delete objects, or limit object lifetime in etcd

To prevent etcd from reaching capacity and causing cluster downtime, you can limit the maximum number of resources that are created. You can also slow the number of revisions that are generated for resource instances. To limit the number of objects that can be created, [define object quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/#object-count-quota).

If you identified objects that are no longer in use but consume resources, consider deleting them. For example, delete completed jobs to free up space:

```bash
kubectl delete jobs --field-selector status.successful=1
```

For objects that support [automatic cleanup](https://kubernetes.io/docs/concepts/architecture/garbage-collection/), set Time to Live (TTL) values to limit the lifetime of these objects. You can also label your objects so that you can bulk delete all the objects of a specific type by using label selectors. If you establish [owner references](https://kubernetes.io/docs/concepts/overview/working-with-objects/owners-dependents/) among objects, any dependent objects are automatically deleted after the parent object is deleted.

### Cause 3: An offending client makes excessive LIST or PUT calls

If you determine that etcd isn't overloaded with too many objects, an offending client might be making too many `LIST` or `PUT` calls to the API server.

### Solution 3a: Tune your API call pattern

To reduce the pressure on the control plane, consider tuning your client's API call pattern.

### Solution 3b: Throttle a client that's overwhelming the control plane

If you can't tune the client, use the [Priority and Fairness](https://kubernetes.io/docs/concepts/cluster-administration/flow-control/) feature in Kubernetes to throttle the client. This feature can help preserve the health of the control plane and prevent other applications from failing.

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

3. Observe the throttled call in the API server metrics:

    ```bash
    kubectl get --raw /metrics | grep "restrict-bad-client"
    ```

### Cause 4: A custom webhook causes a deadlock in API server pods

A custom webhook, such as Kyverno, might cause a deadlock within API server pods.

Check the events that are related to your API server. You might see event messages that resemble the following text:

> Internal error occurred: failed calling webhook "mutate.kyverno.svc-fail": failed to call webhook: Post "https\://kyverno-system-kyverno-system-svc.kyverno-system.svc:443/mutate/fail?timeout=10s": write unix @->/tunnel-uds/proxysocket: write: broken pipe

In this example, the validating webhook is blocking the creation of some API server objects. Because this scenario might occur during bootstrap time, the API server and Konnectivity pods can't be created. Therefore, the webhook can't connect to those pods. This sequence of events causes the deadlock and the error message.

### Solution 4: Delete webhook configurations

To fix this problem, delete the validating and mutating webhook configurations. To delete these webhook configurations in Kyverno, review the [Kyverno troubleshooting article](https://kyverno.io/docs/troubleshooting/).

### Cause 5: High etcd memory usage (per an alert)

You might receive an alert that states that etcd memory usage exceeds 20 GiB. This alert indicates that your cluster is experiencing an intensive API server load. The load can cascade and overwhelm etcd memory capacity. If the excessive load isn't resolved promptly, it can cause performance degradation or outages.

To check the current etcd memory usage and understand the specific factors that contribute to the high memory consumption, navigate to **Diagnose and Solve Problems** in the Azure portal. Run the **Etcd Performance Analyzer** by searching for "_etcd performance_" in the Search box. The analyzer shows you the memory usage breakdown and helps identify whether the cause of the problem is high request rates, large object counts, or large object sizes.

:::image type="content" source="media/troubleshoot-apiserver-etcd/etcd-performance-analyzer.png" alt-text="Azure portal screenshot of AKS Diagnose and solve problems showing the Etcd Performance Analyzer with memory usage breakdown and top contributors." lightbox="media/troubleshoot-apiserver-etcd/etcd-performance-analyzer.png":::

The root cause of high etcd memory usage is typically intensive API server load. This problem overlaps the other causes that this article discusses. To identify the specific problem that's affecting your cluster, use the following solution.

### Solution 5: Use existing diagnostic tools to identify and resolve the underlying cause

**Step 1: Determine the primary contributing factor**

The etcd memory alert can be triggered by any combination of three factors. Use these diagnostic tools to identify which factor is most problematic in your situation:

- **For high request rates**: Use the **API Server Resource Intensive Listing Analyzer** from [Step 2](#step-2-identify-and-chart-the-average-latency-of-api-server-requests-per-user-agent) to identify agents that make excessive LIST calls.
- **For object count and size issues**: Use the **Etcd Performance Analyzer** and **Etcd Capacity Analyzer** in the Azure portal.

#### How to use the Etcd Performance Analyzer

Use this analyzer to quickly assess whether the driving force behind the etcd memory alert is large objects, excessive object counts, or high request rates:

1. Open your AKS cluster in the Azure portal.
2. Go to **Diagnose and solve problems**.
3. In the Search box, enter "etcd performance" and then open the **Etcd Performance Analyzer**.

What you get:
- A breakdown of current etcd memory usage.
- Indicators of heavy payloads (for example, large objects or high request rates).

Next steps based on results:
- If high request rates are indicated, run the **API Server Resource Intensive Listing Analyzer** (see Step 2 earlier in this article) to identify offending agents and LIST patterns.
- If large objects or many objects are indicated, run the **Etcd Capacity Analyzer**, and follow [Cause 2](#cause-2-an-offending-client-leaks-etcd-objects-and-results-in-a-slowdown-of-etcd).

**Step 2: Apply the appropriate solution based on your findings**

After you identify the primary cause, apply the relevant solution from this troubleshooting guide:

- **If excessive LIST or PUT calls are identified**: Follow the [Cause 3](#cause-3-an-offending-client-makes-excessive-list-or-put-calls) solution to tune API call patterns or throttle problematic clients.
- **If too many objects are stored in etcd**: Follow the [Cause 2](#cause-2-an-offending-client-leaks-etcd-objects-and-results-in-a-slowdown-of-etcd) solution to clean up objects and implement retention policies.
- **If large objects are consuming excessive memory**: Focus on the following object size reduction techniques.

**Additional mitigation for large object sizes:**
- To reduce pod specification sizes, move environment variables from pod specifications to ConfigMaps.
- Split large secrets or ConfigMaps into smaller, more manageable pieces.
- Review and optimize resource specifications in your applications.

```bash
# Example: Clean up completed jobs that may have large specifications
kubectl delete jobs --field-selector status.successful=1

# Example: Clean up failed pods that may be consuming memory
kubectl delete pods --field-selector status.phase=Failed
```

> [!TIP]
> The etcd memory alert often indicates a combination of factors. Start at the **API Server Resource Intensive Listing Analyzer** to identify immediate request rate issues. Then, use the **Etcd Performance Analyzer** and **Etcd Capacity Analyzer** to understand object-related contributions to memory usage.

> [!IMPORTANT]
> The API server can become unresponsive because of severe etcd memory pressure. This condition might prevent you from performing the diagnostic steps that are provided in this article. In this situation, contact Azure support immediately to request assistance to clean up problematic objects or throttle excessive requests.

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
