---
title: Guide to prepare AKS clusters for KEDA 2.14 and 2.15 breaking changes
description: Explores the key breaking changes introduced in KEDA 2.14 and 2.15 and provides a guide on how to prepare your Azure Kubernetes Service (AKS) clusters for these updates. 
ms.service: azure-kubernetes-service
ms.date: 08/13/2024
editor: 
ms.reviewer: 
#Customer intent: As an Azure Kubernetes user, I want to understand changes in Event-driven Autoscaling Add-ons version 2.15 and version 2.14 
ms.custom: sap:Extensions, Policies and Add-Ons
---

# Breaking changes in Event-driven Autoscaling add-ons 2.15 and 2.14

This article explores the key breaking changes introduced in Event-driven Autoscaling (KEDA) add-on 2.14 and 2.15. It also provides information on how to prepare your Azure Kubernetes Service (AKS) clusters for these updates.

## Breaking changes in KEDA 2.14 and 2.15

Your AKS cluster Kubernetes version determines which KEDA version will be installed on your AKS cluster. For AKS clusters running Kubernetes version 1.30, KEDA add-on version 2.14 is installed. The upcoming release of Kubernetes 1.31 on Azure will ship with KEDA add-on version 2.15.

### KEDA 2.15

- [Removal of pod-managed identities support](https://github.com/kedacore/keda/issues/5035). 
    
    If you're using pod-managed identities, we recommend migrating to [workload identity for authentication](/azure/aks/keda-workload-identity).

### KEDA 2.14

- [Removal of Azure Data Explorer 'metadata.clientSecret' as it wasn't safe for managing secrets](https://github.com/kedacore/keda/issues/4514). 

    To ensure safe handling of secrets, use `clientSecretFromEnv` instead.
- [Removal of the deprecated `metricName` from trigger metadata section](https://github.com/kedacore/keda/issues/4240).

    The two impacted Azure Scalers are **Azure Blob Scaler** and **Azure Log Analytics Scaler**. If you're using `metricName`, move `metricName` outside of trigger metadata section to `trigger.name` in the trigger section to optionally name your trigger. The following exmaples show how to update configuration.

     Example before KEDA 2.14

     ```yaml
     triggers:
     - type: any-type
     metadata:
     metricName: "my-custom-name"
     ```

     Example with KEDA 2.14 or 2.15

     ```yaml
     triggers:
     - type: any-type
     name: "my-custom-name"
     metadata:
     ```

## Frequently asked questions

### How can I confirm if my cluster is impacted?

To determine if your cluster is affected by the recent KEDA upgrades, follow these steps:

1. Identify the Kubernetes version of your AKS cluster. 

    Clusters running Kubernetes versions 1.30 or later will be impacted by the KEDA upgrades (2.14 or 2.15). If you're on version 1.29 or earlier, these updates will not affect you. However, if you plan to upgrade your AKS cluster to Kubernetes version 1.30 or 1.31, be sure to review the changes and prepare accordingly before upgrading.
     
    To check the cluster version, run the following the Azure CLI command:

     ```
     az aks show --resource-group <your-resource-group> --name <your-cluster-name> --query kubernetesVersion
     ```
2. Audit KEDA Scalers in use:

    - Review the configurations of KEDA Scalers currently deployed in your cluster.
    - Check if Microsoft Entra pod-managed Identities are used for authentication. The following command will display output if you're using Pod Identity with KEDA:
    
        ```bash
        kubectl get TriggerAuthentication --all-namespaces -o jsonpath='{range .items[?(@.spec.podIdentity.provider=="azure")]}{.metadata.namespace}{"/"}{.metadata.name}{"\n"}{end}'
        ```
3. Review the cluster logs:

    Look for any deprecation warnings or errors related to the removed or changed fields in KEDA, such as `metricName` or `metadata.clientSecret`.

### What steps can I take to mitigate the issues?

1. Migrate from Microsoft Entra pod-managed identities to workload identity for authentication. For more information, see [Use Microsoft Entra Workload ID with AKS](/azure/aks/workload-identity-overview?tabs=dotnet) and [Migrate from pod managed-identity to workload identity](/azure/aks/workload-identity-migrate-from-pod-identity).
2. Update Scaler Configurations to align with the new configuration requirements:

    - For **Azure Data Explorer Scaler**, replace `metadata.clientSecret` with `clientSecretFromEnv`. For more information about the `clientSecretFromEnv` definition, see  [Trigger Specifications](https://keda.sh/docs/2.15/scalers/azure-data-explorer/).
    - For **Azure Blob Scaler** and **Azure Log Analytics Scaler**, move `trigger.metadata.metricName` to `trigger.name`.

3. Test changes in a nonproduction environment. Deploy the updated configurations in a staging or development environment to ensure they work correctly and don't impact your applications.
4. Monitor Logs and Alerts. After making changes, monitor the cluster logs for any warnings or errors related to the new KEDA configuration and behavior.

**How to reach out to support if I have follow-up questions?**

If you have questions or need help, [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot) with the following information:

- **Service**: Kubernetes Service(AKS)
- **Problem type**: Extensions, Polices and Add-Ons
- **Problem subtype**: KEDA (Event driven autoscaling) add-on

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
