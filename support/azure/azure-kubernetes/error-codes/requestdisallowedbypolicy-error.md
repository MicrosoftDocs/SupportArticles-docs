---
title: RequestDisallowedByPolicy Error When Deploying an AKS Cluster
description: Learn how to fix the RequestDisallowedByPolicy error when you create, update, upgrade, or scale an Azure Kubernetes Service (AKS) cluster or node pool.
ms.date: 11/09/2026
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, albarqaw, jacobbaek, v-leedennis, v-weizhu, jenimanda
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# RequestDisallowedByPolicy error when deploying an AKS cluster

## Summary

This article discusses how to identify and resolve the `RequestDisallowedByPolicy` error that occurs when you create, update, upgrade, or scale a Microsoft Azure Kubernetes Service (AKS) cluster or node pool, or when AKS creates resources on your behalf in the node resource group.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), version 2.0.59 or a later version.
- Permission to read Azure Policy assignments and definitions at the scope where the policy is assigned. To create a policy exemption, you need the `Microsoft.Authorization/policyExemptions/write` permission at the exemption scope (for example, the Resource Policy Contributor role).

## Symptoms

When you try to create or update an AKS cluster, you receive an error message that resembles the following:

```output
Code="RequestDisallowedByPolicy"
Message="Resource '<resource-name>' was disallowed by policy. Policy identifiers: '[{"policyAssignment":{"name":"<assignment-display-name>","id":"/subscriptions/<subscription-id>/providers/Microsoft.Authorization/policyAssignments/<assignment-name>"},"policyDefinition":{"name":"<definition-display-name>","id":"/providers/Microsoft.Authorization/policyDefinitions/<definition-name>"}}]'."
```

For more details, see [https://aka.ms/aks-requestdisallowedbypolicy](https://aka.ms/aks-requestdisallowedbypolicy).

The resource that's named in the message isn't always the cluster. It can be the node resource group (`MC_<resource-group>_<cluster-name>_<region>`) or a resource that AKS creates inside that group, such as a virtual machine scale set, public IP address, load balancer, network security group, route table, managed disk, or snapshot. The cluster might be left in a `Failed` provisioning state.

You might also notice one of the following symptoms:

- Cluster or node pool create, upgrade, scale, or update operations fail.
- Enabling an add-on or extension fails (for example, AKS Backup or another extension that creates resources in the node resource group).
- A Kubernetes service of type `LoadBalancer` stays in `Pending` state because the public IP address can't be created, or a `PersistentVolumeClaim` stays in `Pending` state because the managed disk can't be created.

## Cause

For security or compliance, your subscription administrators might assign policies that limit how resources are deployed. For example, your subscription might have a policy that prevents you from creating public IP addresses, network security groups, user-defined routes, or route tables. The error message includes the specific policy assignment and policy definition that blocked the request.

Common policies that block AKS operations include:

- Required tags on resources or resource groups (for example, **Require a tag on resources** or **Require a tag on resource groups** with a `Deny` effect). Resources in the node resource group don't have these tags unless you set them on the cluster or node pool.
- **Not allowed resource types** or **Allowed resource types**.
- **Allowed locations** or **Allowed virtual machine size SKUs**.
- Policies that deny public IP addresses, network security groups, route tables, or public network access.

> [!NOTE]
> Only you can manage the policies in your environment. Microsoft can't disable or bypass those policies.

## Solution

To fix this issue, follow these steps.

### Step 1: Identify the policy assignment and definition

Copy the `policyAssignment` and `policyDefinition` `id` values from the error message. The name of a policy assignment or definition is the last segment of the `id` string. For example:

```output
Code: RequestDisallowedByPolicy
Message: Resource 'resourcegroup' was disallowed by policy. Policy identifiers: '[{"policyAssignment":{"name":"Not allowed resource types","id":"/subscriptions/00000000-0000-0000-0000-000000000000/providers/Microsoft.Authorization/policyAssignments/00000000000000000000000"},"policyDefinition":{"name":"Not allowed resource types","id":"/subscriptions/00000000-0000-0000-0000-000000000000/providers/Microsoft.Authorization/policyDefinitions/not-allowed-resourcetypes","version":"1.0.0"}}]'.
```

If you no longer have the error message, find it in the **Activity log** of the cluster resource group or the node resource group (filter on **Status** = **Failed**), or run the following command:

```azurecli
az monitor activity-log list \
    --resource-group <resource-group> \
    --status Failed \
    --offset 1d \
    --query "[?contains(to_string(properties), 'RequestDisallowedByPolicy')]"
```

### Step 2: Review the policy and its scope

Run the following commands to get details about the policy assignment and the policy definition:

```azurecli
az policy assignment show --name <assignment-name> --scope <assignment-scope>
az policy definition show --name <definition-name>
```

Note the assignment scope (management group, subscription, or resource group), the effect, and the parameters. Then review the `policyRule` section of the definition to see which resource property is evaluated. For more information, see [Resolve errors for request disallowed by policy](/azure/azure-resource-manager/troubleshooting/error-policy-requestdisallowedbypolicy).

### Step 3: Make the deployment compliant (recommended)

Update your deployment to comply with the policy restrictions, and then retry the operation:

- If the policy requires tags, set them on the cluster by using the `--tags` parameter. Cluster tags are applied to the node resource group and to the cluster-related resources in it. Set tags on node pools by using the `--nodepool-tags` parameter of `az aks create` or the `--tags` parameter of `az aks nodepool add` and `az aks nodepool update`. For example:

    ```azurecli
    az aks update \
        --resource-group <resource-group> \
        --name <cluster-name> \
        --tags <tag-name>=<tag-value>
    ```

    For public IP addresses, disks, and files that Kubernetes creates, set tags by using the `service.beta.kubernetes.io/azure-pip-tags` service annotation or the `tags` parameter of the StorageClass. For more information, see [Use Azure tags in AKS](/azure/aks/use-tags).

    > [!IMPORTANT]
    > Setting tags by using `az aks update` or `az aks nodepool update` overwrites the existing set of tags. Include all the tags that you want to keep.

- If the policy restricts SKUs, locations, or resource types, change the deployment parameters to allowed values.

### Step 4: Create a policy exemption (alternative)

If you can't make the deployment compliant, and you have permission to manage policy, create a [policy exemption](/azure/governance/policy/concepts/exemption-structure). Scope the exemption as narrowly as possible, for example, to the node resource group:

```azurecli
az policy exemption create \
    --name <exemption-name> \
    --policy-assignment <assignment-id> \
    --exemption-category Waiver \
    --scope /subscriptions/<subscription-id>/resourceGroups/<node-resource-group>
```

If the assignment is a policy initiative, add the `--policy-definition-reference-ids` parameter to exempt only the definition that blocks the operation.

### Step 5: Reconcile the cluster

After you fix the policy issue, run the following command to change the cluster from a failed state to a successful state. This command reconciles the cluster and retries the last failed operation.

```azurecli
az aks update --resource-group <resource-group> --name <cluster-name>
```

For more information about clusters in a failed state, see [Troubleshoot AKS upgrade, scaling, and failed-state errors](../availability-performance/cluster-node-virtual-machine-failed-state.md).

> [!NOTE]
> `RequestDisallowedByPolicy` is returned by Azure Resource Manager. It's different from a Kubernetes admission denial raised by the Azure Policy add-on for AKS (Gatekeeper). That denial appears when you apply a Kubernetes manifest, and contains `admission webhook "validation.gatekeeper.sh" denied the request`. For that scenario, see [Troubleshoot errors with using Azure Policy](/azure/governance/policy/troubleshoot/general).

## More information

- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)
- [Resolve errors for request disallowed by policy](/azure/azure-resource-manager/troubleshooting/error-policy-requestdisallowedbypolicy)
- [Use Azure tags in AKS](/azure/aks/use-tags)
- [Azure Policy exemption structure](/azure/governance/policy/concepts/exemption-structure)

