---
title: Troubleshoot errors when deploying extensions in an AKS cluster
description: Learn how to troubleshoot errors that occur when you deploy cluster extensions in an Azure Kubernetes Service (AKS) cluster.
ms.date: 02/28/2024
author: maanasagovi
ms.author: maanasagovi
editor: v-jsitser
ms.reviewer: nickoman, v-weizhu, v-leedennis
ms.service: azure-kubernetes-service
---
# Troubleshoot errors when deploying AKS cluster extensions

This article discusses how to troubleshoot errors that occur when you deploy cluster extensions for Microsoft Azure Kubernetes Service (AKS).

## Extension creation errors

### Error: Unable to get a response from the agent in time

This error occurs if Azure services don't receive a response from the cluster extension agent. This situation might occur because the AKS cluster can't establish a connection with Azure.

#### Cause 1: The cluster extension agent and manager pods aren't initialized

The cluster extension agent and manager are crucial system components that are responsible for managing the lifecycle of Kubernetes applications. The initialization of the cluster extension agent and manager pods might fail because of the following problems:

- Resource limitations 
- Policy restrictions
- Node taints, such as `NoSchedule`

##### Solution 1: Make sure that the cluster extension agent and manager pods work correctly

To resolve this issue, make sure that the cluster extension agent and manager pods are correctly scheduled and can start. If the pods are stuck in a non-ready state, check the pod description by running the `kubectl describe pod` command to get more details about the underlying problems (for example, taints that are preventing scheduling, insufficient memory, or policy restrictions).

When the cluster extension agent and manager pods are operational and healthy, they establish communication with Azure services to install and manage Kubernetes applications.

Run the following command to check the pod description: 


```console
kubectl describe pod -n kube-system extension-operator-{id}
```

For arc connected clusters run the following command:


```console
kubectl describe pod -n azure-arc extension-manager-{id}
```

#### Cause 2: An issue affects the egress block or firewall

If the cluster extension agent and manager pods are healthy, and you still encounter the "Unable to get a response from the agent in time" error, an egress block or firewall issue probably exists. This issue might block the cluster extension agent and manager pods from communicating with Azure.

##### Solution 2: Make sure that networking prerequisites are met

To resolve this problem, make sure that you follow the networking prerequisites that are outlined in [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress).

#### Cause 3: The traffic is not authorized 

The extension agent unsuccessfully tries calling to `<region>.dp.kubernetesconfiguration.azure.com` data plane service endpoints. This failure generates an "Errorcode: 403, Message This traffic is not authorized" entry in the extension-agent pod logs.

```console
kubectl logs -n kube-system extension-agent-<pod-guid>
{  "Message": "2024/02/07 06:04:43 \"Errorcode: 403, Message This traffic is not authorized., Target /subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/provider/managedclusters/clusters/<cluster-name>/configurations/getPendingConfigs\"",  "LogType": "ConfigAgentTrace",  "LogLevel": "Information",  "Environment": "prod",  "Role": "ClusterConfigAgent",  "Location": "eastus2euap",  "ArmId": "/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.ContainerService/managedclusters/<cluster-name>",  "CorrelationId": "",  "AgentName": "ConfigAgent",  "AgentVersion": "1.14.5",  "AgentTimestamp": "2024/02/07 06:04:43.672"  }
{  "Message": "2024/02/07 06:04:43 Failed to GET configurations with err : {\u003cnil\u003e}",  "LogType": "ConfigAgentTrace",  "LogLevel": "Information",  "Environment": "prod",  "Role": "ClusterConfigAgent",  "Location": "eastus2euap",  "ArmId": "/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.ContainerService/managedclusters/<cluster-name>",  "CorrelationId": "",  "AgentName": "ConfigAgent",  "AgentVersion": "1.14.5",  "AgentTimestamp": "2024/02/07 06:04:43.672"  }
```

This error occurs if a preexisting PrivateLinkScope exists in an extension's data plane for Azure Arc-enabled Kubernetes, and the virtual network (or private DNS server) is shared between Azure Arc-enabled Kubernetes and the AKS-managed cluster. This networking configuration causes AKS outbound traffic from the extension data plane to also route through the same private IP address instead of through a public IP address.

Run the following [nslookup](/windows-server/administration/windows-commands/nslookup) command in your AKS cluster to retrieve the specific private IP address that the data plane endpoint is resolving to:

```console
PS D:\> kubectl exec -it -n kube-system extension-agent-<pod-guid> -- nslookup  <region>.dp.kubernetesconfiguration.azure.com
Non-authoritative answer:
<region>.dp.kubernetesconfiguration.azure.com        canonical name = <region>.privatelink.dp.kubernetesconfiguration.azure.com
Name:   <region>.privatelink.dp.kubernetesconfiguration.azure.com
Address: 10.224.1.184
```

When you search for the private IP address in the Azure portal, the search results point to the exact resource: virtual network, private DNS zone, private DNS server, and so on. This resource has a private endpoint that's configured for the extension data plane for Azure Arc-enabled Kubernetes.

##### Solution 3.1: (Recommended) Create separate virtual networks

To resolve this problem, we recommend that you create separate virtual networks for Azure Arc-enabled Kubernetes and AKS computes.

##### Solution 3.2: Create a CoreDNS override

If the recommended solution isn't possible in your situation, create a CoreDNS override for the extension data plane endpoint to go over the public network. For more information about how to customize CoreDNS, see the ["Hosts plugin"](/azure/aks/coredns-custom#hosts-plugin) section of "Customize CoreDNS with Azure Kubernetes Service."

To create a CoreDNS override, follow these steps:

1. Find the public IP address of the extension data plane endpoint by running the `nslookup` command. Make sure that you change the region (`eastus2euap`) based on the location of your AKS cluster:

   ```console
   nslookup eastus2euap.dp.kubernetesconfiguration.azure.com
   Non-authoritative answer:
   Name:    clusterconfigeastus2euap.eastus2euap.cloudapp.azure.com
   Address:  20.39.12.229
   Aliases:  eastus2euap.dp.kubernetesconfiguration.azure.com
            eastus2euap.privatelink.dp.kubernetesconfiguration.azure.com
            eastus2euap.dp.kubernetesconfiguration.trafficmanager.net
   ```

1. Create a backup of the existing coreDNS configuration:

   ```bash
   kubectl get configmap -n kube-system coredns-custom -o yaml > coredns.backup.yaml
   ```

1. Override the mapping for the regional (`eastus2euap`) data plane endpoint to the public IP address. To do this, create a YAML file that's named *corednsms.yaml*, and then copy the following example configuration into the new file. (Make sure that you update the address and the host name by using the values for your environment.)

   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: coredns-custom      # This is the name of the configuration map that you can overwrite with your changes.
     namespace: kube-system
   data:
     extensionsdp.override: |  # You can select any name here, but it must have the .override file name extension.
       hosts {
         20.39.12.229 eastus2euap.dp.kubernetesconfiguration.azure.com
         fallthrough
       }
   ```

1. To create the ConfigMap, run the `kubectl apply` command, specifying the name of your YAML manifest file:

   ```bash
   kubectl apply -f corednsms.yaml
   ```

1. To reload the ConfigMap and enable Kubernetes Scheduler to restart CoreDNS without downtime, run the [kubectl rollout restart](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-restart-em-) command:

   ```bash
   kubectl -n kube-system rollout restart deployment coredns
   ```

1. Run the `nslookup` command again to make sure that the data plane endpoint resolves to the provided public IP address:

   ```console
   kubectl exec -it -n kube-system extension-agent-55d4f4795f-nld9q -- nslookup  [region].dp.kubernetesconfiguration.azure.com
   Name:   eastus2euap.dp.kubernetesconfiguration.azure.com
   Address: 20.39.12.229
   ```

The extension agent pod logs should no longer log "Errorcode: 403, Message This traffic is not authorized" error entries. Instead, the logs should contain "200" response codes.

```console
kubectl logs -n kube-system extension-agent-{id} 
{  "Message": "GET configurations returned response code {200}",  "LogType": "ConfigAgentTrace",  "LogLevel": "Information",  "Environment": "prod",  "Role": "ClusterConfigAgent",  "Location": "eastus2euap",  "ArmId": "/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.ContainerService/managedclusters/<cluster-name>",  "CorrelationId": "",  "AgentName": "ConfigAgent",  "AgentVersion": "1.14.5"  }
```

### Error: Extension pods can't be scheduled if all the node pools in the cluster are "CriticalAddonsOnly" tainted

When this error occurs, the following entry is logged in the extension agent log:

> Extension Pod error: 0/2 nodes are available: 2 node(s) had untolerated taint {CriticalAddonsOnly: true}. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.

#### Cause

This error occurs when you try to enable extensions (such as the Distributed Application Runtime (DAPR)) on an AKS cluster that has `CriticalAddonsOnly` tainted node pools. In this situation, the extension pods aren't scheduled on any node because no toleration exists for these taints.

To view the error situation, examine the extension pods to verify that they're stuck in a pending state:

```console
kubectl get po -n {namespace-name} -l app.kubernetes.io/name={name}

NAME                                   READY   STATUS    RESTARTS   AGE
{podname}                              0/2     Pending   0          2d6h
```

Describe the pods to see that they can't be scheduled because of an unsupportable taint:

```console
kubectl describe po -n {namespace-name} {podname}

Events:
  Type     Reason            Age   From               Message
  ----     ------            ----  ----               -------
  Warning  FailedScheduling  18s   default-scheduler  0/2 nodes are available: 2 node(s) had untolerated taint {CriticalAddonsOnly: true}. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
```

> [!NOTE]
>
> - We recommend that you don't install extensions on `CriticalAddOnsOnly` tainted node pools unless doing this is required for application workloads.
>
> - We recommend that you don't use a `CriticalAddOnsOnly` taint on single node pool clusters. If you use that taint in a cluster that has just one node pool, you can't schedule application pods in the cluster. Make sure that at least one node pool in the cluster doesn't have this taint. For more information about when the `CriticalAddonsOnly` annotation should be used, see [Manage system node pools in Azure Kubernetes Service (AKS)](/azure/aks/use-system-pools).

##### Solution 1: Add a node pool to the cluster

To resolve this problem, add one more node pool that doesn't have a `CriticalAddonsOnly` taint. This action causes the extension pods to be scheduled on the new node pool.

##### Solution 2: Remove the "CriticalAddonsOnly" taint

If it's possible and practical, you can remove the `CriticalAddonsOnly` taint in order to install the extension on the cluster.

## Helm errors

You might encounter any of the following Helm-related errors:

- [Timed out waiting for resource readiness](#error-timed-out-waiting-for-resource-readiness)
- [Unable to download the Helm chart from the repo URL](#error-unable-to-download-the-helm-chart-from-the-repo-url)
- [Helm chart rendering failed with given values](#error-helm-chart-rendering-failed-with-given-values)
- [Resource already exists in your cluster](#error-resource-already-exists-in-your-cluster)
- [Operation is already in progress for Helm](#error-operation-is-already-in-progress-for-helm)

### Error: Timed out waiting for resource readiness

The installation of a Kubernetes application fails and displays the following error messages:

> job failed: BackoffLimitExceeded

> Timed out waiting for the resource to come to a ready/completed state.

#### Cause

This problem has the following common causes:

- Resource constraints: Inadequate memory or CPU resources within the cluster can prevent the successful initialization of pods, jobs, or other Kubernetes resources. Eventually, this situation causes the installation to time out. Policy constraints or node taints (such as `NoSchedule`) can also block resource initialization.

- Architecture mismatches: Trying to schedule a Linux-based application on a Windows-based node (or vice-versa) can cause failures in Kubernetes resource initialization.

- Incorrect configuration settings: Incorrect configuration settings can prevent pods from starting.

##### Solution

To resolve this problem, follow these steps:

1. Check resources: Make sure that your Kubernetes cluster has sufficient resources, and that pod scheduling is permitted on the nodes (you should consider taints). Verify that memory and CPU resources meet the requirements.

2. Inspect events: Check the events within the Kubernetes namespace to identify potential problems that might prevent pods, jobs, or other Kubernetes resources from reaching a ready state.

3. Check Helm charts and configurations: Many Kubernetes applications use Helm charts to deploy resources on the cluster. Some applications might require user input through configuration settings. Make sure that all provided configuration values are accurate and meet the installation requirements.

### Error: Unable to download the Helm chart from the repo URL

This error is caused by connectivity problems that occur between the cluster and the firewall in addition to egress blocking problems. To resolve this problem, see [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress).

### Error: Helm chart rendering failed with given values

This error occurs if Kubernetes applications rely on Helm charts to deploy resources within the Kubernetes cluster. These applications might require user input that's provided through configuration settings that are passed as Helm values during installation. If any of these crucial configuration settings are missing or incorrect, the Helm chart might not render.

To resolve this problem, check the extension or application documentation to determine whether you omitted any mandatory values or provided incorrect values during the application installation. These guidelines can help you to fix Helm chart rendering problems that are caused by missing or inaccurate configuration values.

### Error: Resource already exists in your cluster

This error occurs if a conflict exists between the Kubernetes resources within your cluster and the Kubernetes resources that the application is trying to install. The error message usually specifies the name of the conflicting resource.

If the conflicting resource is essential and can't be replaced, you might not be able to install the application. If the resource isn't critical and can be removed, delete the conflicting resource, and then try the installation again.

### Error: Operation is already in progress for Helm

This error occurs if there's an operation already in progress for a particular release. To resolve this problem, wait 10 minutes, and then retry the operation.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
