---
title: Retain privileged mode while adding capabilities
description: Learn how to retain privileged mode while adding capabilities in AKS with Azure Policy Add-on to meet policy requirements and secure node access. Start now.
ms.date: 06/10/2026
author: mosbahmajed
ms.author: momajed
editor: v-jsitser
ms.reviewer: cssakscic, v-rekhanain, v-leedennis
ms.service: azure-kubernetes-service
ms.topic: how-to
ms.custom: sap:Extensions, Policies and Add-Ons
#Customer intent: As an Azure Kubernetes user, I want to retain privileged mode while I add capabilities so that my workloads continue to function when the Azure Policy Add-on is enabled in Azure Kubernetes Service.
---

# Retain privileged mode while adding capabilities

## Summary

This article explains how to retain privileged mode while adding Linux capabilities in Azure Kubernetes Service (AKS) when the Azure Policy Add-on is enabled. When you run workloads that require both `privileged: true` and specific Linux capabilities (like `NET_ADMIN` or `SYS_PTRACE`), Azure Policy evaluates each setting independently. Both settings can trigger separate policy violations. Use this guidance to configure the policy assignment parameters or create a scoped exemption so that your container can meet security policy requirements while it retains the access it needs.

## Prerequisites

Before you begin, verify the following prerequisites:

- An AKS cluster that has the [Azure Policy Add-on for AKS](/azure/governance/policy/concepts/policy-for-kubernetes) enabled.
- A policy initiative or individual policy assignments that you apply to the cluster, a resource group, or a subscription. Common assignments include the [Kubernetes cluster pod security baseline standards](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicySetDefinitions%2Fa8640138-9b0a-4a28-b8cb-1666c838647d) and [Kubernetes cluster pod security restricted standards](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicySetDefinitions%2F42b8ef37-b724-4e24-bbc8-7a7708edfe00) initiatives.
- `kubectl` CLI that's configured to access the cluster.
- Azure CLI (`az`), version 2.0.75 or later.

## Policy requirements for node access

Node access always requires a certain level of privilege. Default policies flag these access levels. Even if you don't grant full node access, policies detect access to the file system. In most cases, you have to create exceptions or carefully fine-tune policies based on your requirements.

Although you can specify individual capabilities in the pod's security context without marking the pod as privileged, other policies still apply. You can find a list of these policies in [Azure Kubernetes built-in policy definitions](/azure/governance/policy/samples/built-in-policies#kubernetes). Even if the daemonset's container doesn't trigger the privileged policy, the container still requires access to the host's file system in order to copy agent files and scripts. Consider the requirements of your container and review the policy requirements accordingly.

The following two built-in policies are most commonly triggered when you run a container that uses both privileged mode and added capabilities:

| Policy display name | Default effect | Description |
|---|---|---|
| Kubernetes cluster shouldn't allow privileged containers. | `deny` | Blocks containers that have `privileged: true` in their security context. |
| Kubernetes cluster containers should only use allowed capabilities. | `deny` | Blocks containers that add Linux capabilities that aren't in the allowed list. |

Both policies are evaluated independently. A container that uses `privileged: true` *and* adds capabilities must satisfy both policies simultaneously.

## Identify which policies block the container

Before you change a policy assignment or create an exemption, identify which specific policies cause the denial.

1. Check the Kubernetes events in the affected namespace with a command line interface (CLI) tool like `kubectl`.

```bash
   kubectl get events -n <namespace> --field-selector reason=FailedCreate
```

Azure Policy violations appear as events with a message that resembles the following output:

```output
   Error creating: admission webhook "validation.gatekeeper.sh" denied the request:
   [azurepolicy-k8sazurev2noprivilege-...] Privileged container is not allowed: <container-name>
   [azurepolicy-k8sazureallowedcaps-...] container <container-name> uses a disallowed capability. Allowed capabilities: []
```

2. Check Azure Policy compliance in the [Azure portal](https://portal.azure.com). Go to **Policy** > **Compliance**, filter by the cluster resource, and then review any non-compliant policies.

## Retain privileged mode while adding capabilities

Depending on whether you can modify the policy assignment, use one of the following approaches.

### Option 1: Configure policy assignment parameters (recommended)

If you control the policy assignment (for example, if you assigned the initiative at the resource group level), add the required capabilities to the `allowedCapabilities` parameter of the **Kubernetes cluster containers should only use allowed capabilities** policy.

1. In the Azure portal, go to **Policy** > **Assignments** and locate the assignment that covers the cluster.

2. Select **Edit assignment**, go to the **Parameters** tab, and locate the **Allowed capabilities** parameter.

3. Enter the capabilities that your container requires. The following example allows `NET_ADMIN` and `SYS_PTRACE`.

```json
   {
     "allowedCapabilities": {
       "value": ["NET_ADMIN", "SYS_PTRACE"]
     }
   }
```

4. Select **Review + save**.

If you also assign the **no privileged containers** policy with a `deny` effect, you have two options:

- Change the effect from `deny` to `audit` for that specific assignment. This change reduces enforcement while you assess impact.
- Use the namespace exclusion parameter (`excludedNamespaces`) to exclude the namespace that contains the affected workload.

### Option 2: Use namespace exclusion in the policy assignment

You can exclude specific namespaces from evaluation in most built-in AKS policy definitions. This approach is useful when a single namespace runs a workload that legitimately requires privileged mode and added capabilities.

1. In the Azure portal, go to **Policy** > **Assignments** and locate the assignment.

2. Select **Edit assignment**, go to the **Parameters** tab, and locate the **Namespace exclusions** parameter.

3. Add the namespace name to the excluded list.

```json
   {
     "excludedNamespaces": {
       "value": ["kube-system", "monitoring"]
     }
   }
```

4. Select **Review + save**.

> [!NOTE]
> Excluding a namespace from a policy removes *all* policy protection for pods in that namespace. Use this option only for trusted system namespaces or when a scoped exemption ([Option 3: Create a scoped policy exemption](#option-3-create-a-scoped-policy-exemption)) isn't feasible.

### Option 3: Create a scoped policy exemption

If you can't modify the policy assignment (for example, because a central platform team manages the assignment at the subscription level), create a policy exemption that is scoped to the specific cluster or resource group.

1. Retrieve the policy assignment ID.

```bash
   az policy assignment list --scope "/subscriptions/<subscription-id>" \
     --query "[?displayName=='<assignment-display-name>'].id" -o tsv
```

2. Create the exemption.

```bash
   az policy exemption create \
     --name "allow-privileged-<workload-name>" \
     --policy-assignment "<policy-assignment-id>" \
     --scope "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.ContainerService/managedClusters/<cluster-name>" \
     --exemption-category "Waiver" \
     --description "Allow privileged container with specific capabilities for <workload-name> node agent."
```

3. Verify that the exemption is active.

```bash
   az policy exemption show \
     --name "allow-privileged-<workload-name>" \
     --scope "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.ContainerService/managedClusters/<cluster-name>"
```

## Configure the pod security context

Regardless of which policy option you choose, follow these security best practices from a pod security perspective:

- Use `capabilities.add` to specify only the capabilities that the container actually requires.
- Use `capabilities.drop: [ALL]` to drop all other capabilities.
- Avoid using `privileged: true` unless the container must access host-level resources directly. Consider whether individual capabilities can replace full privileged mode.

The following pod specification shows a daemonset container that retains privileged mode and adds two specific capabilities:

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-agent
  namespace: monitoring
spec:
  selector:
    matchLabels:
      app: node-agent
  template:
    metadata:
      labels:
        app: node-agent
    spec:
      containers:
        - name: node-agent
          image: <your-image>
          securityContext:
            privileged: true
            capabilities:
              add:
                - NET_ADMIN
                - SYS_PTRACE
              drop:
                - ALL
```

> [!IMPORTANT]
> When you use `drop: [ALL]` together with `add`, Kubernetes first drops all capabilities and then re-adds only those that are listed. This process creates the least-privilege profile. Verify that all capabilities that the process requires are explicitly listed in the `add` section.

## Verify the configuration

After you apply the policy changes or the exemption, verify that the pod runs successfully and that no new policy violations appear.

1. Redeploy or restart the affected pods.

```bash
   kubectl rollout restart daemonset/<daemonset-name> -n <namespace>
```

2. Check that the pods are running.

```bash
   kubectl get pods -n <namespace> -l app=<label>
```

3. Confirm that no new policy violation events appear.

```bash
   kubectl get events -n <namespace> --field-selector reason=FailedCreate
```

4. In the Azure portal, go to **Policy** > **Compliance** and confirm that the cluster is now compliant or that the exemption is reflected.

## References

- [Azure Kubernetes built-in policy definitions](/azure/governance/policy/samples/built-in-policies#kubernetes)
- [Understand Azure Policy for Kubernetes clusters](/azure/governance/policy/concepts/policy-for-kubernetes)
- [Configure a security context for a pod or container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
- [Linux capabilities (man page)](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [AKS security concepts: Pod security](/azure/aks/concepts-security#pod-security)
